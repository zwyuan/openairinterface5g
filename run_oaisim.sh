#!/bin/bash

sudo kill $(ps -a | grep 'oaisim_nos1' | awk '{print $1}') || echo

read -p "Do you wish to proceed and rebuild oai_sim (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo Yes

        cd ~/oai/openairinterface5g
        ./cmake_targets/build_oai -c
        ./cmake_targets/build_oai --oaisim --noS1
        source oaienv
        cd cmake_targets/tools
        source init_nas_nos1
        cat /dev/null > ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
        ./run_enb_ue_virt_noS1 &> ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
    ;;
    * )
        echo No
    ;;
esac
