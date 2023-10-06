#  Cytodata hackathon 2023 (WIP)

  Compute environemnt provided at CSC supercomputer will be used for this hackathon.  
  
# Computing environemtn at Puhti supercomputer
  - module system
  - custom installations and modules
  - Puhti web interface

## Preparing custom notebooks for cytodata hackathon 2023

A custom Jupyter notebook for cytodata hackathon 2023 can be provisioned through [Puhti web interface](https://www.puhti.csc.fi). The customisation of notebook involves the following steps:

- [Installing necessary python packages to *projappl* directory using *tykky* wrapper tool](#installing-necessary-python-packages-to-projappl-directory-using-tykky)
- [Creating a course environment/module(s)](#creating-a-course-environment-modules)
- [Accessing notebook *via* Puhti web interface](#accessing-notebook-via-puhti-web-interface)
- [Useful CSC documentation](useful-CSC-documentation)

### Installing necessary python packages to *projappl* directory using *tykky*:

Tykky wraps installations inside singularity container for improved performance metrics including faster startup times, reduced IO load, and  fewer number of files on large parallel filesystems. Please refer to CSC documentation on [tykky](https://docs.csc.fi/computing/containers/tykky/) for more detailed information.

For the installation of computational environment required for cytodata hackathon 2023, we use the tykky in the following way (make sure to edit with correct CSC project name as needed):

```bash
-

```
Tykky would install all needed packages (as listed in the file, yaml) to the directory '/projappl/project_xxxx/CytoHackathon'


### Creating a course environment modules

The files for course environments (modules) can be created in the directory /projappl/project_xxxx/www_puhti_modules/. The www_puhti_modules directory can be created if it does not exist.

The two files needed for setting up the course modules are:
   - a <<module_name>>.lua file that defines the module that sets up the Python environment. Only files containing the text Jupyter will be visible in the app.
   - a <<module_name>>-resources.yml that defines the default resources used for Jupyter.
  
For this CytoHackathon event, the above mentioned two files (i.e., .lua and .yaml files) are created  in the git repository we cloned above. so just copy them over to appropriate place in projappl folder and edit the correct project for this course as below:

```bash

mkdir /projappl/project_xxxx/www_puhti_modules && cp CytoHackathon-resources.yml	CytoHackathon.lua /projappl/project_xxxx/www_puhti_modules

# Edit the correct project number (in two places in CytoHackathon-course.lua file) in the the copied files in /projappl/project_xxxx/www_puhti_modules.

```


### Accessing notebook via Puhti web interface

1. Login to [Puhti web interface](https://www.puhti.csc.fi/public/login.html)
2. Login with CSC or course credentials (Users should have accepted Puhti service in [myCSC](https://my.csc.fi/welcome) page under a course ( or own) project before using this service). Login page is as shown below:

<img src="./Puhti_login.png" width="80%">

3. Once login is successfull, select "Interactive Sessions" on the top menu bar and then click "Jupyter for courses". On the right hand side you can see the different fields for selection before launching a job.  For this course, select the "Project" and "Working directory corresponding"  to course project. Then you will be able to see "CytoHackathon" module under the "Course module" field. You can then launch Jupyter notebook whick will be launched in the interaction partition by default. You can also change the default settings by checking "Show custom resource settings".

4. Upon successful launching a job, you can click on "connect to Jupyter" to see the course notebook corresponidng to CytoHackathon.


###  Useful CSC documentation

- [Jupyter for course](https://docs.csc.fi/computing/webinterface/jupyter-for-courses/)
- [Tykky containerisation](https://docs.csc.fi/computing/containers/tykky/)



