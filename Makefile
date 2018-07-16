## vim:set ts=4 st=4 fenc=utf-8:

_VER        := devtoolset-3
REPO_URL    := https://copr-fe.cloud.fedoraproject.org/coprs/rhscl/$(_VER)/repo/epel-6/rhscl-$(_VER)-epel-6.repo
TOOLSET_REP := /etc/yum.repos.d/$(_VER).repo
TOOLSET_LIST := $(_VER)-binutils $(_VER)-gcc $(_VER)-gcc-c++

setup: $(TOOLSET_REP)

$(TOOLSET_REP):
	@sudo wget $(REPO_URL) --no-check-certificate -O $@ >/dev/null 2>&1
	@echo "Downloading $@...." 
	@sudo yum install -y $(TOOLSET_LIST) > /dev/null 2>&1 
	@echo "Install $(TOOLSET_LIST) from yum"

build: lib/libclient.o

lib/libclient.o: lib/client.go
	go build -buildmode=c-shared -o lib/libclient.so lib/client.go 
