
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,8'
set key spacing 2
set key right bottom


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'salt-induced.eps'

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
set multiplot layout 1,3 rowsfirst

f(x) = (x)**2


#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.35, 1
set origin 0.02, 0.0


set xrange [0:3.1]
set yrange [-0.004:0.002]


set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)"
set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [10^{-3} Å^3]" offset 0,0,0

set label "MgCl_2 [4 M]"  at 0.3,0.0015 font 'Arial,10'  textcolor rgb "blue"
set xrange [0:3.1]
set xlabel "t (ps)"

set ytics -0.010, 0.002, 0.006


path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

unset key
c=1
plot "tmgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a} = {/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "red" lw 0.5,\
     "tmgcl2-4mol/permpol.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{perm}" with line ls 1 lc rgb "green" lw 0.5,\
     "tmgcl2-4mol/induced.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "blue" lw 0.5,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.30,0.0
set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"
unset key
set label "NaCl [4 M]"  at 0.3,0.0015 font 'Arial,10'  textcolor rgb "blue"
c=1
plot "tnacl4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a} = {/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "red" lw 0.5,\
     "tnacl4mol/permpol.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{perm}" with line ls 1 lc rgb "green" lw 0.5,\
     "tnacl4mol/induced.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "blue" lw 0.5,\


unset label 
unset arrow 
set key
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.60,0.0

set xrange [0:3.1]
set xlabel "t (ps)"
set key 
set label "Na_2SO_4 [1 M]"  at 0.3,0.0015 font 'Arial,10'  textcolor rgb "blue"


set key
c=1
plot "na2so4/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a} = {/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "red" lw 0.5,\
     "na2so4/permpol.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{perm}" with line ls 1 lc rgb "green" lw 0.5,\
     "na2so4/induced.dat" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "blue" lw 0.5,\

unset multiplot
unset output

