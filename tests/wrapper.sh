#!/bin/bash
mkdir -p build-test; cp contracts/* tests/* build-test; perl -pi -e 's|../contracts/||' build-test/*; remix-tests build-test

