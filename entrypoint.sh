#!/bin/bash
/sbin/init
cd /install
FM_ASSISTED_INSTALL=/install apt install /install/filemaker-server-21.0.2.202-amd64.deb
cp BaseElements.fmx /opt/FileMaker/FileMaker\ Server/Database\ Server/Extensions/
cp BaseElements.fmx /opt/FileMaker/FileMaker\ Server/Web\ Publishing/publishing-engine/cwpc/Plugins/
