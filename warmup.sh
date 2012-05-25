#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root!" 1>&2
   exit 1
fi

# This should follow what is on the following website.
ME=`basename $0`

if [[ `cat /etc/issue | grep -i "ubuntu"` ]] ; then
    PKGS="gcc git pep8 pylint python python-dev python-iniparse python-pip python-progressbar python-yaml"
    PIPS="netifaces termcolor"
    APT="apt-get -y -qq"
    PIP="pip -q"
    # Now do it!
    echo "Preparing ANVIL for ubuntu."
    echo "Installing packages: $PKGS"
    $APT install $PKGS
    echo "Installing pypi packages: $PIPS"
    $PIP install netifaces termcolor --upgrade
elif [[ `cat /etc/issue | grep -i "red hat enterprise.*release.*6.*"` ]] ; then
    EPEL_RPM="epel-release-6-6.noarch.rpm"
    PKGS="gcc git pylint python python-netifaces python-pep8 python-pip python-progressbar PyYAML"
    PIPS="termcolor iniparse"
    PIP="pip-python -q"
    YUM="yum install -q -y"
    WGET="wget -q"
    # Now do it!
    echo "Preparing ANVIL for RHEL 6"
    echo "Fetching epel rpm: $EPEL_RPM"
    TMP_DIR=`mktemp -d`
    URI="http://download.fedoraproject.org/pub/epel/6/i386/$EPEL_RPM -O $TMP_DIR/$EPEL_RPM"
    $WGET $URI
    if [ "$?" -ne "0" ]; then
        echo "Sorry, stopping since download from $URI failed."
        exit 1
    fi
    echo "Installing $TMP_DIR/$EPEL_RPM"
    $YUM install $TMP_DIR/$EPEL_RPM
    if [ "$?" -ne "0" ]; then
        echo "Sorry, stopping since install of $TMP_DIR/$EPEL_RPM failed."
        exit 1
    fi
    echo "Installing packages: $PKGS"
    $YUM install $PKGS
    echo "Installing pypi packages: $PIPS"
    $PIP install $PIPS --upgrade
elif [[ `cat /etc/issue | grep -i "fedora.*release.*16"` ]] ; then
    PKGS="gcc git pylint python python-netifaces python-pep8 python-pip python-progressbar PyYAML python-iniparse"
    PIPS="termcolor"
    PIP="pip-python -q"
    YUM="yum install -q -y"
    # Now do it!
    echo "Preparing ANVIL for Fedora 16"
    echo "Installing packages: $PKGS"
    $YUM install $PKGS
    echo "Installing pypi packages: $PIPS"
    $PIP install $PIPS --upgrade
else
    echo "ANVIL '$ME' is being ran on an unknown distribution."
fi

