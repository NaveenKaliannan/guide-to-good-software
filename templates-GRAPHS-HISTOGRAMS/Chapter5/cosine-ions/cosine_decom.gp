set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,9'
set key spacing 1.5
set key right top
set key above vertical maxrows 2


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'salt-PA.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'cosine-ions-decomposed.pdf'


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
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.82; set bmargin at screen 0.11
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.066:0.055]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "< cos {/Symbol q}> in [10^{-2}]" offset 4,0,0 font 'Arial,9'


set xrange [0:3.1]

set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.10, 0.02, 0.06 font 'Arial,6' 
set xtics font 'Arial,6

set label "MgCl_2 [2 M]"  at 0.2,0.045 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset key
plot "mgcl2/mg.dat" using ($1*0.001):(avg_n($2 - -0.0631843))  title "H_2O around Mg"   with line ls 1 lc rgb "green" lw 0.2, \
     "mgcl2/cl.dat" using ($1*0.001):(avg_n($2 - -0.0478938)) title "H_2O around Cl"  with line ls 1 lc rgb "blue" lw 0.2,\
     "mgcl2/mg-cl.dat" using ($1*0.001):(avg_n($2 - -0.0563616 )) title "H_2O between Mg and Cl"  with line ls 1 lc rgb "orange" lw 0.2,\
     "mgcl2/rem.dat" using ($1*0.001):(avg_n($2 --0.00317222)) title "Rem H_2O"  with line ls 1 lc rgb "cyan" lw 0.2, \
     "purewater_cosine.dat" using ($1*0.001):($2 - 0.0216945 ) title "Pure H_2O"  with line ls 1 lc rgb "black" lw 0.2  , \


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.82; set bmargin at screen 0.11
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:3.1]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset ytics
set ytics format " "

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

set label "Na_2SO_4 [1 M]"  at 0.2,0.045 font 'Arial,9'  textcolor rgb "blue"
c=1

unset key
plot "na2so4/na.dat" using ($1*0.001):(avg_n($2 - -0.0637124))  title "H_2O around Na"   with line ls 1 lc rgb "green" lw 0.2, \
     "na2so4/so4.dat" using ($1*0.001):(avg_n($2 - -0.00654618)) title "H_2O around SO_4"  with line ls 1 lc rgb "blue" lw 0.2,\
     "na2so4/na-so4.dat" using ($1*0.001):(avg_n($2 - -0.0528339)) title "H_2O between Na and SO_4"  with line ls 1 lc rgb "orange" lw 0.2,\
     "na2so4/rem.dat" using ($1*0.001):(avg_n($2 - -0.0506759)) title "Rem H_2O"  with line ls 1 lc rgb "cyan" lw 0.2, \
     "purewater_cosine.dat" using ($1*0.001):($2 - 0.0216945 ) title "Pure H_2O"  with line ls 1 lc rgb "black" lw 0.2  , \



unset label 
unset arrow 

set tmargin at screen 0.82; set bmargin at screen 0.11
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set label "MgSO_4 [2 M]"  at 0.2,0.045 font 'Arial,9'  textcolor rgb "blue"

set key
c=1
plot "mgso4/mg.dat" using ($1*0.001):(avg_n($2 - -0.0272877))  title "H_2O around Cation"   with line ls 1 lc rgb "green" lw 0.2, \
     "mgso4/so4.dat" using ($1*0.001):(avg_n($2 - 0.034858)) title "H_2O around Anion"  with line ls 1 lc rgb "blue" lw 0.2,\
     "mgso4/mg-so4.dat" using ($1*0.001):(avg_n($2 - 0.0168957)) title "H_2O between Cation and Anion"  with line ls 1 lc rgb "orange" lw 0.2,\
     "mgso4/rem.dat" using ($1*0.001):(avg_n($2 - -0.0602664)) title "Bulk H_2O"  with line ls 1 lc rgb "cyan" lw 0.2, \
     "purewater_cosine.dat" using ($1*0.001):($2 - 0.0216945 ) title "Pure H_2O"  with line ls 1 lc rgb "black" lw 0.2  , \


unset multiplot
unset output

