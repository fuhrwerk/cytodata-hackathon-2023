-- Jupyter
prepend_path("PATH", "/projappl/project_xxxx/$USER/CytoHackathon/bin")
depends_on("gcc/9.4.0","cudnn/8.1.0.77-11.2","cuda/11.2.2")
prepend_path('PATH',"/appl/bin:/appl/spack/v018/install-tree/gcc-9.4.0/cuda-10.1.243-c7m3zk/bin")


setenv("_COURSE_BASE_NAME", "CytoHackathon")
setenv("_COURSE_NOTEBOOK", "CytoHackathon/notebook/CytoData2023_hackathon.ipynb")
setenv("_COURSE_GIT_REPO", "https://github.com/yetulaxman/CytoHackathon.git")
setenv("_COURSE_GIT_REF", "")
setenv("_COURSE_NOTEBOOK_TYPE", "notebook")

-- Extra course material
setenv("_COURSE_SRC", "")
