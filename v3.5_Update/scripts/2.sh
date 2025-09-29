#!/bin/bash
set -x
killall -9 -e artsd
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'scripterror' ERR
cd /workspace

EnterStage 3
