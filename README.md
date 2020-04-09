<img src="https://github.com/shoukoo/golang-pipeline/workflows/build/badge.svg" class="image mod-full-width" /> <img src="https://img.shields.io/github/v/release/shoukoo/golang-pipeline?sort=semver" class="image mod-full-width" />

# golang-pipeline
> Important! This Github Action only supports Go Module

## Quick Install
Run the below command to create a push workflow in your repo.
```bash
curl -o- https://raw.githubusercontent.com/shoukoo/golang-pipeline/master/install.sh | bash
```

# Workflows
golang-pipeline supports Go version 1.11, 1.12, 1.13 and 1.14 and each version has its tests, linters and release. 

**Format**
```
shoukoo/golang-pipeline/<Go versions>/<action name>@master
```

**Examples**
```
# Run linters in Go1.11
shoukoo/golang-pipeline/go1.11/linter@master
# Run test in Go1.12
shoukoo/golang-pipeline/go1.12/test@master
# Run release in Go1.13
shoukoo/golang-pipeline/go1.13/release@master
# Run release in Go1.14
shoukoo/golang-pipeline/go1.14/release@master
```

If your Go project is not located at the root of the repo you can also specify environment variable PROJECT_PATH:
```
steps:
- name: go1.12 test
  uses: shoukoo/golang-pipeline/go1.12/test@master
  env:
    PROJECT_PATH: "./my/new/path"
```

# Actions:
## Linters:
This is the list of linters you can use in your workflow, you can turn them on or off by declaring their key and value in the workflow.
- [**Staticcheck**](https://github.com/dominikh/go-tools#installation)
A collection of tools and libraries for working with Go code, including linters and static analysis, most prominently staticcheck.
  - default: on
  - key: STATICCHECK
- [**Errcheck**](https://github.com/kisielk/errcheck)
A program for checking for unchecked errors in go programs.
  - default: on
  - key: ERRCHECK
- [**Golint**](https://github.com/golang/lint)
Golint is more focused with coding style. Golint is in use at Google, and it seeks to match the accepted style of the open source Go project.
  - default: off
  - key: GOLINT

  Additionally you can override default golint path with
  - default: .
  - key: GOLINTPATH
- [**Misspell**](https://github.com/client9/misspell)
Correct commonly misspelt English words
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
    - name: go1.12 linter
      uses: shoukoo/golang-pipeline/go1.12/linter@master
      with:
        GOLINT: on
        GOLINTPATH: pkg/controller
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
    - name: go1.12 test
      uses: shoukoo/golang-pipeline/go1.12/test@master
```

## Release:
This action required GOOS, GOARCH and GITHUB_TOKEN env variables for golang-pipeline to build and deploy binary to a release.
- **GOOS**
is the running program's operating system target: one of darwin, freebsd, linux, and so on.
- **GOARCH**
is the running program's architecture target: one of 386, amd64, arm, s390x, and so on.
- **GITHUB_TOKEN**
use this token -  `${{ secrets.GITHUB_TOKEN }}` to deploy your build

**Exmaple**:
``` yaml
on:
  release:
    types: [published]  
name: Build on release
jobs:
  build:
    name: Build Go
    runs-on: ubuntu-latest
    steps:
      - name: osx build
        uses: shoukoo/golang-pipeline/go1.14/release@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GOOS: darwin
          GOARCH: amd64
      - name: windows build
        uses: shoukoo/golang-pipeline/go1.14/release@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GOOS: windows
          GOARCH: amd64
      - name: linux build
        uses: shoukoo/golang-pipeline/go1.14/release@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GOOS: linux
          GOARCH: amd64
```

## Self-Promotion
Like golang-pipeline? Follow the repository on [GitHub](https://github.com/shoukoo/golang-pipeline) or follow me on [Twitter](https://twitter.com/shoukoo1)
