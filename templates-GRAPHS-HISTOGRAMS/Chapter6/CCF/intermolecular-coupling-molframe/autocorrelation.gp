
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,8'
set key spacing 2
set key right bottom font 'Arial,6'

set terminal postscript eps enhanced size 3.2in, 2.2in
set output 'intermolecular-coupling-molframe_auto.eps'

file1="../data/FFMD/0/inter_coupling_molframe.dat"
file2="../data/FFMD/10/inter_coupling_molframe.dat"
file3="../data/FFMD/100/inter_coupling_molframe.dat"
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
set multiplot layout 2,1 rowsfirst

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.92; set bmargin at screen 0.52
set size 1, 0.5
set origin 0, 0.5


set xrange [0:0.5]
set yrange [-10:10]
#unset ytics

set xlabel "t (ps)"
set label "COM veolcity (v_{COM}) ACF" at 0.15,8  font 'Arial,12' textcolor rgb labelcolor
unset key
#plotting
unset xtics
unset xlabel
unset key
c=0.4
plot file1 using ($1*0.001):($2) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($2) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($2) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\


unset label 
unset arrow 
unset ylabel
unset key
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.48; set bmargin at screen 0.15
set size 1, 0.5
set origin 0.00,0.0
set label "Angular veolcity ({/Symbol w}) ACF" at 0.15, 8  font 'Arial,12' textcolor rgb labelcolor
set ylabel "<{/Symbol w}_{i}(0).{/Symbol w}_{i}(t)> / < {/Symbol w}_{i}(0).{/Symbol w}_{i}(0) > " offset 0,0,0
set xrange [0:0.5]
set xlabel "t (ps)"
set xtics
set xlabel "t (ps)"
set ylabel
set key
c=0.0001

set label "ACF"   at -0.035,10  rotate by 90 left font 'Arial,12' textcolor rgb "black"

plot file1 using ($1*0.001):($3) title  "Field-free (ref)" with line ls 1 lc rgb "black" lw 0.4 dt 0,\
     file2 using ($1*0.001):($3) title  "Weak THz pulse" with line ls 1 lc rgb "red" lw 0.4 dt 1,\
     file3 using ($1*0.001):($3) title  "Strong THz pulse" with line ls 1 lc rgb "green" lw 0.4 dt 1,\

unset label 
unset arrow 

unset multiplot
unset output

