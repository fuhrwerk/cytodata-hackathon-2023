module load git
module load purge
module load tykky
mkdir -p /projappl/project_xxxx/$USER
mkdir -p /projappl/project_xxxx/$USER/CytoHackathon
conda-containerize new --prefix  /projappl/project_xxxx/$USER/CytoHackathon Cytohackathon_py310.yml
export PATH="/projappl/project_xxxx/$USER/CytoHackathon/bin:$PATH"
conda-containerize update /projappl/project_xxxx/$USER/CytoHackathon/  --post-install requirements_Cytohackathon.sh
