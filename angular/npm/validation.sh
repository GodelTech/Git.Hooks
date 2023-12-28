#!/usr/bin/env bash

## check outdated packages
npm outdated

if [[ $? -ne 0 && $VAR_ANGULAR_VALIDATION_FAIL_ON_OUTDATED = true ]]; then
    echo -e "${COLOR_RED}Outdated packages found.${COLOR_NO}"
    exit 1
fi

## check vulnerable packages
npm audit

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Vulnerable packages found.${COLOR_NO}"
    exit 1
fi