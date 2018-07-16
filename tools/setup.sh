#!/bin/sh

GCC_VERSION=`g++ -dumpversion | awk -F. '{printf "%2d%02d%02d", $1,$2,$3}'`
REPO_URL="https://copr-fe.cloud.fedoraproject.org/coprs/rhscl/devtoolset-3/repo/epel-6/rhscl-devtoolset-3-epel-6.repo"

if [ "${GCC_VERSION}" -le 40801 ]; then
	sudo wget ${REPO_URL} --no-check-certificate -O /etc/yum.repos.d/devtools-3.repo
	sudo yum install -y devtoolset-3-gcc devtoolset-3-binutils
	sudo yum install -y devtoolset-3-gcc-c++ devtoolset-3-gcc-gfortran
fi

if [ ! `cat ~/.bashrc | grep 'devtoolset-3' | wc -l` ]; then
	echo 'source scl_source enable devtoolset-3' >> ~/.bashrc
	echo '~/.bashrc Added line \"source scl_source enable devtoolset-3\"'
fi

if [ "${GCC_VERSION}" -le 40801 ]; then
	source scl_source enable devtoolset-3
	echo 'enable devtoolset for g++ 4.8 lator activate'
fi
