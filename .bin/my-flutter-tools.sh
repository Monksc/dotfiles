#!/usr/bin/env bash

__ScriptVersion="1.0.0"

#===  FUNCTION  ================================================================
#         NAME:  plugin
#  DESCRIPTION:  plugins function
#===============================================================================
function plugin() {

    #===  FUNCTION  ================================================================
    #         NAME:  usage
    #  DESCRIPTION:  Display usage information.
    #===============================================================================
    function usage ()
    {
        echo "Usage :  $0 [options] [--]

        Options:
        -l|list       Display list of options
        -a|apply      Shows file name given an import
        -h|help       Display this message
        -v|version    Display script version"

    }    # ----------  end of function usage  ----------

    #===  FUNCTION  ================================================================
    #         NAME:  list
    #  DESCRIPTION:  list plugins
    #===============================================================================
    function list() {
        cat .flutter-plugins | tail -n +2 | awk -v FS='=' '{print $1}'
    }

    #===  FUNCTION  ================================================================
    #         NAME:  getFileName
    #  DESCRIPTION:  Gets the filename of an import statement
    #===============================================================================
    function getFileName() {
        package=${1#*package:}
        filename=${package#*/}
        filename=${filename%\'*}
        package=${package%%/*}
        url=$(cat .dart_tool/package_config.json | jq .packages | \
            jq '.[] | select(.name=="'"$package"'")' | jq .rootUri)
        if [ "${url:0:9}" == '"file:///' ]; then
            url=${url:8:-1}
        else
            #url=${url:1:-2}
            url="."
        fi
        packageuri=$(cat .dart_tool/package_config.json | jq .packages | \
            jq '.[] | select(.name=="'"$package"'")' | jq .packageUri)
        packageuri=${packageuri:1:-1}

        printf "%s/%s%s" $url $packageuri $filename

        #cat .flutter-plugins | tail -n +2 | awk -v FS='=' \
            #'$1=="'"$package"'"{print $2 "lib/'"$filename"'"}'
    }

    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    while getopts "a:lhv" opt
    do
      case $opt in

        l|list     )  list; exit 0 ;;

        a|apply    )  getFileName "$OPTARG"; exit 0 ;;

        h|help     )  usage; exit 0 ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0 ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
              usage; exit 1   ;;

      esac
    done
    shift $(($OPTIND-1))

    echo "DONE $@"
}

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    plugin        plugin -h for more info
    -h|help       Display this message
    -v|version    Display script version"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

if [ "$1" == 'plugin' ]; then
    plugin "${@: 2}"
    exit 0
fi

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

usage
