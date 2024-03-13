function install_template() {
  repo_name_with_git=$(basename "$argc_repo")
  repo_name="${repo_name_with_git%.git}"

  echo_green "##########################################"
  echo_url "Project name:" $argc_name
  echo_url "Repository URL:" $argc_repo
  echo_url "Repository Name:" $repo_name
  echo_url "Path:" $argc_path
  echo_green "##########################################"

  cd $INFRA_PATH
  rm -r -f $INFRA_PATH/$repo_name
  git clone --quiet $argc_repo >/dev/null

  echo_white "Checking if the template exists on repository..."
  PROJECT_DIRECTORY=$repo_name/$argc_path/$argc_name
  if [ ! -d "$PROJECT_DIRECTORY" ]; then
    echo "$(tput setaf 1) Project does not exists on repository"
    rm -rf $INFRA_PATH/$repo_name
    exit 1
  fi
  echo_white "Template exists!"

  cd $repo_name/$argc_path

  echo_white "Cleaning old directories: template or $argc_name from projects"
  rm -r -f $SOURCE_PATH/project/template
  rm -r -f $SOURCE_PATH/project/$argc_name

  echo_white "Moving template to the projects directory"
  mv -n -f $argc_name/template $SOURCE_PATH/project
  mv $SOURCE_PATH/project/template $SOURCE_PATH/project/$argc_name

  echo_white "Updating euclid.json project_name"
  contents="$(jq --arg PROJECT_NAME "$argc_name" '.project_name = $PROJECT_NAME' $ROOT_PATH/euclid.json)" &&
    echo -E "${contents}" > $ROOT_PATH/euclid.json

  rm -r -f $INFRA_PATH/$repo_name
}