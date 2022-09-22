set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,10'
set key spacing 1.8
set key left top


set terminal postscript eps enhanced size 3.5in,2.8in
set output 'Fig2.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines

set terminal pdfcairo enhanced size 3.5in,2.5in
#set term png truecolor  # or "set term pngcairo"
set output 'translational-KE_PFFMD.pdf'

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
set ylabel 'Relative translational KE' font 'Arial,12'
set yrange [-0.0025:0.022]
set ytics -0.006, 0.002, 0.024
set xlabel "t (ps)" font 'Arial,12'
set label gprintf('×10^{%T}',0.01) at graph 0.0, screen 0.94 offset 0.55,0 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)" font 'Arial,12' offset 0.0,1
set label "PFFMD" at 2.2,0.02 font 'Arial,20'  textcolor rgb "blue"

f(x) = (x)**2

c=1
plot "twater/KEtransfer.dat" using ($1*0.001):(avg_n($3*c+0.0006+0.0008)) title       "H_2O (ref.)" with line ls 1 lc rgb "black" lw 2 dt 1,\
     'twater/KEtransfer.dat' using ($1*0.001):((avg_n($3*c+0.0006+0.0008+0.0004))):((avg_n($3*c+0.0006+0.0008-0.0004))) with filledcurves lc "black" notitle,\
     "tmgcl2-2mol/KEtransfer.dat" using ($1*0.001):(avg_n($3*c+0.0006+0.0008)) title       "MgCl_2 (2M)" with line ls 1 lc rgb "blue" lw 0.2 dt 1,\
     'tmgcl2-2mol/KEtransfer.dat' using ($1*0.001):((avg_n($3*c+0.0006+0.0008+0.0004))):((avg_n($3*c+0.0006+0.0008-0.0004))) with filledcurves lc "blue" notitle,\
     "tmgcl2-4mol/KEtransfer.dat" using ($1*0.001):(avg_n($3*c+0.0006+0.0008)) title       "MgCl_2 (4M)" with line ls 1 lc rgb "red" lw 0.2 dt 1,\
     'tmgcl2-4mol/KEtransfer.dat' using ($1*0.001):((avg_n($3*c+0.0006+0.0008+0.0004))):((avg_n($3*c+0.0006+0.0008-0.0004))) with filledcurves lc "red" notitle,\
     "tnacl-2mol/KEtransfer.dat" using ($1*0.001):(avg_n($3*c+0.0006+0.0008)) title       "NaCl (2M)" with line ls 1 lc rgb "yellow" lw 0.2 dt 1,\
     "tnacl-2mol/KEtransfer.dat" using ($1*0.001):((avg_n($3*c+0.0006+0.0008+0.0004))):((avg_n($3*c+0.0006+0.0008-0.0004))) with filledcurves lc "yellow" notitle,\
     "tna2so4/KEtransfer.dat" using ($1*0.001):(avg_n($3*c+0.0006+0.0008)) title       "Na_2SO_4 (1M)" with line ls 1 lc rgb "green" lw 0.2 dt 1,\
     'tna2so4/KEtransfer.dat' using ($1*0.001):((avg_n($3*c+0.0006+0.0008+0.0004))):((avg_n($3*c+0.0006+0.0008-0.0004))) with filledcurves lc "green" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*10000) title "E^2_{THz}"  with line ls 1 lc rgb "gray" lw 0.8

unset multiplot
unset output

