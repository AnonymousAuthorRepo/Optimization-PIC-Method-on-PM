#!/bin/sh

commands="sudo apt-get install openmpi-bin openmpi-common openssh-client openssh-server libopenmpi2 libopenmpi-dev"
eval $commands
mpicxx="`which mpicxx`"

if [ "$mpicxx" = "" ];then
    echo "openmpi or mpich not found"
    exit -1
fi


echo "Deoplying WarpX ..."

mkdir warpx_directory
cd warpx_directory

rm -rf WarpX picsar amrex 2>/dev/zero

git clone --branch master https://github.com/ECP-WarpX/WarpX.git
git clone --branch master https://bitbucket.org/berkeleylab/picsar.git
git clone --branch development https://github.com/AMReX-Codes/amrex.git


cd WarpX

cat GNUmakefile | sed 's/^DIM\ \=\ ./DIM\ \=\ 2/g' > GNUmakefile.2D
cat GNUmakefile | sed 's/^DIM\ \=\ ./DIM\ \=\ 3/g' > GNUmakefile.3D

cp GNUmakefile.2D GNUmakefile
make clean
make -j

cp GNUmakefile.3D GNUmakefile
make clean
make -j

cd ..
cd ..


if [ ! -d "warpx_run" ];then
    mkdir warpx_run
fi

ls -l warpx_directory/WarpX/Bin

cp warpx_directory/WarpX/Bin/main3d.gnu.TPROF.MPI.OMP.ex warpx_run/warpx_3d
cp warpx_directory/WarpX/Bin/main2d.gnu.TPROF.MPI.OMP.ex warpx_run/warpx_2d


ls -l warpx_run/warpx_2d

echo "Finished."

