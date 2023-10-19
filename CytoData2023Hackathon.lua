-- Jupyter
prepend_path("PATH", "/projappl/project_{$PROJECT_ID}/{$USER}/CytoHackathon/bin")
depends_on("gcc/9.4.0","cudnn/8.1.0.77-11.2","cuda/11.2.2")
prepend_path('PATH',"/appl/bin:/appl/spack/v018/install-tree/gcc-9.4.0/cuda-10.1.243-c7m3zk/bin")


setenv("_COURSE_BASE_NAME", "CytoData2023Hackathon")
setenv("_COURSE_NOTEBOOK", "cytodata-hackathon-2023/notebook/CytoData2023_hackathon.ipynb")
setenv("_COURSE_GIT_REPO", "https://github.com/cytodata/cytodata-hackathon-2023.git")
setenv("_COURSE_GIT_REF", "")
setenv("_COURSE_NOTEBOOK_TYPE", "notebook")

-- Extra course material
setenv("_COURSE_SRC", "")
