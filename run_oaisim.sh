#!/usr/bin/zsh

cd ~/oai/openairinterface5g
./cmake_targets/build_oai -c
./cmake_targets/build_oai --oaisim --noS1
source oaienv
cd cmake_targets/tools
source init_nas_nos1
./run_enb_ue_virt_noS1

