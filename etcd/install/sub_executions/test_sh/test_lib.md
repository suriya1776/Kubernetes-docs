
Usage explained in [set.md](../build_sh/set.md)
```
set -euo pipefail
```



ROOT_MODULE variable is set
``` 
ROOT_MODULE="go.etcd.io/etcd" 
```


go list by itself typically returns the import path of the package that is located in the directory where the command is run. The import path is a string that represents how the package would be imported in Go code (e.g., github.com/user/project/package).


Check the import path in go.mod in the current dir or from anu parent dir and append the relative path of dir where the shell script is executed

module is module go.etcd.io/etcd/v3
```
if [[ "$(go list)" != "${ROOT_MODULE}/v3" ]]; then
  echo "must be run from '${ROOT_MODULE}/v3' module directory"
  exit 255
fi
```

Here this if loop check if the execution is triggered from root directory , if not will exit the loop with the error.


### Root dir function execution

```
function set_root_dir {
  ETCD_ROOT_DIR=$(go list -f '{{.Dir}}' "${ROOT_MODULE}/v3")
}

set_root_dir
```
The command  is executed, and it returns the directory path where the specified module (${ROOT_MODULE}/v3) is located.

ex-output - D:\CodeSpace\EclipseWS\etcd


### Color codes

COLOR_RED='\033[0;31m'
COLOR_ORANGE='\033[0;33m'
COLOR_GREEN='\033[0;32m'
COLOR_LIGHTCYAN='\033[0;36m'
COLOR_BLUE='\033[0;94m'
COLOR_MAGENTA='\033[95m'
COLOR_BOLD='\033[1m'
COLOR_NONE='\033[0m' # No Color


### Determine go version

```
function determine_go_version {
  GO_VERSION="${GO_VERSION:-"$(cat "${ETCD_ROOT_DIR}/.go-version")"}"
  if [ "${GOTOOLCHAIN:-auto}" != 'auto' ]; then
    # no-op, just respect GOTOOLCHAIN
    :
  elif [ -n "${FORCE_HOST_GO:-}" ]; then
    export GOTOOLCHAIN='local'
  else
    GOTOOLCHAIN="go${GO_VERSION}"
    export GOTOOLCHAIN
  fi
}

determine_go_version

```

GO_Version is fetched from the file present in the root directory and assigned to GO_VERSION

If case checks if GOTOOLCHAIN is not equal to auto, here it is not even set, so it is skipped

Entering else loop, GOTOOLCHAIN is go_$VERSION, and the variable is exported.


### Functions loaded 

[function file](../build_sh/test_lib_function.txt)








