# ETCD build shell

set -euo pipefail [code explanation](../sub_executions/test_sh/set.md)

source ./scripts/test_lib.sh [code explantion](../sub_executions/test_sh/test_lib.md)



This command returns the SHA of the latest commit (HEAD) in the current Git repository, stores in variable GIT_SHA

```
GIT_SHA=$(git rev-parse --short HEAD || echo "GitNotFound")
```

Failpoint is not set , so the If loop is ignored
```
if [[ -n "${FAILPOINTS:-}" ]]; then
  GIT_SHA="$GIT_SHA"-FAILPOINTS
fi
```

ROOT_MODULE variable is set in [test_lib.txt](../variables/test_lib.txt)
```
VERSION_SYMBOL="${ROOT_MODULE}/api/v3/version.GitSHA"
```

### GOOS and GOARCH variables

Will getch the OS and Architecture of the machine, Ex - windows-amd64

```
GOOS=${GOOS:-$(go env GOOS)}
GOARCH=${GOARCH:-$(go env GOARCH)}
```

CGO_Enabled is 0
```
CGO_ENABLED="${CGO_ENABLED:-0}"
```

### Toggle failpoints default

toogle failpoint default function is called, mode is set as disable and execution will not enter if loop,
hence toggle_failpoints function is called with disable argument
```
toggle_failpoints_default() {
  mode="disable"
  if [[ -n "${FAILPOINTS:-}" ]]; then mode="enable"; fi
  toggle_failpoints "$mode"
}
```

### Toggle failpoints

- mode is disable from the first argument
- Execution will not enter inside any if loops of this function

```
  mode="$1"
  if command -v gofail >/dev/null 2>&1; then
    run gofail "$mode" server/etcdserver/ server/lease/leasehttp server/mvcc/ server/wal/ server/mvcc/backend/
    if [[ "$mode" == "enable" ]]; then
      go get go.etcd.io/gofail@"${GOFAIL_VERSION}"
      cd ./server && go get go.etcd.io/gofail@"${GOFAIL_VERSION}"
      cd ../etcdutl && go get go.etcd.io/gofail@"${GOFAIL_VERSION}"
      cd ../etcdctl && go get go.etcd.io/gofail@"${GOFAIL_VERSION}"
      cd ../tests && go get go.etcd.io/gofail@"${GOFAIL_VERSION}"
      cd ../
    else
      go mod tidy
      cd ./server && go mod tidy
      cd ../etcdutl && go mod tidy
      cd ../etcdctl && go mod tidy
      cd ../tests && go mod tidy
      cd ../
    fi
  elif [[ "$mode" != "disable" ]]; then
    log_error "FAILPOINTS set but gofail not found"
    exit 1
  fi

```

### Build etcd function

- If loop checks if the build sh process is still running, if yes entering the loop
- etcd_build function is called, function execution is discussed in detail below
- If the errors is null, success status is logged or else failure status is logged.

```
if echo "$0" | grep -E "build(.sh)?$" >/dev/null; then
  if etcd_build; then
    log_success "SUCCESS: etcd_build (GOARCH=${GOARCH})"
  else
    log_error "FAIL: etcd_build (GOARCH=${GOARCH})"
    exit 2
  fi
fi
```

### etcd_build 

- out="bin": The default output directory for the built binaries is set to bin.
- If the BINDIR environment variable is set and not empty, the output directory is overridden with its value.
- In the below case bin remains the output directory

```
out="bin"
if [[ -n "${BINDIR:-}" ]]; then out="${BINDIR}"; fi
```

- toogle failpoint function is called, function is called before same will happen now

```
toggle_failpoints_default
```

- Below code will compile the source code and generate the binary for etcd, same way it is done for etcdutl and etcdctl

```
run rm -f "${out}/etcd"
(
  cd ./server
  run env "${GO_BUILD_ENV[@]}" go build ${GO_BUILD_FLAGS:-} \
    -trimpath \
    -installsuffix=cgo \
    "-ldflags=${GO_LDFLAGS[*]}" \
    -o="../${out}/etcd" . || return 2
) || return 2

```
- The output for above code

```
% 'rm' '-f' 'bin/etcd'
% (cd server && 'env' 'CGO_ENABLED=0' 'GO_BUILD_FLAGS=' 'GOOS=linux' 'GOARCH=amd64' 'go' 'build' '-trimpath' '-installsuffix=cgo' '-ldflags=-X=go.etcd.io/etcd/api/v3/version.GitSHA=82994d168' '-o=../bin/etcd' '.')
stderr: go: downloading github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da

```

