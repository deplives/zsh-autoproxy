#!/bin/zsh

function proxy(){
    # Cache the output of scutil --proxy
    __ZSH_AUTOPROXY_SCUTIL_PROXY=$(scutil --proxy)
    
    # Pattern used to match the status
    __ZSH_AUTOPROXY_HTTP_PROXY_ENABLED_PATTERN="HTTPEnable : 1"
    __ZSH_AUTOPROXY_HTTPS_PROXY_ENABLED_PATTERN="HTTPSEnable : 1"

    __ZSH_AUTOPROXY_HTTP_PROXY_ENABLED=$__ZSH_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_AUTOPROXY_HTTP_PROXY_ENABLED_PATTERN]
    __ZSH_AUTOPROXY_HTTPS_PROXY_ENABLED=$__ZSH_AUTOPROXY_SCUTIL_PROXY[(I)$__ZSH_AUTOPROXY_HTTPS_PROXY_ENABLED_PATTERN]

    # http proxy
    if (( $__ZSH_AUTOPROXY_HTTP_PROXY_ENABLED )); then
        __ZSH_AUTOPROXY_HTTP_PROXY_SERVER=${${__ZSH_AUTOPROXY_SCUTIL_PROXY#*HTTPProxy : }[(f)1]}
        __ZSH_AUTOPROXY_HTTP_PROXY_PORT=${${__ZSH_AUTOPROXY_SCUTIL_PROXY#*HTTPPort : }[(f)1]}
        export http_proxy="http://${__ZSH_AUTOPROXY_HTTP_PROXY_SERVER}:${__ZSH_AUTOPROXY_HTTP_PROXY_PORT}"
        export HTTP_PROXY="${http_proxy}"
    fi

    # https_proxy
    if (( $__ZSH_AUTOPROXY_HTTPS_PROXY_ENABLED )); then
        __ZSH_AUTOPROXY_HTTPS_PROXY_SERVER=${${__ZSH_AUTOPROXY_SCUTIL_PROXY#*HTTPSProxy : }[(f)1]}
        __ZSH_AUTOPROXY_HTTPS_PROXY_PORT=${${__ZSH_AUTOPROXY_SCUTIL_PROXY#*HTTPSPort : }[(f)1]}
        export https_proxy="http://${__ZSH_AUTOPROXY_HTTPS_PROXY_SERVER}:${__ZSH_AUTOPROXY_HTTPS_PROXY_PORT}"
        export HTTPS_PROXY="${https_proxy}"
    fi
}


function unproxy() {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
}