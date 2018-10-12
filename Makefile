## vim:set ts=4 st=4 fenc=utf-8:

GOCMD		 = go
GOGET		 = $(GOCMD) get
GOBUILD		 = $(GOCMD) build
_GOPATH		 = $(pwd)

_VER         = devtoolset-3
REPO_URL     = https://copr-fe.cloud.fedoraproject.org/coprs/rhscl/$(_VER)/repo/epel-6/rhscl-$(_VER)-epel-6.repo
TOOLSET_CMD	 = /opt/rh/$(_VER)/enable
TOOLSET_REP  = /etc/yum.repos.d/$(_VER).repo
TOOLSET_LIST =	$(_VER)-gcc $(_VER)-gcc-c++ $(_VER)-binutils

setup: $(TOOLSET_CMD)

$(TOOLSET_CMD): $(TOOLSET_REP)
	@echo "Install $(TOOLSET_LIST) from yum"
	@sudo yum install -y centos-release-scl centos-release-scl-rh
	@sudo yum install -y $(TOOLSET_LIST)

$(TOOLSET_REP):
	@sudo wget $(REPO_URL) --no-check-certificate -O $@ >/dev/null 2>&1
	@echo "Downloading $@...." 

golang:
	@if [ ! `which go` ];then \
		echo "Your system didn't have golang environment"; \
		exit 1; \
	fi

build: golang deps lib/libclient.o

lib/libclient.o: lib/client.go
	GOPATH=$(_GOPATH) $(GOBUILD) -buildmode=c-shared -o lib/libclient.so lib/client.go 

deps:
	GOPATH=$(_GOPATH) $(GOGET) github.com/aws/aws-lambda-go/lambda
