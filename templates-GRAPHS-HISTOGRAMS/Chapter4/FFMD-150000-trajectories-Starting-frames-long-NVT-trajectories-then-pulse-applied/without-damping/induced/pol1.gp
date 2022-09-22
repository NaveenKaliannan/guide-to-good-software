
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,8'
set key spacing 2.4
#set key top left horiz
#set key left maxrows 3 bottom
set key outside center
#set key at screen 1, graph 1
set key at 3.9, 0

set terminal postscript eps enhanced size 4.0in,2.5in
set output 'Fig2.eps'

set size 1,1

NZ=2000
NX=2000
SCALE=0.2

set lmargin 7
set rmargin 2

# Axes
set xr [0:NZ] #Time /16
set mytics 5
set mxtics

# Multiplot
set multiplot layout 2,2 rowsfirst

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.95; set bmargin at screen 0.525
set size 0.37, 1
set origin 0.02, 0.0

set xrange [0:3.1]
set yrange [-0.0036:0.0025]
set ytics -0.004, 0.002, 0.006
set label gprintf('×10^{%T}',0.008) at graph 0.0, screen 0.94 offset 0.55,-3 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)"
set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]" offset 0,0,0
set title "Total contributions ({/Symbol a}^{Perm.}+{/Symbol a}^{ind.})"  font 'Arial,8' 
unset key
#plotting
set xtics format ""

unset xlabel 
set label "Pure liquid H_2O" at 1.5,0.0015 font 'Arial,8'  textcolor rgb "blue"



path_to_directory3="/home/naveenk/data/FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied"


set key
plot path_to_directory3."/pureliquidwater/permpol.dat" using ($1*0.001):($2 - 0)      title"{/Symbol a}^{Perm.}             " with points ls 1 ps 0.2 pt 6 lc rgb "blue" lw 0.2,\
     path_to_directory3."/pureliquidwater/DID.dat" using ($1*0.001):($2 - 0) title    "{/Symbol a}^{Perm.} + DID^{    }" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory3."/pureliquidwater/EDIDfirst.dat" using ($1*0.001):($2 -  0  ) title "{/Symbol a}^{Perm.} + DID^{1   }"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory3."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2 - 0 ) title   "{/Symbol a}^{perm} + DID^{1,2} "   with line ls 1 lc rgb "black" lw 0.2,\
     "M_experiment_h2o.dat" using ($1+1.15):($2*0.5) title "Exp. (Mohsen)"   with line ls 1 lc rgb "cyan" lw 0.5,\
     "H_experiment_h2o.dat" using ($1*0.33-0.2):($2*0.0001+200) title  "Exp. (Huang)"   with line ls 1 lc rgb "plum" lw 0.5,\

unset label 
unset arrow 
unset ylabel
unset ytics
unset key



#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.95; set bmargin at screen 0.525
set size 0.37, 1
set origin 0.47,0.0
set title "Induced contributions ({/Symbol a}^{ind.})"  font 'Arial,8' 
set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "
unset xlabel 
set key
set label "Pure liquid H_2O" at 1.5,0.0015 font 'Arial,8'  textcolor rgb "blue"
plot path_to_directory3."/pureliquidwater/induced1.dat" using ($1*0.001):($2 - 0) title    "DID^{   }" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory3."/pureliquidwater/induced2.dat" using ($1*0.001):($2 -  0  ) title "DID^{1  }"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory3."/pureliquidwater/induced3.dat" using ($1*0.001):($2 - 0 ) title   "DID^{1,2}"   with line ls 1 lc rgb "black" lw 0.2,\

unset label 

# labels and axis
set tmargin at screen 0.52; set bmargin at screen 0.1
set size 0.37, 1
set origin 0.02, 0.0

unset title
unset xtics
set xlabel
set xrange [0:3.1]
set yrange [-0.0043:0.0025]
set ytics -0.004, 0.002, 0.006
set label gprintf('×10^{%T}',0.008) at graph 0.0, screen 0.94 offset 0.55,-18 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  
set label "MgCl_2 [4mol/L]" at 1.5,0.0015 font 'Arial,8'  textcolor rgb "blue"
set xlabel "t (ps)"
set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]" offset 0,0,0
unset key
#plotting
set xrange [0:3.1]
set xtics format
set xtics 0, 0.5, 3.0



unset key
plot path_to_directory3."/mgcl2-4mol/permpol.dat" using ($1*0.001):($2 - 0) title "{/Symbol a}^{perm}" with points ls 1 ps 0.2 pt 6 lc rgb "blue" lw 0.2,\
     path_to_directory3."/mgcl2-4mol/DID.dat" using ($1*0.001):($2 - 0) title    "{/Symbol a}^{perm} + DID^{   }" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory3."/mgcl2-4mol/EDIDfirst.dat" using ($1*0.001):($2 -  0  ) title "{/Symbol a}^{perm} + DID^{1  }"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory3."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2 - 0 ) title   "{/Symbol a}^{perm} + DID^{1,2} "   with line ls 1 lc rgb "black" lw 0.2,\
     "H_experiment_mgcl2.dat" using ($1*0.33-0.2):($2*0.0001) title  "Exp. (Huang)"   with line ls 1 lc rgb "plum" lw 0.5,\
     "M_experiment_mgcl2.dat" using ($1+1.15):($2*0.4) title "Exp. (Mohsen)"   with line ls 1 lc rgb "cyan" lw 0.5,\

unset label 
unset arrow 
unset ylabel
unset ytics
unset key



#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.52; set bmargin at screen 0.10
set size 0.37, 1
set origin 0.47,0.0
set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics

set ytics format " "
set xrange [0:3.1]
set xtics 0, 0.5, 3.0
set label "MgCl_2 [4mol/L]" at 1.5,0.0015 font 'Arial,8'  textcolor rgb "blue"
unset key
plot path_to_directory3."/mgcl2-4mol/induced1.dat" using ($1*0.001):($2 - 0) title    "DID^{   }" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory3."/mgcl2-4mol/induced2.dat" using ($1*0.001):($2 -  0  ) title "DID^{1  }"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory3."/mgcl2-4mol/induced3.dat" using ($1*0.001):($2 - 0 ) title   "DID^{1,2}"   with line ls 1 lc rgb "black" lw 0.2,\

set nomultiplot

unset multiplot
unset output

