# golang-pipeline

## Quick Install
Run the below command to create workflows in your repo.
```bash
curl
```

## Workflows
## Linters:
This is the list of linters you can use in your workflow, you can turn them on/off by declaring their key and value in the workflow.
- [**Staticcheck**](https://github.com/dominikh/go-tools#installation)
A collection of tools and libraries for working with Go code, including linters and static analysis, most prominently staticcheck.
  - default : on
  - key: STATICCHECK
- [**Errcheck**](https://github.com/kisielk/errcheck)
A program for checking for unchecked errors in go programs.
  - default : on
  - key: ERRCHECK
- [**Golint**](https://github.com/golang/lint)
A program for checking for unchecked errors in go programs.
  - default : off
  - key: GOLINT
- [**Misspell**](https://github.com/client9/misspell)
Correct commonly misspelled English words
  - default : off
  - key: MISSPELL

**Example**
```yaml
on: push
name: build
jobs:
  go-pipeline:
    name: Go Checks
    runs-on: ubuntu-latest
    steps:
    - name: go1.11 linter
      uses: shoukoo/golang-pipeline/go1.12/linter/@master
      with:
        GOLINT: on
        MISSPELL: off
```
## Test:
**Example**
```yaml
on: push
name: build
jobs:
  go-pipeline:
    name: Go Checks
    runs-on: ubuntu-latest
    steps:
    - name: go1.11 test
      uses: shoukoo/golang-pipeline/go1.12/test/@master
      env:
        PROJECT_PATH: test
```

## Build:
You need to pass GOOS, GOARCH and GITHUB_TOKEN env variables to allow golang-pipeline to build and deploy binary to a release.
- **GOOS**
is the running program's operating system target: one of darwin, freebsd, linux, and so on.
- **GOARCH**
is the running program's architecture target: one of 386, amd64, arm, s390x, and so on.
- **GITHUB_TOKEN**
Passing the value `${{ secrets.GITHUB_TOKEN }}` to deploy your build

**Exmaple**:
``` yaml
on: release
name: Build on release
jobs:
  build:
    name: Build Go
    runs-on: ubuntu-latest
    steps:
    - name: osx build
      uses: shoukoo/golang-pipeline/go1.12/release/@master
      if: github.event.action == 'published'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOOS: linux
        GOARCH: amd64
    - name: windows build
      uses: shoukoo/golang-pipeline/go1.12/release/@master
      if: github.event.action == 'published'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOOS: windows
        GOARCH: amd64
    - name: linux build
      uses: shoukoo/golang-pipeline/go1.12/release/@master
      if: github.event.action == 'published'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOOS: linux
        GOARCH: amd64
```
