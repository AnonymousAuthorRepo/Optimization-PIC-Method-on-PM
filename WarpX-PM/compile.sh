#!/bin/sh

cd warpx_directory/WarpX
make -j
cd -
ls -l warpx_directory/WarpX/Bin

cp warpx_directory/WarpX/Bin/main3d.gnu.TPROF.MPI.OMP.ex warpx_run/warpx_3d
#cp warpx_directory/WarpX/Bin/main2d.gnu.TPROF.MPI.OMP.ex warpx_run/warpx_2d


ls -l warpx_run/warpx_2d
