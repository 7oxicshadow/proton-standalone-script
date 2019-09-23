#!/bin/bash

# Created by 7oxicshadow (23/09/19)
# https://github.com/7oxicshadow/proton-standalone-script

####################################################
####               Important                    ####
####################################################

# This script has been tested with Proton GE but should in theory work with any proton version.
# https://github.com/GloriousEggroll/proton-ge-custom/releases

# Before you can use this script you have to make 2 minor changes to the proton python file!
# Always make a backup before making changes :)

# Note: Make sure you DO NOT make the changes below directly to your steam version of proton! Create a copy
#       of the proton folder or use a downloaded version of proton as the changes would stop steam games from loading.

# 1: Open the proton python file in a text editor
# 2: Find the following line in the [def run(self)] section: 
#    self.run_proc([g_proton.wine_bin, "steam"] + sys.argv[2:])
# 3: Change it to:
#    self.run_proc([g_proton.wine_bin] + sys.argv[2:])
# 4: Find the following line in the [class CompatData] section:
#    self.prefix_dir = self.path("pfx/")
# 5: Change it to
#    self.prefix_dir = self.path("")
# 6: Save the changes.

# Put this script in the same folder as the proton python script.

####################################################
####      Script starts here!                   ####
####################################################

# Path to the proton file. This MUST be absolute as the proton script determines the working
# directory from this path. The $PWD assumes that this .sh file is being run from the same directory as
# the proton file. If you want to run the this script from anywhere, you need to change this to a Full
# path i.e PROTON=/path/to/files/proton

PROTON=$PWD/proton

# Uncomment these options as required. Note: DXVK / D9VK is enabled by default and does not need any of the
# options below

#export DXVK_LOG_LEVEL="info"
#export PROTON_USE_WINED3D="1"
#export PROTON_USE_WINED3D11="1"
#export PROTON_NO_D3D11="1"
#export PROTON_NO_D3D10="1"
#export PROTON_NO_D9VK="1"
#export PROTON_NO_ESYNC="1"
#export PROTON_USE_VKD3D="1"       #<-----DX12 support (only for versions of proton built with DX12 support)
#export PROTON_NO_FSYNC="1"
#export PROTON_FORCE_LARGE_ADDRESS_AWARE="1"
#export PROTON_OLD_GL_STRING="1"

# We need to manually set the environment variable for the game prefix so proton knows where the windows installation is.
# This needs to point the root prefix folder. (it will contain 2 folders [dosdevices and drive_c] aswell as the
# .reg files.
export STEAM_COMPAT_DATA_PATH="/mnt/games/PoL/.PlayOnLinux/wineprefix/infdemo"

# This command changes to the root directory containing the windows .exe file you want to run. This is important
# as all calls the .exe makes are relative to this path! (note the linux path format)
cd "/mnt/games/PoL/.PlayOnLinux/wineprefix/infdemo/drive_c/INFILTRATOR DX12/WindowsNoEditor"

# The final line actually executes the target exe. Steam typically uses the waitforexitandrun option when calling 
# the script but 'run' should work fine aswell. Note: The example below shows that you can call with command line
# options just like a normal windows call.

#python3 $PROTON run "InfiltratorDemo.exe" "-d3d12 -ResX=1440 -ResY=900 -FullscreenMode=1 -Fullscreen"
python3 $PROTON waitforexitandrun "InfiltratorDemo.exe" "-d3d12 -ResX=1440 -ResY=900 -FullscreenMode=1 -Fullscreen"