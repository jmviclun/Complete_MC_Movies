# Complete_MC_Movies
This fortran code read a .pdb file from a Grand Canonical Monte Carlo simulation, where the number of molecules fluctuate and complete each frame with H atoms in the 0,0,0 coordinates. Then, the completed .pdb file can be read by VMD or other visualization software.

usage:

./qfull-movies.scp file.pdb    # the script should have execution permissions, e.g. chmod +x qfull-movies.scp

output: full-Movie_file.pdb

complete_Movies_GCMC.f90 file should be in the same folder than the qfull-movies.scp or the path should be stated when compiling the code

