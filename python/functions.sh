#!/usr/bin/env bash

#
# adapted from- https://gist.github.com/codysoyland/2198913
#
#  Automatically activate/deactivate/install virtualenv
_virtualenv_auto_activate() {
    # we found a virtualenv (currently only venv) directory to activate
    if [ -e "venv" ]; then
        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/venv" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo Activating virtualenv \"$_VENV_NAME\"...
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source venv/bin/activate

            # venv display is handled via zsh/agnoster template
            #   - uncomment if it doesnt show up
            #
            # _OLD_VIRTUAL_PS1="$PS1"
            # PS1="($_VENV_NAME)$PS1"
            # export PS1
        fi

    # deactivate as soon as we leave
    elif type "deactivate" > /dev/null;  then
        if [ -d "$OLDPWD/venv" ]; then
            _VENV_NAME=$(basename $OLDPWD)
            echo Deactivating virtualenv \"$_VENV_NAME\"...

            deactivate
        fi
    fi
}

export PROMPT_COMMAND=_virtualenv_auto_activate
