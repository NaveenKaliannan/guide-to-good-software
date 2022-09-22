
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1.5

set key width 0.5 height 0.5
set key font 'Arial,6'
set key spacing 2
set key right


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'Fig14.eps'

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

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.31, 1
set origin 0.003, 0.0


set label "{/Symbol a}_{xx}" at 20,1.3  font 'Arial,20' textcolor rgb "black"
set xrange [0:200]
set yrange [1.15:1.4]
set xlabel "t (fms)"
set ylabel "Polarizability [Å^3]" offset 2,0,0

##set ytics 1, 1, 2


#plotting
plot "abinito" using 1:2 title "Ab inito method (BLYP and TZV2P basis)"  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using 1:2 title "{/Symbol a}_{perm} + {/Symbol b} E + 0.5 * {/Symbol g} E^2 "  with line ls 1 lc rgb "red" lw 0.5

unset label 
unset arrow 
unset ylabel
unset key
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.31, 1
set origin 0.30,0.0

set label "{/Symbol a}_{yy}" at 20,1.095  font 'Arial,20' textcolor rgb "black"
set yrange [1.:1.2]
set xlabel "t (fms)"

plot "abinito" using 1:3 notitle  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using 1:3 notitle  with line ls 1 lc rgb "red" lw 0.5

unset label 
unset arrow 
#-----------------
#-  third plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.31, 1
set origin 0.60,0.0

set label "{/Symbol a}_{zz}" at 20,0.835  font 'Arial,20' textcolor rgb "black"
set yrange [0.79:0.86]
set xlabel "t (fms)"

plot "abinito" using 1:4 notitle  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using 1:4 notitle  with line ls 1 lc rgb "red" lw 0.5

unset multiplot
unset output






