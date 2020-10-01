#!/bin/sh

set -xe

THIS=$(dirname "$0")
export PATH=${THIS}:${THIS}/${MODEL_LANGUAGE}:$PATH

export TF_CUDNN_RESET_RND_GEN_STATE=1

env

checks.sh

export TMP=/mnt/tmp
export TEMP=/mnt/tmp

. ${MODEL_LANGUAGE}/params.sh

if [ -x "${MODEL_LANGUAGE}/metadata.sh" ]; then
	echo "run metadata"	
	. ${MODEL_LANGUAGE}/metadata.sh
else
	echo "Please prepare metadata informations."
	exit 1
fi;

${MODEL_LANGUAGE}/run.sh

$HOMEDIR/package.sh