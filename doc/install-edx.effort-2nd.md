#!/usr/bin/env bash

# we choose Devstack
we deploy using Devstack ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/index.html

> Devstack is a deployment of the Open edX platform within a set of Docker containers designed for local development.
ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/installation_options.html#open-edx-devstack

prerequisites ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/installation_prerequisites.html#installation-prerequisites


# install docker-compose 
ref. https://gist.github.com/namgivu/536ae64983b515026bd5d5c908668207#file-install-docker-compose-sh

ensure using overlay2
```bash
: root@edtek:~ skedx $
docker info | grep -i 'storage driver' # should get  > Storage Driver: overlay2
```


# install Devstack 
ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/install_devstack.html#install-devstack

NOTE the command `./repo.sh checkout` not working from the official repo, 
so I make a fork here `git@github.com:namgivu/devstack.git` based on branch `open-release/hawthorn.master`

```bash 
: root@edtek:~ skedx $
SKEDX_HOME="$HOME/skedx/"; mkdir -p $SKEDX_HOME

export OPENEDX_RELEASE=hawthorn.master; 
export DEVSTACK_WORKSPACE=$SKEDX_HOME;  

cd $SKEDX_HOME
    git clone https://github.com/namgivu/devstack
    cd "$SKEDX_HOME/devstack"
        git checkout feature/nn-deploy-effort; git pull
    
        # clone the correct branch in the local checkout of each service repository
        make dev.clone; ./repo.sh clone
        
        # after cloned, run checkout 
        make dev.checkout; ./repo.sh checkout
        
        # start the various services 
        make dev.provision
        note='if running the :provision has issues/hanging, you may need to create swap file to provide more memory for the machine eg 8Gb'
    cd -
cd -
    

note="
Clone the Open edX service repositories. 
The Docker Compose file mounts a host volume for each service’s executing code. 

The host directory defaults to be a sibling of the /devstack directory. 
For example, if you clone the edx/devstack repository to ~/workspace/devstack, 
host volumes will be expected in ~/workspace/course-discovery, ~/workspace/ecommerce, etc. 

You can clone these repositories with the following command.
"
make dev.clone

```
