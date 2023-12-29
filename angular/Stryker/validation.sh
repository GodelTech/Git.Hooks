#!/usr/bin/env bash

## stryker
npm install --global stryker-cli

stryker run projects/$VAR_ANGULAR_PROJECT_NAME/stryker.config.json

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Stryker score '$VAR_ANGULAR_PROJECT_NAME' is lower than 80%.${COLOR_NO}"
    exit 1
fi