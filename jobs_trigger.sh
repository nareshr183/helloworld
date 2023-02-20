#!/bin/bash

LAST_NEW_BRANCH_COMMIT=$(git log --name-status HEAD^..HEAD --pretty=oneline | awk 'FNR==1 {print $1}')
LAST_PAREN_COMMIT=$(git rev-list --simplify-by-decoration -2 HEAD | awk 'FNR==2')
folders=`git diff --name-only $LAST_NEW_BRANCH_COMMIT $LAST_PAREN_COMMIT | sort -u | awk 'BEGIN {FS="/"} {print $1}' | uniq`
echo $folders

read -d ' ' -a changed_folders <<< "$folders"

echo $changed_folders

for i in "${changed_folders[@]}"
do
  if [[ "$i" == "action" ]]; then
    echo "Found action!"
    	#curl -X POST -u "api_token:$api_token" "$jenkins_url/job/$action_job_name/buildWithParameters?param1=action_param1&param2=action_param2"
  elif [[ "$i" == "bijenkorf" ]]; then
    echo "Found bijenkorf!"
  	#curl -X POST -u "api_token:$api_token" "$jenkins_url/job/$bijenkorf_job_name/buildWithParameters?param1=$bijenkorf_param1&param2=$bijenkorf_param2"
  elif [[ "$i" == "cleavis" ]]; then
    echo "Found cleavis!"
    	#curl -X POST -u "api_token:$api_token" "$jenkins_url/job/$cleavis_job_name/buildWithParameters?param1=$cleavis_param1&param2=$cleavis_param2"
  else
    echo "Did not find action, bijenkorf, or cleavis."
    
  fi
done

