# transonic-airfoil
# OpenFOAM Installation and Testing Guide

## Check GCC Version
```bash
gcc --version
```

## Install Dependencies
### Install OpenMPI
```bash
wget https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.6.tar.gz
tar -xvf openmpi-5.0.6.tar.gz
cd openmpi-5.0.6
sudo apt update
sudo apt install build-essential libnuma-dev
./configure --prefix=/usr/local/openmpi
make -j$(nproc)
sudo make install
echo 'export PATH=/usr/local/openmpi/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/openmpi/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
mpirun --version
cd ..
rm -rf openmpi-5.0.6 openmpi-5.0.6.tar.gz
```

### Install ParaView
```bash
sudo apt update
sudo apt install paraview
```

## Download OpenFOAM 12
```bash
mkdir OpenFOAM
cd OpenFOAM
git clone --depth 1 https://github.com/OpenFOAM/OpenFOAM-12.git
git clone --depth 1 https://github.com/OpenFOAM/ThirdParty-12.git
source $HOME/OpenFOAM/OpenFOAM-12/etc/bashrc
echo $WM_PROJECT_DIR
```

## Configure and Build ThirdParty
```bash
mkdir -p $HOME/.OpenFOAM 
echo "export SCOTCH_VERSION=6.0.6" >> $HOME/.OpenFOAM/prefs.sh 
echo "export ZOLTAN_VERSION=3.83" >> $HOME/.OpenFOAM/prefs.sh
cd ThirdParty-12
wget https://github.com/sandialabs/Zoltan/archive/refs/tags/v3.90.tar.gz
tar -xvf v3.90.tar.gz
cd Zoltan-3.90
sudo apt update
sudo apt install build-essential gfortran libopenmpi-dev libmpich-dev zlib1g-dev
mkdir build
cd build
../configure --prefix=$HOME/zoltan --enable-mpi
make -j$(nproc)
make install
cd ..
cd ..
sudo apt update
sudo apt install flex
./Allwmake -q -j 6
```

## Build OpenFOAM
```bash
cd ..
cd OpenFOAM-12
./Allwmake -q -j 6
```

## Test Installation
```bash
cd /home/neo/OpenFOAM/
mkdir -p run tutorials custom
ln -s /home/neo/OpenFOAM/run $HOME/OpenFOAM/run
cp -r /home/neo/OpenFOAM/OpenFOAM-12/tutorials/shockFluid/obliqueShock /home/neo/OpenFOAM/run/
cd /home/neo/OpenFOAM/run/obliqueShock
blockMesh
foamRun
paraFoam -builtin

