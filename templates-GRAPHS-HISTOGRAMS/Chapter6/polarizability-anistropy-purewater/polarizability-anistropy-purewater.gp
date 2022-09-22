set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,10'
set key spacing 1.8
set key right top


set terminal postscript eps enhanced size 3.5in,2.8in
set output 'polarizability-anistropy-purewater.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines

set terminal pdfcairo enhanced size 3.5in,2.5in
#set term png truecolor  # or "set term pngcairo"
set output 'polarizability-anistropy-purewater.pdf'

#set style fill transparent solid 0.13 # partial transparency
#set style fill noborder # no separate top/bottom lines

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
set multiplot layout 1,1 rowsfirst

#----------------
#-  running average
#----------------

# number of points in moving average
n = 1

# initialize the variables
do for [i=1:n] {
    eval(sprintf("back%d=0", i))
}

# build shift function (back_n = back_n-1, ..., back1=x)
shift = "("
do for [i=n:2:-1] {
    shift = sprintf("%sback%d = back%d, ", shift, i, i-1)
} 
shift = shift."back1 = x)"
# uncomment the next line for a check
# print shift

# build sum function (back1 + ... + backn)
sum = "(back1"
do for [i=2:n] {
    sum = sprintf("%s+back%d", sum, i)
}
sum = sum.")"
# uncomment the next line for a check
# print sum

# define the functions like in the gnuplot demo
# use macro expansion for turning the strings into real functions
samples(x) = $0 > (n-1) ? n : ($0+1)
avg_n(x) = (shift_n(x), @sum/samples($0))
shift_n(x) = @shift


#----------------
#-  shade object
#----------------

#set style rect fc lt -1 fs transparent solid .1 noborder lc rgb "gray90"
#set obj rect from 700, graph 0 to 2300, graph 1


unset label
set tmargin at screen 0.98; set bmargin at screen 0.15

set size 0.9, 1
set origin 0.033, 0.0

set xrange [0:3.1]
set xtics
set format x
set xtics 0,1,4
set ylabel '{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]' font 'Arial,12'
set yrange [-0.003:0.003]
set ytics -0.006, 0.002, 0.018
set xlabel "t (ps)" font 'Arial,12'
set label gprintf('×10^{%T}',0.001) at graph 0.0, screen 0.94 offset 0.55,0 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)" font 'Arial,12' offset 0.0,1


f(x) = (x)**2

c=1
plot "EDIDsecond.dat" using ($1*0.001):($2) title       "{/Symbol D}{/Symbol a}^{tot}" with line ls 1 lc rgb "black" lw 1 dt 1,\
     'EDIDsecond.dat' using ($1*0.001):($2+0.0001):($2-0.0001) with filledcurves lc "black" notitle,\
     "permpol.dat" using ($1*0.001):($2) title       "{/Symbol D}{/Symbol a}^{perm}" with line ls 1 lc rgb "blue" lw 1 dt 1,\
     'permpol.dat' using ($1*0.001):($2+0.0001):($2-0.0001) with filledcurves lc "blue" notitle,\
     "induced.dat" using ($1*0.001):($2) title       "{/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "red" lw 1 dt 1,\
     'induced.dat' using ($1*0.001):($2+0.0001):($2-0.0001) with filledcurves lc "red" notitle,\
     "M_experiment_h2o.dat" using ($1+1.15):($2*0.5) title "Experiment"   with line ls 1 lc rgb "orange" dt 2 lw 1.5 ,\
      "pulse.dat" using ($1*0.001):(f($2)*1000) title "E^2_{THz}"  with line ls 1 lc rgb "gray" lw 0.8

unset multiplot
unset output

