# Organising a Cytodata 2023 Hackathon at CSC

CSC hosts [Cytodata 2023 hackation](https://www.helsinki.fi/en/conferences/cytodata-2023/hackathon) on Puhti supercomputing environment. A hackathon participant is expected to have a [user account at CSC](https://docs.csc.fi/accounts/how-to-create-new-user-account/) and be a member of a project that [has access to the Puhti service](https://docs.csc.fi/accounts/how-to-add-service-access-for-project/).  Participants can use either [Puhti web interface](www.puhti.csc.fi) or [SSH client](https://csc-training.github.io/csc-env-eff/hands-on/connecting/ssh-puhti.html) for logging into Puhti. The familiarity with the following main topics help you get started smoothly with hackathon:

- [A brief primer on using Puhti computing environment](#a-brief-primer-on-using-puhti-computing-environment)
- [Preparing custom Jupyter notebook for hackathon](#preparing-a-custom-jupyter-notebook-for-hackathon)
- [Installing missing Rstudio packages](#installing-missing-rstudio-packages)
- [Creating a course environment/module(s) on Puhti Web Interface](#creating-a-course-environment-module-on-puhti-web-interface)
- [Accessing notebook *via* Puhti web interface](#accessing-notebook-via-puhti-web-interface)
- [Useful CSC documentation](#useful-CSC-documentation)
  
## A Brief Primer on Using Puhti Computing Environment
  - **Module system**: CSC uses module system to manage complex application stack in supercomputing environment. Applications installed as modules can easily be used in both interactive and batch jobs. The detailed instructions on using modularised applications can be found in [CSC documentation pages](https://docs.csc.fi/computing/modules/) as well as a [CSC course page](https://csc-training.github.io/csc-env-eff/hands-on/modules/modules-puhti.html)
  - **Disk areas**: CSC supercomputers have three main disk areas namely *home*, *projappl* and *scratch* which are visible to all compute and login nodes.  Each disk area has its own dedicated use and comes with quota limits on the size of disk pace and the number of files. Default quotas and their specific use can be found in [CSC user documentation](https://docs.csc.fi/computing/disk/)
  - **Custom installations**: You can install own software on CSC supercomputers if you cannot find it from the list of [pre-installed applications](https://docs.csc.fi/apps/) or using *module spider* command on Puhti terminal. Typically, one can download the source code of the software, compiles the code, and installs to a location where the user has write-access, e.g. the project's /projappl directory. More about installations can be found on [CSC documentation page](https://docs.csc.fi/computing/compiling-puhti/) and a [CSC course pages](https://csc-training.github.io/csc-env-eff/hands-on/installing/installing_hands-on_python.html). Puhti also supports [containerised installations](https://csc-training.github.io/csc-env-eff/hands-on/singularity/singularity-tutorial_part1.html)
  - **Puhti web interface**: You can use web interface for [Puhti](www.puhti.csc.fi) to access Puhti supercomputer. The web interface greatly eases the use of complex applications that have graphical user interfaces among other uses. Read more information about the web interface on [CSC documentation page](https://docs.csc.fi/computing/webinterface/)

## Preparing a Custom Jupyter Notebook for Hackathon

CSC provisions [popular python environements as ready-to-use notebooks](https://docs.csc.fi/computing/webinterface/jupyter/). You can however customise a python environement to meet your own needs. A custom Jupyter notebook for cytodata 2023 hackathon can be prepared in command-line environment of Puhti and accessed it through [Puhti web interface](https://www.puhti.csc.fi).  The customisation of notebook typically involves the following procedure:


### Installing Necessary Python Packages to *Projappl* Directory Using *tykky*

Conda installations should not be done directly on Puhti. [Tykky wrapper tool](https://docs.csc.fi/computing/containers/tykky/) instead be used to install python packages in setting up your compute environment. The wrapper tool installs applications inside of a singularity container and thus  facilitates better performance in terms of faster startup times, reduced IO load, and reduced number of files on parallel filesystems. 

Here is an example of tykky-based custom installation for cytodata 2023 hackathon (make sure to edit with correct CSC project name and user name as needed):

```bash
# start an interactive session once you are in login node
sinteractive -c 8 -m 30000 -d 100  # this command requests a compute node with 8 cores, 30 GB memory and 100 GB local disk space; change settings as needed
# load needed packages
module load git   # git command is not available by default on interactive nodes
module load purge  # clean environment 
module load tykky # load tykky wrapper 
# install python libraries using tykky wrapper tool; make sure to use proper project/username
mkdir -p /projappl/<project>/$USER && mkdir -p /projappl/<project>/$USER/CytoHackathon
conda-containerize new --prefix  /projappl/<project>/$USER/CytoHackathon Cytohackathon_py310.yml     # install basic packages using .yml
export PATH="/projappl/<project>/$USER/CytoHackathon/bin:$PATH"
conda-containerize update /projappl/<project>/$USER/CytoHackathon/  --post-install requirements_Cytohackathon.sh   # update package list 

```
In the above example, Tykky installs a basic setup (as listed in the file, Cytohackathon_py310.yml) first and then updates all python packages (as listed in the file, requirements_Cytohackathon.sh) to the directory '/projappl/project_xxxx/CytoHackathon'. Please note that you have to add the bin directory of installation to the $PATH variable before start using the installed environment (i.e., export PATH="/projappl/projectproject_xxxx/$USER/CytoHackathon/bin:$PATH").

The tool also supports *Mamba* for installing python packages. Mamba often finds suitable packages much faster than Conda, so it is a good option when the required package list is long. Enable this feature by adding the --mamba flag  as below:

```
conda-containerize new --mamba --prefix <install_dir> env.yml
```

### Creating a Course Environment Module on Puhti Web Interface

One has to create a course environments (modules) in the directory /projappl/project_xxxx/www_puhti_modules/ to be able to see a course module in Puhti web insterface ("under Jupyter for courses") . The www_puhti_modules directory can be created if it does not exist. Please note that module_name has to be unique accross the project members. 

The two files needed for setting up the course modules are:
   - a <<module_name>>.lua file that defines the module that sets up the Python environment. Only files containing the text Jupyter will be visible in the app.
   - a <<module_name>>-resources.yml that defines the default resources used for Jupyter.
  
For this CytoHackathon event, the above mentioned two files (i.e., .lua and .yaml files) are created  in the GitHub repository we cloned above. So just copy them over to appropriate place under */projappl* folder as below:

```bash

mkdir -p /projappl/project_xxxx/www_puhti_modules && cp CytoHackathon-resources.yml	CytoHackathon.lua /projappl/project_xxxx/www_puhti_modules

# Edit the correct project number and actual username (in CytoHackathon-course.lua file) in the copied files in /projappl/project_xxxx/www_puhti_modules.

```

Once you have set up modules as instructed above, a module named, CytoHackathon is visible in "Jupyter for courses" app in the Puhti web interface
## Installing Missing Rstudio Packages

The RStudio application installed on Puhti comes with large set of pre-installed R packages. You can check available *r-env* versions on our [CSC doccumentation pages](https://docs.csc.fi/apps/r-env/). Please refer to CSC documentation on how to use R in batch and interatcive job applications in Puhti. Installation instructions for misssing R packages can be found [here](https://docs.csc.fi/apps/r-env/#r-package-installations).

Briefly, R/Rstuido is installed as containers and users can only install missing R packages in a dedicated writable disk areas (
e.g., /projappl). When installing R packages, one has to point R to writable disk area. 

Here is an example on how to  install a R package:
```
sinteractive -c 4     # Once login to Puhti, start interactive node with four cores, you can also specify memory (-m 50000) and disk space  (-d 100)
module load r-nev/430   # you can for example load R v430 version
# Add this to your R code:
.libPaths(c("/projappl/<project>/project_rpackages_<rversion>", .libPaths()))
libpath <- .libPaths()[1]

# This command can be used to check that the folder is now visible:
.libPaths() # It should be first on the list

# Package installations should now be directed to the writable area of your project ( use actual project and user name in libpath variable)
install.packages("package", lib = libpath)
BiocManager::install("mistyR") # this will install "mistyR" package using a R package manager
install.packages("https://cran.rstudio.com/src/contrib/scattermore_1.2.tar.gz", repos=NULL, type="source") # install a pckage from source
remotes::install_github("satijalab/seurat", "seurat5", quiet = FALSE)  # install package from a Github
```
Please note that you have to run the following command every time you launch R session if you want to use your custom installations.

```
.libPaths(c("/projappl/<project>/project_rpackages_<rversion>", .libPaths()))
```

## Accessing Notebook *via* Puhti Web Interface

1. Login to [Puhti web interface](https://www.puhti.csc.fi/public/login.html)
2. Login with your CSC account (or Haka/Virtu) (Users should have accepted Puhti service in [myCSC](https://my.csc.fi/welcome) page under a course ( or own) project before using this service). Login page is as shown below:

<img src="./puhti_web.png" width="80%">

3. Once login is successfull, you can click "Interactive Sessions" on the top menu bar and then click "Jupyter for courses" (or directly from pinned apps on landing page). Once the app is launched, you can see the different fields to fill in before launching a job. For this course, select the "course Project" and Working directory corresponding  to course project. Then you will be able to see "CytoHackathon" module under the "Course module" field. You can then launch Jupyter notebook whick will be launched in the interaction partition by default. You can also change the default settings by checking "Show custom resource settings". Similarly, you can also launch Rstudio (just by clicking "Rstudio" app) on the landing page of Puhti web interface.

4. Upon successful launching a job, you can click on "connect to Jupyter" to see the course notebook corresponidng to CytoHackathon.


##  Useful CSC Documentation

- [Jupyter for course](https://docs.csc.fi/computing/webinterface/jupyter-for-courses/)
- [Tykky containerisation](https://docs.csc.fi/computing/containers/tykky/)



