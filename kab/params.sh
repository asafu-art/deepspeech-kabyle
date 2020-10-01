#!/bin/sh

set -xe

export IMPORTERS_VALIDATE_LOCALE="--validate_label_locale $HOME/${MODEL_LANGUAGE}/validate_label.py"

export CV_RELEASE_FILENAME="kab.tar.gz"
export CV_RELEASE_SHA256="9fff3fb5ecdd5c443146a10bc14fca6707213024bc1eba5fe2455578122dd7f4"

export LM_ICONV_LOCALE="kab_KAB.UTF-8"
export MODEL_EXPORT_SHORT_LANG=""
export MODEL_EXPORT_LONG_LANG=""
export MODEL_EXPORT_ZIP_LANG="kab-kab"
