
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
set output 'Fig7_2.eps'

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
#-  running average
#----------------

# number of points in moving average
n = 5

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
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.35, 1
set origin 0.02, 0.0

set yrange [-0.007:0.012]
set xrange [0.5:3.1]
set xlabel "t (ps)"
set ylabel "Translational K.E of water in [arb. unit]" offset 0.8,0,0

set title "PFFMD (AMOEBA force field)"  font 'Arial,8' 
unset key
#plotting

set key
c=0.4
plot "KE/pffmd-water-KE.dat" using ($1*0.001):(avg_n($3+0.0018)) title       "Pure liquid water" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
     "KE/pffmd-mgcl2-2mol-KE.dat" using ($1*0.001):(avg_n($3+0.0018)) title    "MgCl_2 (2 mol/L)" with line ls 1 lc rgb "green" lw 0.5,\
     "KE/pffmd-mgcl2-4mol-KE.dat" using ($1*0.001):(avg_n($3+0.0018)) title "MgCl_2 (4 mol/L)"   with line ls 1 lc rgb "red" lw 0.5,\
     "line.dat" using ($1):($2) notitle with line ls 0 lc rgb "black" lt 0
#     "KE/pffmd-mgcl2-2mol-KE.dat" using ($1*0.001):(avg_n($3+0.0018)) title    "MgCl_2 (2 mol/L)" with line ls 1 lc rgb "blue" lw 0.5,\

unset label 
unset arrow 
unset ylabel
unset ytics
unset key
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.30,0.0
set title "FFMD (AMBER/SPC force field)"  font 'Arial,8' 
set xrange [0.5:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "

set key
c=0.3
plot "KE/ffmd-water-KE.dat" using ($1*0.001):(avg_n($3*c+0.0006)) title       "Pure liquid water" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
     "KE/ffmd-mgcl2-2mol-KE.dat" using ($1*0.001):(avg_n($3*c+0.0006)) title    "MgCl_2 (2 mol/L)" with line ls 1 lc rgb "green" lw 0.5,\
     "KE/ffmd-mgcl2-4mol-KE.dat" using ($1*0.001):(avg_n($3*c+0.0006)) title "MgCl_2 (4 mol/L)"   with line ls 1 lc rgb "red" lw 0.5,\
     "line.dat" using ($1):($2) notitle with line ls 0 lc rgb "black" lt 0




unset label 
unset arrow 

unset multiplot
unset output

