
set encoding utf8 
set terminal postscript enhanced 
#set terminal postscript eps size 3.5,3 enhanced color \
#    font 'Arial,8'  linewidth 0.1
set term pdfcairo size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 0.2
##set key box lw 0.5
set key width 0.5 height 0.5
set key font 'Arial,5'
set key spacing 2
set key right top
#unset key


set terminal pdfcairo enhanced size 2.0in,2.5in
set output 'Fig8.pdf'

#set terminal postscript eps enhanced size 3.5in,3.0in
#set output 'Fig2.eps'

set style fill transparent solid 0.13 # partial transparency
set style fill noborder # no separate top/bottom lines

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
set multiplot layout 4,1 rowsfirst

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

#----------------
#-  1 plot  -
#----------------



# labels and axis
set tmargin at screen 0.98; set bmargin at screen 0.84
set size 0.9, 1
set origin 0.033, 0.0

unset title
set label "E_{THz}" at 0.55,0.001  font 'Arial,6' textcolor rgb "black"
unset xtics
unset ytics
set xrange [0:3.2]
set yrange [-0.001:0.0015]


#plotting
plot "pulse.dat" using ($1*0.001):2 notitle  with line ls 1 lc rgb "light-red" lw 0.8
####, \"line.dat" using 1:2 notitle with line ls 1 dt 2 lc rgb "black" lw 2
unset label

#----------------
#-  2 plot  -
#----------------


unset label
set tmargin at screen 0.83; set bmargin at screen 0.08

set size 0.9, 1
set origin 0.033, 0.0

set xrange [0:3.2]
set xtics
set format x
set xtics 0,1,4
set ylabel '{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]' font 'Arial,9'
set yrange [-0.000099:0.000099]
set ytics -0.00009, 0.00002, 0.00009
set xlabel "Time t (ps)" font 'Arial,9'
set label gprintf('×10^{%T}',0.00001) at graph 0.0, screen 0.94 offset 0.55,-10 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "Time t (ps)" font 'Arial,9'

#plotting 0.3361 0.6635
#plotting
plot "one" using ($1*0.0004):((avg_n($2 ) -0.3387  )) every 100 title "{/Symbol a}^{Perm.}"  with linespoints ls 1 lc rgb "violet" lw 0.2 ps 0.2 pt 1,\
     "two" using ($1*0.0004):(avg_n($2 ) - 0.3387) every 120 title "{/Symbol a}^{Perm.} + DID^{   }"  with linespoints ls 1 lc rgb "blue" lw 0.2  ps 0.1 pt 2, \
     "three" using ($1*0.0004):(avg_n($2 ) -0.3387) every 140 title "{/Symbol a}^{Perm.} + DID^{1  }"  with linespoints ls 1 lc rgb "green" lw 0.2  ps 0.1 pt 3, \
     "four" using ($1*0.0004):(avg_n($2 ) -0.3387) title "{/Symbol a}^{Perm.} +  DID^{1,2}"  with linespoints ls 1 lc rgb "red" lw 0.2 ps 0.1 pt 4, \
     "ref" using ($1*0.0004):(($2-(0.5*($3+$4))) - 0.30177) title "Ref (CP2K and DALTON)"  with line ls 1 lc rgb "black" lw 0.2  , \

unset multiplot
unset output

