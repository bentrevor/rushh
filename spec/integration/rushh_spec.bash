#!/usr/bin/env bash

rush_dir=$(git rev-parse --show-toplevel)
./bin/rushh ./spec/integration/test_in.rb

rm ./spec/integration/output
touch ./spec/integration/output

source ./spec/integration/out.sh
asdf > ./spec/integration/output
