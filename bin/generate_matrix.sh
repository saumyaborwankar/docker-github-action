#!/usr/bin/env bash

set -e

# gives the path of the dockerfiles that have been modified/added in the last commit to main
changed_dockerfile_path=$(git diff --name-only HEAD^ HEAD | grep '/Dockerfile$')

# i dont exactly know why we write include in the json that we are creating for the matrix but if it works it works
# if someone knows let me know. Thanks
echo -n '{"include": ['

# loop over the filepaths
for file_path in ${changed_dockerfile_path}; do
    echo -n "{\"path\": \"${file_path}\"}"
done

echo -n "]}"