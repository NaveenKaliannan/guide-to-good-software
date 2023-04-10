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
set output 'Spectra.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'Spectra.pdf'


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
set yrange [0:0.007]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "Power Spectra (arb. units.)" offset 4,0,0 font 'Arial,9'


set xrange [0:1100] 
set ytics offset 0.5,0,0
set ytics 0, 0.2, 0.6 font 'Arial,6 
set xtics offset 0,0.5,0

set xtics font 'Arial,9'
set title "v(0).v(t)"   font 'Arial,10' offset 0,-0.5,0  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1
set xlabel "{/Symbol w} (cm^{-1})" font 'Arial,9'  offset 0,1.,0
plot "nopulse.dat" using ($1):($2) title      "Field-Free conditions" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     '10-times.dat' using ($1):($2) title "Weak THz pulse"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     "24-times.dat" using ($1):($2) title "Strong THz pulse"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:1100] 
set yrange [0:0.1]
set xlabel "{/Symbol w} (cm^{-1})" font 'Arial,9'  offset 0,1,0
unset ytics
set ytics format " "

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

set title "{/Symbol w}(0).{/Symbol w}(t)" font 'Arial,10'  textcolor rgb "blue"
c=1
plot "nopulse.dat" using ($1):($6) notitle with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     '10-times.dat' using ($1):($6) notitle "Weak THz pulse"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     "24-times.dat" using ($1):($6) notitle "Strong THz pulse"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\



unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:1100] 
set xlabel "{/Symbol w} (cm^{-1})" font 'Arial,9'  offset 0,1,0
set key 

set yrange [0:0.004]
set title "v_{COM}(0).v_{COM}(t)"  font 'Arial,10'  textcolor rgb "blue"
set key
c=1
plot "nopulse.dat" using ($1):($4) notitle      "Field-Free conditions" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     '10-times.dat' using ($1):($4) notitle "Weak THz pulse"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     "24-times.dat" using ($1):($4) notitle "Strong THz pulse"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\


unset multiplot
unset output

