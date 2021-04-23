#!/usr/bin/env bash

# generate change log for a git project
# it will get all tags in format semver(vX.X.X)
# search in commit format conventionalcommits
# check de next tag and print change log

first_version="v0.0.0"

change_log() {
    git log \
        $1..$2 \
        --grep '^(revert: )?(feat(ure)?|fix|doc[s]?|style|refactor|perf|test|chore)(\(.+\))?: .{1,50}' \
        --no-merges \
        --pretty="%h %s <%an>"
}

bump() {
    local tag="$1"
    local type="$2"

    version=${tag##v}
    OIFS="$IFS";IFS=.;set -- $version; major=$1; minor=$2; patch=$3; IFS="$OIFS";set --
    case "$type" in
        "major") major="$((major + 1))"; minor=0; patch=0 ;;
        "minor") minor="$((minor + 1))"; patch=0 ;;
        *) patch="$((patch + 1))" ;;
    esac
    printf "v%s.%s.%s" "$major" "$minor" "$patch"
}

get_bump() {
    local value="patch"
    while read -r line; do
        if [[ $line =~ ^.*BREAKING\ CHANGE.*$ ]]; then
            value="major"
            break
        elif [[ $line =~ ^[[:alnum:]]{7}\ [[:alnum:]]+(\([[:alnum:]]+\))?!:\ .*$ ]]; then
            value="major"
            break
        elif [[ $line =~ ^[[:alnum:]]{7}\ feat(ure)?(\(.+\))?:\ .*$ ]]; then
            value="minor"
            break
        fi
    done <<< "$1"
    printf "%s" "$value"
}

get_chglog() {
    from_tag="$1"
    to_tag="$2"
    first_tag=$(git rev-list --max-parents=0 --abbrev=0 HEAD)

    [ "$from_tag" == "first" ] && from_tag=$first_tag
    [ -z "$from_tag" ] && from_tag=$(git describe --tags --abbrev=0 --match "v*" 2> /dev/null || echo $first_tag)
    [ -z "$to_tag" ] && to_tag="HEAD"
    chlog="$(change_log $from_tag $to_tag)"

    new_tag=$to_tag
    if [ "$to_tag" == "HEAD" ]; then
        new_tag=$from_tag
        if [ "$new_tag" == "$first_tag" ]; then
            new_tag=$first_version
        else
            bump_type=$(get_bump "$chlog")
            new_tag=$(bump $new_tag $bump_type)
        fi
    fi

    printf "%s..%s\n" "$from_tag" "$new_tag"
    printf "$chlog\n"
}

if [ "$1" == "full" ]; then
    mapfile -t tags < <( git tag -l "v*")
    for (( i=${#tags[@]}-1 ; i>=0 ; i-- )) ; do
        from=${tags[$i]}
        to=${tags[($i + 1)]}
        get_chglog "$from" "$to"
    done
else
    get_chglog "$1" "$2"
fi
