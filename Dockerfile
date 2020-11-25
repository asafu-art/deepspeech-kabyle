FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

ARG ds_repo=mozilla/DeepSpeech
ARG ds_branch=02e4c7624063377cdb711d13a0fc8e901818cf1a
ARG ds_sha1=02e4c7624063377cdb711d13a0fc8e901818cf1a
ARG cc_repo=MestafaKamal/CorporaCreator
ARG kenlm_repo=kpu/kenlm
ARG kenlm_branch=87e85e66c99ceff1fab2500a7c60c01da7315eec

ARG model_language=kab

ARG batch_size=96
ARG n_hidden=2048
ARG epochs=75
ARG learning_rate=0.001
ARG dropout=0.05
ARG lm_alpha=0.65
ARG lm_beta=1.45
ARG beam_width=500
ARG early_stop=1
ARG lm_top_k=500000

ARG amp=0

ARG duplicate_sentence_count=1

ARG lm_evaluate_range=
ARG english_compatible=0

# Make sure we can extract filenames with UTF-8 chars
ENV LANG=C.UTF-8

# Avoid keyboard-configuration step
ENV DEBIAN_FRONTEND noninteractive

ENV HOMEDIR /home/trainer

ENV VIRTUAL_ENV_NAME ds-train
ENV VIRTUAL_ENV $HOMEDIR/$VIRTUAL_ENV_NAME
ENV DS_DIR $HOMEDIR/ds
ENV CC_DIR $HOMEDIR/cc

ENV DS_BRANCH=$ds_branch
ENV DS_SHA1=$ds_sha1

ENV MODEL_LANGUAGE=$model_language

ENV BATCH_SIZE=$batch_size
ENV N_HIDDEN=$n_hidden
ENV EPOCHS=$epochs
ENV LEARNING_RATE=$learning_rate
ENV DROPOUT=$dropout
ENV LM_ALPHA=$lm_alpha
ENV LM_BETA=$lm_beta
ENV BEAM_WIDTH=$beam_width
ENV LM_TOP_K=$lm_top_k

ENV AMP=$amp

ENV DUPLICATE_SENTENCE_COUNT=$duplicate_sentence_count

ENV LM_EVALUATE_RANGE=$lm_evaluate_range
ENV ENGLISH_COMPATIBLE=$english_compatible

ENV EARLY_STOP=$early_stop

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN env

# Get basic packages
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    build-essential \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    ca-certificates \
    cmake \
    libboost-all-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    pkg-config \
    g++ \
    virtualenv \
    unzip \
    pixz \
    sox \
    sudo \
    libsox-fmt-all \
    locales locales-all \
    xz-utils

RUN groupadd -g 999 trainer && \
    adduser --system --uid 999 --group trainer

RUN echo "trainer ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/trainer && \
    chmod 0440 /etc/sudoers.d/trainer

# Below that point, nothing requires being root
USER trainer

WORKDIR $HOMEDIR

RUN wget -O - https://gitlab.com/libeigen/eigen/-/archive/3.2.8/eigen-3.2.8.tar.bz2 | tar xj

RUN git clone https://github.com/$kenlm_repo.git && cd kenlm && git checkout $kenlm_branch \
    && mkdir -p build \
    && cd build \
    && EIGEN3_ROOT=$HOMEDIR/eigen-eigen-07105f7124f9 cmake .. \
    && make -j

WORKDIR $HOMEDIR

RUN virtualenv --python=/usr/bin/python3 $VIRTUAL_ENV_NAME

RUN git clone https://github.com/$ds_repo.git $DS_DIR

WORKDIR $DS_DIR

RUN git checkout $ds_branch

WORKDIR $DS_DIR

RUN pip install --upgrade pip==20.0.2 wheel==0.34.2 setuptools==46.1.3
RUN DS_NOTENSORFLOW=y pip install --upgrade --force-reinstall -e .
RUN pip install --upgrade tensorflow-gpu==1.15.2


RUN python util/taskcluster.py \
	--target="$(pwd)" \
	--artifact="native_client.tar.xz" && ls -hal generate_scorer_package 


RUN TASKCLUSTER_SCHEME="https://community-tc.services.mozilla.com/api/index/v1/task/project.deepspeech.tensorflow.pip.%(branch_name)s.%(arch_string)s/artifacts/public/%(artifact_name)s" python3 util/taskcluster.py \
	--target="$(pwd)" \
	--artifact="convert_graphdef_memmapped_format" \
	--branch="r1.15" && chmod +x convert_graphdef_memmapped_format

WORKDIR $HOMEDIR

RUN git clone https://github.com/$cc_repo.git $CC_DIR

WORKDIR $CC_DIR

# Copy copora patch
COPY --chown=trainer:trainer corpora.patch $CC_DIR

RUN patch -p1 < corpora.patch

# Avoid "error: pandas 1.1.0 is installed but pandas==1.1.4 is required by {'modin'}"
RUN pip install pandas==1.1.4

# error: parso 0.8.0 is installed but parso<0.8.0,>=0.7.0 is required by {'jedi'}
RUN pip install parso==0.7.0

RUN python3 setup.py install 

WORKDIR $HOMEDIR

ENV PATH="$HOMEDIR/kenlm/build/bin/:$PATH"

# Copy now so that docker build can leverage caches
COPY --chown=trainer:trainer run.sh checks.sh corpora.patch package.sh $HOMEDIR/

COPY --chown=trainer:trainer ${MODEL_LANGUAGE}/* $HOMEDIR/${MODEL_LANGUAGE}/

COPY --chown=trainer:trainer ${MODEL_LANGUAGE}/data_kab/* $HOMEDIR/${MODEL_LANGUAGE}/data_kab/

ENTRYPOINT "$HOMEDIR/run.sh"
