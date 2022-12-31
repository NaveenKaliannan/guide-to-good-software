set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,9'
set key spacing 1.8
set key right top at 6,0.04


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'cosine_total_ions.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'salt-PA.pdf'


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
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.004:0.0059]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "< cos {/Symbol q}> in [10^{-2}]" offset 4,0,0 font 'Arial,9'


set xrange [0:3.1]
set ytics offset 0.5,0,0
set yrange [-0.066:0.055]
set xtics offset 0,0.5,0
set ytics -0.10, 0.02, 0.06 font 'Arial,6 
set xtics font 'Arial,9'

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
plot "mgcl2_cosine.dat" using ($1*0.001):($2 - -0.0268571)  title "H_2O in MgCl_2"   with line ls 1 lc rgb "red" lw 0.2, \
     "na2so4_cosine.dat" using ($1*0.001):($2 - -0.0482511) title "H_2O in Na_2SO_4"  with line ls 1 lc rgb "blue" lw 0.2,\
     "mgso4_cosine.dat" using ($1*0.001):($2 - -0.0275325) title "H_2O in MgSO_4"  with line ls 1 lc rgb "green" lw 0.2, \
     "purewater_cosine.dat" using ($1*0.001):($2 - 0.0216945 ) title "Pure H_2O"  with line ls 1 lc rgb "black" lw 0.2  , \
      "pulse.dat" using ($1*0.001):($2*30) title "E_{THz}"  with line ls 1 lc rgb "gray" lw 0.8 dt 1


unset label 
unset arrow 
unset ylabel
unset ytics

unset multiplot
unset output

