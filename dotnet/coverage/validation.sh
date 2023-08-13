#!/usr/bin/env bash

check_dotnet_coverage ()
{
    local xml_attribute=$1
    local validate=$2
    local file=$3
    local min=$4

    if [[ $validate = false ]]; then
        return
    fi

    local xml=$(<$file)
    local coverage_xml=$(grep -Po '(?<=<coverage).*(?=>)' <<< $xml)
    local str_value=$(grep -Po "(?<=${xml_attribute}=\").*?(?=\")" <<< $coverage_xml)

    awk -v a=$str_value -v b=$min ' BEGIN { if ( a > b / 100 ) exit 0; else exit 1 } '

    if [[ $? -ne 0 ]]; then
        exit 1
    fi
}

## merge coverage
dotnet tool install --global dotnet-coverage
mkdir -p TestResults
dotnet-coverage merge *.cobertura.xml --recursive --output TestResults/merged.cobertura.xml --output-format cobertura

## check line coverage
( check_dotnet_coverage "line-rate" true "TestResults/merged.cobertura.xml" $VAR_DOTNET_CODE_COVERAGE_LINE_MIN )

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Line code coverage is lower than $VAR_DOTNET_CODE_COVERAGE_LINE_MIN%.${COLOR_NO}"
    exit 1
fi

## check line coverage
( check_dotnet_coverage "branch-rate" true "TestResults/merged.cobertura.xml" $VAR_DOTNET_CODE_COVERAGE_BRANCH_MIN )

if [[ $? -ne 0 ]]; then
    echo -e "${COLOR_RED}Branch code coverage is lower than $VAR_DOTNET_CODE_COVERAGE_BRANCH_MIN%.${COLOR_NO}"
    exit 1
fi