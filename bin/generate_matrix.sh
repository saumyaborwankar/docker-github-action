#!/usr/bin/env bash

set -e

# # gives the path of the dockerfiles that have been modified/added in the last commit to main
changed_dockerfile_path=$(git diff --name-only $1 $2 | grep '/Dockerfile$')
# number_of_changed_files=$(git diff --name-only $1 $2 | grep -E '^.*\/submitty\/[^/]+\/[^/]+\/Dockerfile$' | wc -l )
# echo $number_of_changed_files
# Count the number of file paths
total_files=$(echo "${changed_dockerfile_path}" | wc -l)


# json_file="D:\Development\docker-github-action\latest.json"
json_file="./latest.json"

# Read the JSON file into a variable
json_data=$(cat "$json_file")

# Extract values using string manipulation and pattern matching
docker_names=$(echo "$json_data" | grep -o '"docker_name":"[^"]*' | awk -F'"' '{print $4}')
docker_tags=$(echo "$json_data" | grep -o '"tag":"[^"]*' | awk -F'"' '{print $4}')

# Convert latest_docker_names to an array
readarray -t latest_docker_names <<< "$docker_names"
readarray -t latest_docker_tags <<< "$docker_tags"

# # Iterate over the docker_names_array
# for docker_name in "${docker_names_array[@]}"; do
#     echo "Docker Name: $docker_name"
# done

# echo -e "$latest_docker_names\n"

# i dont exactly know why we write include in the json that we are creating for the matrix but if it works it works
# if someone knows let me know. Thanks
echo -n '{\"include\": ['

# loop over the filepaths to make the context and tag for github action
index=0
for file_path in ${changed_dockerfile_path}; do
    if [[ $file_path =~ ^.*/submitty/[^/]+/[^/]+/Dockerfile$ ]]; then

        docker_tag=$(basename $(dirname "$file_path"))
        docker_name=$(basename $(dirname $(dirname "$file_path")))
        university=$(basename $(dirname $(dirname $(dirname "$file_path"))))

        found=false
        for ((i = 0; i < ${#latest_docker_names[@]}; i++)); do
            # echo -e "$i \n"
            # echo "${latest_docker_names[i]} ---- $docker_name" 
            # echo "${latest_docker_tags[i]} ---- $docker_tag"
            if [[ "${latest_docker_names[i]}" == "$docker_name" && "${latest_docker_tags[i]}" == "$docker_tag" ]]; then
            # echo "founnddeddd"
                found=true
                # break
            fi
        done
        # removing the last Dockerfile from the file path
        updated_path=$(echo "$file_path" | sed 's/\/Dockerfile$//')

        if [[ "$found" == true ]]; then
            # echo ""
            echo -n '{\"context\": \""'"$updated_path"'"\", \"dockername\": \""'"$docker_name"'"\", \"tag\" :\""'"$docker_tag"'"\", \"latest\" :\"true\"},' # modularize
        else
            # echo ""
            echo -n '{\"context\": \""'"$updated_path"'"\", \"dockername\": \""'"$docker_name"'"\", \"tag\" :\""'"$docker_tag"'"\", \"latest\" :\"false\"},' # modularize
            # echo -n '{\"context\": \""'"${updated_path}"'"\", \"tags\": \""'"${university}"'"/"'"${docker_name}"'":"'"${docker_tag}"'"\"},' # for 2 names
        fi
        

        # ((index++))
        # if [ "${index}" -ne "${total_files}" ]; then
        #         echo -n "last runnnnnnnnnn"     # Add space if it's not the last run
        # fi
    fi
done

echo -n ']}'


# echo -n '{\"include\":[{\"project\":\"foo\",\"config\":\"Debug\"},{\"project\":\"bar\",\"config\":\"Release\"}]}'
#!/bin/bash

# json_file="D:\Development\docker-github-action\latest.json"

# # Read the JSON file into a variable
# json_data=$(cat "$json_file")

# # Extract values using string manipulation and pattern matching
# docker_names=$(echo "$json_data" | grep -o '"docker_name":"[^"]*' | awk -F'"' '{print $4}')
# tags=$(echo "$json_data" | grep -o '"tag":"[^"]*' | awk -F'"' '{print $4}')

# # Output the extracted values
# echo "Docker Names: $docker_names"
# echo "Tags: $tags"
