#!/bin/sh

set -xe

export PATH=$(dirname "$0"):$PATH

env

export TMP=/mnt/tmp
export TEMP=/mnt/tmp

sudo /sbin/ldconfig

${MODEL_LANGUAGE}/run.sh

package.sh