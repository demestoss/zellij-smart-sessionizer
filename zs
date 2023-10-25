#!/usr/bin/env bash

select_project_dir() {
    HOME_REPLACER=""                                          # default to a noop
    echo "$HOME" | grep -E "^[a-zA-Z0-9\-_/.@]+$" &>/dev/null # chars safe to use in sed
    HOME_SED_SAFE=$?
    if [ $HOME_SED_SAFE -eq 0 ]; then # $HOME should be safe to use in sed
        HOME_REPLACER="s|^$HOME/|~/|"
    fi

    project_dir=$(zoxide query -l | fzf --reverse)

    if [ "$project_dir" = "" ]; then # no result
        echo ""
        exit                 # exit silently
    fi

    if [ $HOME_SED_SAFE -eq 0 ]; then
        project_dir=$(echo "$project_dir" | sed -e "s|^~/|$HOME/|") # get real home path back
    fi
    echo "$project_dir"
}

get_session_name() {
    project_dir=$1
    provided_session_name=$2

    directory=$(basename "$project_dir")
    session_name=""
    if [ "$provided_session_name" = "" ]; then
        session_name=$(echo "$directory" | tr ' .:' '_')
    else
        session_name="$provided_session_name"
    fi
    echo "$session_name"
}

get_layouts_list() {
    layout_dir=$(zellij setup --check | grep "LAYOUT DIR" | grep -o '".*"' | tr -d '"')

    if [ "$layout_dir" = "" ]; then
        echo ""
        exit
    fi

    layouts=$(find $layout_dir | tail -n+2)
    echo $layouts
}

select_layout() {
    layouts=$1

    if [ -x "$(command -v bat)" ]; then
        layout_path=$(echo "$layouts" | fzf --reverse --preview 'bat {}')
    else
        layout_path=$(echo "$layouts" | fzf --reverse --preview 'cat {}')
    fi

    if [ "$layout_path" = "" ]; then
        echo ""
        exit
    fi

    layout=$(basename "$layout_path" | sed 's/\.kdl$//')
    echo $layout
}

get_session_layout() {
    layouts=$(get_layouts_list)
    if [ "$layouts" = "" ]; then
        echo "default"
        exit
    fi
    layouts=$(echo "default $layouts" | tr ' ' '\n')
    echo $(select_layout "$layouts")
}

get_tab_layout() {
    layouts=$(get_layouts_list)
    if [ "$layouts" = "" ]; then
        echo "default"
        exit
    fi

    layouts_for_tabs="default"
    for layout in $layouts; do
        # filtering layouts with "tab" keyword to avoid having tabs in tabs
        # Maybe there is a better way to do this
        has_tab=$(cat $layout | grep "tab ")
        if [ "$has_tab" = "" ]; then
            layouts_for_tabs="$layouts_for_tabs $layout"
        fi
    done

    layouts_for_tabs=$(echo "$layouts_for_tabs" | tr ' ' '\n')
    echo $(select_layout "$layouts_for_tabs")
}

zellij_sessionizer_name="Zellij SessionizerZ"

# If we inside Zellij and this is not a Zellij SessionizerZ pane
# We will open floating window with Zellij SessionizerZ command
if [ $ZELLIJ = 0 ] && [$ZELLIJ_SESSION_NAME -ne $zellij_sessionizer_name]; then
    zellij action new-pane -f --name "$zellij_sessionizer_name" -- zs
    exit 0
fi

project_dir=$(select_project_dir)

if [ "$project_dir" = "" ]; then
    exit 0
fi

session_name=$(get_session_name "$project_dir" "$1")

# Outside Zellij session
if [[ -z $ZELLIJ ]]; then
    session=$(zellij list-sessions | grep "^$session_name$")

    cd $project_dir

    if [ "$session" = "" ]; then
        layout=$(get_session_layout)

        if [ "$layout" = "" ]; then
            exit 0
        fi

        zellij -s $session_name --layout $layout options --default-cwd $project_dir
        exit 0
    fi

    zellij attach $session_name -c options --default-cwd $project_dir
    exit 0
fi


layout=$(get_tab_layout)

if [ "$layout" = "" ]; then
    exit 0
fi

zellij action new-tab --layout $layout --name $session_name --cwd $project_dir
zellij action go-to-tab-name $session_name

