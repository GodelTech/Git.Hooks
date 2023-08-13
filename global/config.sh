#!/usr/bin/env bash

# enable colors
if [[ $USE_COLORS = true || $USE_COLOURS = true ]]; then
    COLOR_RED="\033[0;31m"
    COLOR_GREEN="\033[1;32m"
    COLOR_YELLOW="\033[1;33m"
    COLOR_NO="\033[0m" # No Color
else
    VAR_TERRAFORM_OUTPUT_NO_COLOR="-no-color"
fi

# global
VAR_GIT_HOOKS_TEMPLATES_DEFAULT_PATH="../"

if [[ -z $VAR_GIT_HOOKS_TEMPLATES_PATH ]]; then
    VAR_GIT_HOOKS_TEMPLATES_PATH=$VAR_GIT_HOOKS_TEMPLATES_DEFAULT_PATH
fi

VAR_PROTECT_MAIN=true
VAR_CHECK_UNCOMMITTED_FILES=true

# terraform
VAR_TERRAFORM_ENV_FOLDER_PATHS=("dev" "test" "prod")