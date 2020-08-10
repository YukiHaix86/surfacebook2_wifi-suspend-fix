

    #!/bin/bash
    case $1 in
    pre)
    # unload the modules before going to sleep
    systemctl stop NetworkManager.service
    modprobe -r intel_ipts
    modprobe -r mei_me
    modprobe -r mei
    modprobe -r mwifiex_pcie
    modprobe -r mwifiex
    modprobe -r cfg80211
    ;;
    post)
    # need to cycle the modules on a resume and after the reset is called, so unload...
    sleep 2 #new
    modprobe -r intel_ipts
    modprobe -r mei_me
    modprobe -r mei
    modprobe -r mwifiex_pcie
    modprobe -r mwifiex
    modprobe -r cfg80211
    # and reload
    sleep 2 #new
    modprobe -i intel_ipts
    modprobe -i mei_me
    modprobe -i mei
    modprobe -i cfg80211
    modprobe -i mwifiex
    modprobe -i mwifiex_pcie
    echo 1 > /sys/bus/pci/rescan
    systemctl restart NetworkManager.service
    systemctl restart wpa_supplicant.service #new
    ;;
    esac

