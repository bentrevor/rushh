#!/usr/bin/env bash

rush_dir=$(git rev-parse --show-toplevel)
./bin/rushh ./spec/integration/test_in.rb

rm ./spec/integration/output
touch ./spec/integration/output

source ./spec/integration/out.sh

test_method_without_args >> ./spec/integration/output

contents=$(cat ./spec/integration/output)

if [[ "$contents" =~ "passed method_without_args" ]]; then
    echo "pass"
else
    echo "fail"
fi
