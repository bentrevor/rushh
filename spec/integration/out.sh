#!/usr/bin/env bash

# This is a generated file - you probably don't need to edit this by hand
function test_method_without_args() {
    ruby -e 'load "./spec/integration/test_in.rb"; test_method_without_args'
}
function test_method_with_args() {
    ruby -e "$(echo 'load "./spec/integration/test_in.rb"; test_method_with_args("' $@ '")')"
}
