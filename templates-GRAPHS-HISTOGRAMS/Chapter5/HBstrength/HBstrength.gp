
# Setting the terminal
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,11'  linewidth 1.5
set key font 'Arial,10'
set key spacing 2.5




##set terminal pdfcairo enhanced size 4.5in,1.8in
##set output 'population.pdf'

set terminal postscript eps enhanced size 4.5in,1.8in
set output 'HBstrength.eps'

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


set tmargin at screen 0.98; set bmargin at screen 0.15

set size 0.90, 1
set origin 0.033, 0.0

#plotting

# labels and axis
set xtics
set xlabel "Aqueous salt solutions"
set ylabel "H-bond strength (kJ per mol)"
set xrange [0.9:4.5]
set yrange [12:24]
set xtics 1.25,1,3.25
set ytics ("-6" 6, "-8" 8, "-10" 10, "-12" 12, "-14" 14, "-16" 16, "-18" 18, "-20" 20, "-22" 22, "-24" 24)
set xtics ("MgCl_2 [2 M]" 1.25, "Na_2SO_4 [1 M]" 2.25, "MgSO_4 [2 M]" 3.25)

set boxwidth 0.1
set style fill solid

set key right top 

plot  "strength.dat" using ($1):($2) title "H_2O only in solv. of Cation" with boxes lw 0.5 lc rgb "light-red", "strength.dat" using ($3):($4) title "H_2O only in solv. of Anion"  with boxes lw 0.5 lc rgb "medium-blue", "strength.dat" using ($5):($6) title "H_2O btwn Cation and anion"  with boxes lw 0.5 lc rgb "light-green", "strength.dat" using ($7):($8) title "Rem. H_2O" with boxes lw 0.5 lc rgb "orange", "line1.dat" using 1:2 title "Pure liquid water (ref.)"  with line ls 1 dt 0 lc rgb "black" lw 1


unset multiplot
unset output





