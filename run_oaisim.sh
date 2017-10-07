#!/bin/bash

echo "Killing old running instance of oaisim"
sudo kill $(ps -a | grep 'oaisim_nos1' | awk '{print $1}') || echo

logging=1

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
        if [ "$logging" = 1 ]; then
            cat /dev/null > ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
            ./run_enb_ue_virt_noS1 &> ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
        else
            ./run_enb_ue_virt_noS1
        fi
    ;;
    * )
        echo No
        read -p "Do you wish to re-run oai_sim (y/n)? " answer
        case ${answer:0:1} in
            y|Y )
                echo Yes
                source oaienv
                cd cmake_targets/tools
                source init_nas_nos1
                if [ "$logging" = 1 ]; then
                    cat /dev/null > ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
                    ./run_enb_ue_virt_noS1 &> ~/oai/openairinterface5g/run_enb_ue_virt_noS1.log
                else
                    ./run_enb_ue_virt_noS1
                fi
            ;;
            * )
                echo No
            ;;
        esac
    ;;
esac

