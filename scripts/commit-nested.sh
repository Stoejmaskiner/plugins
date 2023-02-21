#!/bin/bash
#
# This is a hack

set -o pipefail
set -o nounset
set -o errexit

commit_message=$1; shift

submodules=( \
    "../libs/stoej_assets" \
    "../modules/stoej_core" \
    "../modules/stoej_dsp" \
    "../modules/stoej_gui" \
    "../plugins/fp000_texture" \
    "../plugins/fp001_vibe_machine")

# the parent should always be last so that the commit of the
# submodules is added as a change to the parent repo
submodules+=("..")

check_no_detached() (
    cd "${1}"
    maybe_branch="$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)"
    if [[ ${maybe_branch} == "HEAD" ]]; then exit 1; fi
)

stage_all() (
    cd "${1}"
    git add .
    echo "added ${1}"
    sleep 1
)

commit_all() (
    cd "${1}"
    git commit -m "${2}" || true
    echo "committed ${1}"
    sleep 1
)

push_all() (
    cd "${1}"
    git push
    echo "pushed ${1}"
    sleep 1
)

# make sure no heads are in detached state
for value in "${submodules[@]}"
do
    check_no_detached "${value}"
done

# stage all changes
for value in "${submodules[@]}"
do
    stage_all "${value}"
done

# commit all changes
for value in "${submodules[@]}"
do
    commit_all "${value}" "${commit_message}"
done

# push all changes
for value in "${submodules[@]}"
do
    push_all "${value}"
done