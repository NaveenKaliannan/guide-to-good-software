set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,9'
set key spacing 1.5
set key right top


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'KE-AIMD.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'KE-AIMD.pdf'


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
#-  running average
#----------------

# number of points in moving average
n = 80

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
 
#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin -0.07, 0.0


set xrange [0:3.1]
set yrange [-0.0065:0.008]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "KE" offset 4.2,0,0 font 'Arial,9'


set xrange [0:4.4]

set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.0160, 0.002, 0.016 font 'Arial,6' 
set xtics font 'Arial,6
set label gprintf('×10^{%T}',0.001) at graph 0.0, screen 0.94 offset 0.55,0 font 'Arial,8'

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key
set key right top
plot "trans.dat" using ($1*0.001):($2*c - 0.333169 ) title    "v_{COM} KE" with line ls 1 lc rgb "blue" lw 0.5,\
      "rot.dat" using ($1*0.001):($2*c - 0.666931 ) title    "{/Symbol w} KE" with line ls 1 lc rgb "green" lw 0.5,\
      "pulse.dat" using ($1*0.001):(f($2)*3000) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.259,0.0
set xrange [0:4.4]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset ytics
set ytics format " "

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

c=1
set ytics format
set key
set ylabel " T - T_{0} (in K)" offset 3.2,0,0 font 'Arial,9'
set yrange [-1.9:6]
set ytics -2, 2, 6 font 'Arial,6' offset 0.5,0,0

set label 'T_1' at 0.86,-0.5 font 'Arial,9'  textcolor rgb "red"
set label 'T_2' at 2.62,3.8 font 'Arial,9'  textcolor rgb "red"

plot "TRAN.dat" using ($1*0.001):($2 * 210520 - 322.4) notitle  with line ls 1 lc rgb "black" lw 0.5, "line3.dat" using ($1*0.001):4 notitle with line ls 1 dt 1 lc rgb "red" lw 3, "line3.dat" using ($6*0.001):5 notitle with line ls 1 dt 1 lc rgb "red" lw 3 ,     "pulse.dat" using ($1*0.001):(f($2)*3000000) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7


set ytics format



unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.44, 1
set origin 0.59,0.0

set xrange [0:4.4] 
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set yrange [0:1]
set key
c=1
set ytics 0, 0.2, 1 font 'Arial,6' 
set yrange [3.577:3.661]
set ytics 3.58,0.04,3.66
set ylabel " N_{H-bonds}         per H_2O" offset 6.8,0,0 font 'Arial,9'

plot "output.dat" using ($1*0.001):(($2*1+$3*2+$4*3+$5*4+$6*5)/100) notitle  with line ls 1 lc rgb "black" lw 0.5 ,     "pulse.dat" using ($1*0.001):(f($2)*30000+3.6225) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7


unset multiplot
unset output

