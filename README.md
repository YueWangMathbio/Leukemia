# Leukemia

the file A.dat contains the experimental data, a 240 by 20 matrix
each row is the cell area of a well of each day during Day 4 to Day 23
rows 1-80 start with 10 cells
rows 81-160 start with 4 cells
rows 161-240 start with 1 cell

the file D10.dat contains the simulation data, a 80 by 45 matrix
each row is the cell number of a well of each half day during Day 1 to Day 23
each well starts with 10 cells

the file D4.dat contains the simulation data, a 80 by 45 matrix
each row is the cell number of a well of each half day during Day 1 to Day 23
each well starts with 4 cells

the file D1.dat contains the simulation data, a 80 by 45 matrix
each row is the cell number of a well of each half day during Day 1 to Day 23
each well starts with 1 cell

the file simulation.m is a Matlab file that simulates the cell growth
it outputs simulated data D10.dat, D4.dat, D1.dat

the file plotting.m is a Matlab file that plots Figs. 1-3, based on the data files

the file anova.m is a Matlab file that conducts an ANOVA test 

the file parameter_estimation.m is a Matlab file that use maximum likelihood
method to estimate three parameters
