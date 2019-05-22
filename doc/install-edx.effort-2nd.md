#!/usr/bin/env bash

# we choose Devstack
we deploy using Devstack ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/index.html

> Devstack is a deployment of the Open edX platform within a set of Docker containers designed for local development.
ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/installation_options.html#open-edx-devstack

prerequisites ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/installation_prerequisites.html#installation-prerequisites


# install prerequisite
## docker-compose 
ref. https://gist.github.com/namgivu/536ae64983b515026bd5d5c908668207#file-install-docker-compose-sh

ensure using overlay2
```bash
: root@edtek:~ skedx $
docker info | grep -i 'storage driver' | grep overlay2 # should get  > Storage Driver: overlay2
```

## install make
```bash
: root@edtek:~ skedx $
apt install -y make
```

## make swap file 8Gb
ref. https://gist.github.com/namgivu/e3fbb84ad9c8a3be43f4f16c4c229f97


# install Devstack 
ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/install_devstack.html#install-devstack

NOTE the command `./repo.sh checkout` not working from the official repo, 
so I make a fork here `git@github.com:namgivu/devstack.git` 
based on branch `open-release/hawthorn.master` - how to choose branch ref. https://edx.readthedocs.io/projects/edx-developer-docs/en/latest/named_releases.html


```bash 
: root@edtek:~ skedx $
skedx_home="$HOME/skedx/"; mkdir -p $skedx_home

export OPENEDX_RELEASE=hawthorn.master
export OPENEDX_RELEASE=ironwood.master # ref. https://edx.readthedocs.io/projects/edx-developer-docs/en/latest/named_releases.html#ironwood
export DEVSTACK_WORKSPACE=$skedx_home  

cd $skedx_home
    git clone https://github.com/edx/devstack
    cd "$skedx_home/devstack"
        git checkout open-release/ironwood.master; git pull
    
        # clone the correct branch in the local checkout of each service repository
        note="
        Clone the Open edX service repositories. 
        The Docker Compose file mounts a host volume for each service’s executing code. 
        
        The host directory defaults to be a sibling of the /devstack directory. 
        For example, if you clone the edx/devstack repository to ~/workspace/devstack, 
        host volumes will be expected in ~/workspace/course-discovery, ~/workspace/ecommerce, etc. 
        
        You can clone these repositories with the following command.
        "
        make dev.clone # ./repo.sh clone
        
        # ONLY after cloned, run checkout 
        # make dev.checkout # ./repo.sh checkout
        
        # start the various services 
        make dev.provision
        note='running the :provision may have issues/hanging, then we need to create swap file to provide more memory for the machine eg 8Gb'
        
    cd -
cd -
```

# start the Open edX Developer Stack 
ref. https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/installation/start_devstack.html#starting-devstack
after installed, this command will start the services
```bash
cd "$skedx_home/devstack"
    make dev.up
cd -
```
