
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1.5
set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,5'
set key spacing 2
set key left
unset key

set terminal postscript eps enhanced size 3.5in,4.0in
set output 'intramolecular-coupling-locaframe-pffmd.eps'

file1="../data/PFFMD/twater/intra_coupling_locframe.dat"
file2="../data/PFFMD/t2mol/intra_coupling_locframe.dat"
file3="../data/PFFMD/t4mol/intra_coupling_locframe.dat"
labelcolor="blue"

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
set multiplot layout 5,3 rowsfirst

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.94; set bmargin at screen 0.665
set size 0.41, 1
set origin -0.049, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "xx" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($4) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($4) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($4) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset label 
unset arrow 


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.94; set bmargin at screen 0.665
set size 0.41, 1
set origin 0.2625, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "yy" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($5) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($5) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($5) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset label 
#-----------------
#-  third plot  -
#-----------------

set tmargin at screen 0.94; set bmargin at screen 0.665
set size 0.41, 1
set origin 0.575, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "zz" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($6) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($6) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($6) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset key
unset label 
#----------------
#-  Fourth plot  -
#----------------

# labels and axis
set tmargin at screen 0.66; set bmargin at screen 0.385
set size 0.41, 1
set origin -0.049, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "xy" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
set ylabel "({/Symbol w}- v) CCF" offset 0,0,0 font 'Arial,14'
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($7) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($7) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($7) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset key
unset ylabel
unset label 
unset arrow 


#-----------------
#-  Fifth plot  -
#-----------------

set tmargin at screen 0.66; set bmargin at screen 0.385
set size 0.41, 1
set origin 0.2625, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "xz" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($8) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($8) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($8) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset key
unset label 
#-----------------
#-  Sixth plot  -
#-----------------

set tmargin at screen 0.66; set bmargin at screen 0.385
set size 0.41, 1
set origin 0.575, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "yx" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
unset xtics
unset ytics
unset xlabel

plot file1 using ($1*0.001):($9) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($9) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($9) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset key
unset label 
#----------------
#-  Seventh plot  -
#----------------

# labels and axis
set tmargin at screen 0.375; set bmargin at screen 0.09
set size 0.41, 1
set origin -0.049, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "yz" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
#set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
set xtics
set xlabel "t (ps)" font 'Arial,14'
unset ytics
set xtics 0,0.1,0.3

plot file1 using ($1*0.001):($10) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($10) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($10) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset ylabel
unset label 
unset arrow 
unset key

#-----------------
#-  Eigth plot  -
#-----------------

set tmargin at screen 0.375; set bmargin at screen 0.09
set size 0.41, 1
set origin 0.2625, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "zx" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
set xtics
set xlabel "t (ps)" font 'Arial,14'
unset ytics
set xtics 0,0.1,0.3

plot file1 using ($1*0.001):($11) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($11) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($11) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset key
unset label 
#-----------------
#-  Ninth plot  -
#-----------------

set tmargin at screen 0.375; set bmargin at screen 0.09
set size 0.41, 1
set origin 0.575, 0.0

set xrange [0:0.35]
set yrange [-0.48:0.2]
set label "zy" at 0.25,0.15  font 'Arial,12' textcolor rgb labelcolor
##set ylabel "({/Symbol w}- v) CCF" offset 0,0,0
set xtics
set xlabel "t (ps)" font 'Arial,14'
set xtics 0,0.1,0.3
unset ytics
set key bottom right font 'Arial,8.5'

plot file1 using ($1*0.001):($12) title  "Pure liquid water" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($12) title  "MgCl_2 (2M)" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($12) title  "MgCl_2 (4M)" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset multiplot
unset output

