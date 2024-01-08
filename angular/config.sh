#!/usr/bin/env bash

## angular
if ! [[ -z $VAR_PROJECT_NAME ]]; then
    VAR_ANGULAR_PROJECT_NAME=$VAR_PROJECT_NAME
fi

VAR_ANGULAR_BUILD_CONFIGURATION="production"
VAR_ANGULAR_TSC_FAIL_ON_ERROR=true
VAR_ANGULAR_VALIDATION_FAIL_ON_OUTDATED=false