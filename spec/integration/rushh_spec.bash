#!/usr/bin/env bash

function fail_spec() {
    echo "failed $1"
    exit
}

# rush_dir=$(git rev-parse --show-toplevel)
./bin/rushh ./spec/integration/test_in.rb

rm ./spec/integration/output
touch ./spec/integration/output

source ./spec/integration/out.sh

test_method_without_args >> ./spec/integration/output
test_method_with_args 'one two three' >> ./spec/integration/output

contents=$(cat ./spec/integration/output)

[[ "$contents" =~ "passed method_without_args" ]] || fail_spec 'method without args'
[[ "$contents" =~ "args: one, two, three" ]] || fail_spec 'method with args'

echo 'success'
