#!/usr/bin/env bash

function run_spec() {
    spec_name=$1
    contents=$2
    output=$(cat ./spec/integration/output)

    if [[ "$output" =~ "$contents" ]]; then
        printf "$(tput setaf 10).$(tput sgr0)"
    else
        echo "failed $spec_name"
        exit
    fi
}

./bin/rushh -i ./spec/integration/test_in.rb -o ./spec/integration/out.sh

echo '' > ./spec/integration/output

source ./spec/integration/out.sh

test_method_without_args >> ./spec/integration/output
test_method_with_args one two three >> ./spec/integration/output


run_spec "method without args" "passed method_without_args"
run_spec "method with args" "args: one, two, three"

echo "
success"
