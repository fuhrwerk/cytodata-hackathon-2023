# remove all installations from home: rm -fr ~/.local/*; 
#export TMPDIR="/scratch/project_2001659/yetukuri/CytoHackathon/install_setup/tmp"
#export LOCAL_HOST="/scratch/project_2001659/yetukuri/CytoHackathon/install_setup/tmp"
module load git
module load purge
module load tykky
mkdir /projappl/project_2001659/yetukuri
mkdir /projappl/project_2001659/yetukuri/CytoHackathon
conda-containerize new --prefix  /projappl/project_2001659/yetukuri/CytoHackathon Cytohackathon_py310.yml
export PATH="/projappl/project_2001659/yetukuri/CytoHackathon/bin:$PATH"
conda-containerize update /projappl/project_2001659/yetukuri/CytoHackathon/  --post-install requirements_Cytohackathon.sh
