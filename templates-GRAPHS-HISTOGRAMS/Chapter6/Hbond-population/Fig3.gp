
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 0.2
set key box lw 0.5
set key width 0.5 height 0.5
set key font 'Arial,5'
set key spacing 2
set key left
unset key

set terminal postscript eps enhanced size 2.0in,3.5in
set output 'Fig2_2.eps'

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
n = 50

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
set label "E_{THz}" at 250,0.001  font 'Arial,8' textcolor rgb "black"
unset xtics
unset ytics
set xrange [100:4500]
set yrange [-0.001:0.0015]


#plotting
plot "pulse.dat" using 1:2 notitle  with line ls 1 lc rgb "light-red" lw 0.8, \

unset label
#----------------
#-  2 plot  -
#----------------

# labels and axis
set tmargin at screen 0.84; set bmargin at screen 0.60
set size 0.9, 1
set origin 0.033, 0.0

set ytics
unset title
set label "H_2O having 2 HBs" at .250,7.95  font 'Arial,8' textcolor rgb "blue"
set xrange [.1:4.5]
unset xtics
set xtics
set format x ""
set yrange [6.9:8.1]
set ytics 7,0.5,8

#plotting
plot "output.dat" using ($1*0.001):($3) notitle  with line ls 1 lc rgb "grey70" lw 2, "output.dat" using ($1*0.001):(avg_n(($3))) every 5 w l lc rgb "black" lw 2 notitle, "line3.dat" using ($1*0.001):2 notitle with line ls 1 dt 2 lc rgb "green" lw 10


#-----------------
#-  4 plot  -
#-----------------

unset xtics
set tmargin at screen 0.60; set bmargin at screen 0.34
set yrange [26.9:29.1]
set xrange [.1:4.5]
set label "H_2O having 3 HBs" at .250,28.75  font 'Arial,8' textcolor rgb "blue"
set size 0.9, 1
set origin 0.033, 0.0
set xtics
set format x ""
set ylabel "Population in %" 
set ytics 27,1,29

plot "output.dat" using ($1*0.001):($4) notitle  with line ls 1 lc rgb "grey70" lw 2, "output.dat" using ($1*0.001):(avg_n(($4))) every 5 w l lc rgb "black" lw 2 notitle, "line3.dat" using ($1*0.001):3 notitle with line ls 1 dt 2 lc rgb "green" lw 10

unset ylabel

#-----------------
#-  4 plot  -
#-----------------

unset label
set tmargin at screen 0.34; set bmargin at screen 0.08

set size 0.9, 1
set origin 0.033, 0.0

unset title
set label "H_2O having 4 HBs" at .250,58  font 'Arial,8' textcolor rgb "blue"
set xtics
set format x
set xrange [.1:4.5]
set yrange [54.9:58.6]
set xlabel "t (ps)"
set ytics 55,1,58.5

#set label "Population in %" at -0.8,59  rotate by 90 left font 'Arial,12' textcolor rgb "black"

plot "output.dat" using ($1*0.001):($5) notitle  with line ls 1 lc rgb "grey70" lw 2, "output.dat" using ($1*0.001):(avg_n(($5))) every 5 w l lc rgb "black" lw 2 notitle, "line3.dat" using ($1*0.001):4 notitle with line ls 1 dt 2 lc rgb "green" lw 10


unset multiplot
unset output

