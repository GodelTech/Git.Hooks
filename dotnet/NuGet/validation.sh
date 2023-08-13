#!/usr/bin/env bash

check_dotnet_packages ()
{
    local option_command=$1
    local validate=$2
    local include_transitive=$3

    if [[ $validate = false ]]; then
        return
    fi

    if [[ -z $include_transitive || $include_transitive = true ]]; then
        local option_include_transitive="--include-transitive"
    fi

    local json=$(dotnet list package $option_command $option_include_transitive --format json)

    if [[ "$json" =~ .*"\"topLevelPackages\": [".* || ( $include_transitive = true && "$json" =~ .*"\"transitivePackages\": [".* ) ]]; then
        dotnet list package $option_command $option_include_transitive
        exit 1
    fi
}

## check outdated packages
( check_dotnet_packages "--outdated" $VAR_DOTNET_CHECK_NUGET_OUTDATED_PACKAGES $VAR_DOTNET_CHECK_NUGET_OUTDATED_PACKAGES_INCLUDE_TRANSITIVE )

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Outdated packages found.${COLOR_NO}"
    exit 1
fi

## check deprecated packages
( check_dotnet_packages "--deprecated" $VAR_DOTNET_CHECK_NUGET_DEPRECATED_PACKAGES $VAR_DOTNET_CHECK_NUGET_DEPRECATED_PACKAGES_INCLUDE_TRANSITIVE )

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Deprecated packages found.${COLOR_NO}"
    exit 1
fi

## check vulnerable packages
( check_dotnet_packages "--vulnerable" $VAR_DOTNET_CHECK_NUGET_VULNERABLE_PACKAGES $VAR_DOTNET_CHECK_NUGET_VULNERABLE_PACKAGES_INCLUDE_TRANSITIVE )

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Vulnerable packages found.${COLOR_NO}"
    exit 1
fi