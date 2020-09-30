#!/bin/sh

set -xe

THIS=$(dirname "$0")
export PATH=${THIS}:${THIS}/${MODEL_LANGUAGE}:$PATH

export TF_CUDNN_RESET_RND_GEN_STATE=1

env

checks.sh

export TMP=/mnt/tmp
export TEMP=/mnt/tmp

${MODEL_LANGUAGE}/run.sh

$HOMEDIR/package.sh