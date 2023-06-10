#!/usr/bin/env bash

set -e

# # gives the path of the dockerfiles that have been modified/added in the last commit to main
changed_dockerfile_path=$(git diff --name-only $1 $2 | grep '/Dockerfile$')

# # Count the number of file paths
# total_files=$(echo "${changed_dockerfile_path}" | wc -l)

# # i dont exactly know why we write include in the json that we are creating for the matrix but if it works it works
# # if someone knows let me know. Thanks
# echo -n '{"include": ['

# # loop over the filepaths to make the context and tag for github action
# index=0
# for file_path in ${changed_dockerfile_path}; do
    
#     docker_tag=$(basename $(dirname "$file_path"))
#     docker_name=$(basename $(dirname $(dirname "$file_path")))
#     university=$(basename $(dirname $(dirname $(dirname "$file_path"))))

#     # removing the last Dockerfile from the file path
#     updated_path=$(echo "$file_path" | sed 's/\/Dockerfile$//')

#     echo -n "{\"context\": \"${updated_path}\", \"tags\": \"${university}/${docker_name}:${docker_tag}\"},"
#     # echo -n "{\"version\": \"${docker_name}\", \"adapter\": \"${docker_name}\"}"


#     # ((index++))
#     # if [ "${index}" -ne "${total_files}" ]; then
#     #         echo -n "last runnnnnnnnnn"     # Add space if it's not the last run
#     # fi
# done

# echo -n "]}"


echo -n "{\"include\":[{\"project\":\"foo\",\"config\":\"Debug\"},{\"project\":\"bar\",\"config\":\"Release\"}]}"