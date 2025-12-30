# Redstar OS 3.5 (Work In Progress)
This an unofficial mod of DPRK's Red Star OS 3.0 Desktop operating system, providing a new 64bit kernel, new compiler, new 64bit libraries, and a lot more. 

Download a prebuilt ISO of this mod here: https://github.com/happymimimix/DPRK_RedStarOS_3.5_Modded_ISO/releases

# How to install:

Github has a 2 GB file size limit for release artefacts, and unfortunately, the RedStarOS 3.5 modded ISO is way too big to fit within that limit. So, splitted 7z archives were used to get around this limitation. 

You must download **ALL** of the \*.7z.??? files and place them in the same directory, then open any one of these files in your favorite archive software and click extract. 

Once you have obtained the ISO image, mount it in your favorite hypervisor software and power on the virtual machine. 

Complete the installation process as normal. 

Once you have reached the desktop, mount the same ISO image again and click the blue button in the confirmation dialog when prompted. 

**Note: there are no separate ISO images for post-installation. There is only ONE RedStarOS_3.5_Modded.iso file. All post-installation scripts are MERGED with the OS installer inside ONE SINGLE ISO image!** 
  
# How to build the ISO yourself
Download the original ISO from here: https://archive.org/download/red-star-en/redstar_desktop3.0_sign.iso

Clone this repository

Open the iso image in PowerISO or UltraISO

Rename the volume label to RedStarOS_3.5

Add all files in this repositiry to the root directory of the ISO

Replace all files when asked

Save ISO

Done

Note: Make sure you **clone** the repo using Git instead of downloading a zip file from Github

Git LFS doesn't work in zip! 

# Encountered a problem? 
Try to ask ChatGPT first: https://chatgpt.com/share/6953c86e-8254-8004-83f5-8d88b83e0e75

If ChatGPT can't solve your problem, try asking on [RedStarOS 3.5 Official Discord Server](discord.gg/MY68R2Quq5) or [Github Issues](github.com/happymimimix/DPRK_RedStarOS_3.5_Modded_ISO/issues). 
