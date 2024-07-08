#!/usr/bin/env bash

## stryker
dotnet tool install --global dotnet-stryker

if [[ -z $VAR_DOTNET_STRYKER_PROJECT_PATHS ]]; then
    ( dotnet stryker --mutation-level $VAR_DOTNET_STRYKER_MUTATION_LEVEL --break-at $VAR_DOTNET_STRYKER_SCORE_MIN --since:$VAR_DOTNET_STRYKER_SINCE_BRANCH )

    if [[ $? -ne 0 ]]; then
        echo -e "${COLOR_RED}Stryker score '$projectPath' is lower than $VAR_DOTNET_STRYKER_SCORE_MIN.${COLOR_NO}"
        exit 1
    fi
else
    for projectPath in ${VAR_DOTNET_STRYKER_PROJECT_PATHS[@]}; do
        ( cd $projectPath && dotnet stryker --mutation-level $VAR_DOTNET_STRYKER_MUTATION_LEVEL --break-at $VAR_DOTNET_STRYKER_SCORE_MIN --since:$VAR_DOTNET_STRYKER_SINCE_BRANCH )

        if [[ $? -ne 0 ]]; then
            echo -e "${COLOR_RED}Stryker score '$projectPath' is lower than $VAR_DOTNET_STRYKER_SCORE_MIN.${COLOR_NO}"
            exit 1
        fi
    done
fi