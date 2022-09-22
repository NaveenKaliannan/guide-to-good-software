
# Setting the terminal
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,11'  linewidth 1.5

set key font 'Arial,8'
set key spacing 2.4
#set key top left horiz
set key outside top
set key at screen 1, graph 1

##set terminal pdfcairo enhanced size 4.5in,4.8in
##set output 'population.pdf'

set terminal postscript eps enhanced size  4.0in,1.8in
set output 'Fig6.eps'

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
set multiplot layout 1,1 rowsfirst

#----------------
#-  running average
#----------------

# number of points in moving average
n = 10

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

unset xtics
set tmargin at screen 0.90; set bmargin at screen 0.15
set size 0.8, 1
set origin -0.015, 0.0
set ylabel "Number of H_2O" font 'Arial,11' 
set xrange [0.9:7.5]
set yrange [0:100]
set xtics 1.25,1,3.25
set ytics 0.0,20,100

# labels and axis
set xtics
set xlabel "Aqueous salt solutions"
set ylabel "{/Symbol D}{/Symbol a}_{Salt}/{/Symbol D}{/Symbol a}_{Pure liquid water} in [no unit]"
set xrange [0.9:6]
set yrange [0:10]
set xtics 1.25,1,3.25
set ytics ("0" 0, "1" 1, "2" 2, "3" 3, "4" 4, "5" 5, "6" 6, "7" 7, "8" 8, "9" 9, "10" 10)
set xtics ("MgCl_2 [1mol]" 1.4, "MgCl_2 [2mol]" 2.4,  "MgCl_2 [4mol]" 3.4, "Na_2SO_4 [1mol]" 4.4, "NaCl [4mol]" 5.4) font 'Arial,6.5'
set boxwidth 0.1
set style fill solid
set label "PFFMD" at 4.5,9.5

c=-0.00076
plot      "line.dat" using 1:2 title "Liquid water (reference)" with line ls 1 dt 0 lc rgb "black" lw 1, \
     "classify.dat" using ($1):($2/c) title "Cation" with boxes lw 0.5 lc rgb "light-red",\
      "classify.dat" using ($3):($4/c) title "H_2O around Anion" with boxes lw 0.5 lc rgb "medium-blue",\
      "classify.dat" using ($5):($6/c) title "H_2O around Cation" with boxes lw 0.5 lc rgb "light-green",\
      "classify.dat" using ($9):($10/c) title "Rem. H_2O (bulk water)" with boxes lw 0.5 lc rgb "cyan",\
      "classify.dat" using ($7):($8/c) title "H_2O btwn Cation and anion" with boxes lw 0.5 lc rgb "orange",\
      "classify.dat" using ($11):($12/c) title "Anion" with boxes lw 0.5 lc rgb "yellow",\
      "line.dat" using 1:2 notitle "pure liquid water (reference)" with line ls 1 dt 0 lc rgb "black" lw 1, \


##set tmargin at screen 0.90; set bmargin at screen 0.15
##set size 0.35, 1
##set origin 0.63, 0.0

##set title "Na_2SO_4 solution [1 mol/L]"  font 'Arial,8' 
##set xrange [0:3.1]
##set xtics 0,0.5,3.1
##set xlabel "t (ps)"
##set xrange [0:3.1]
##set yrange [-0.0073:0.003]
##set ytics -0.006, 0.002, 0.006
##set label gprintf('×10^{%T}',0.008) at graph 0.0, screen 0.94 offset 0.55,-3 font 'Arial,8'
##set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]" offset 0,0,0

##set format y '%.1t'  # Format for 'y' values using mantissa  


##plot "../pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2 - 0)  notitle "Pure liquid water (reference)" with line ls 1 dt 0 lc rgb "black" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($10 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "light-red" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($4 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "medium-blue" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($3 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "light-green" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($7 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "cyan" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($5 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "orange" lw 0.5, \
##      "../na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($11 - 0)  notitle "Pure liquid water (reference)" with line ls 1 lc rgb "yellow" lw 0.5, \

##unset label 
##unset arrow 



unset multiplot
unset output





