#!/bin/bash

sed -i 's/[\t ]*$//g' $1

sed -i 's/$/&\n/g' $1

echo "seqB_deltabAddenter.sh runs over."
