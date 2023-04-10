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
set output 'waterspectra.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'OO_RDF.pdf'


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
set origin .08, 0.0


set xrange [0:3.1]
set yrange [0:5]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "g_{O-O} (r)" offset 3,0,0 font 'Arial,9'


set xrange [2:6] 
set ytics offset 0.5,0,0
set ytics 0, 2, 6 font 'Arial,6 
set xtics offset 0,0.5,0

set xtics font 'Arial,9'
set title "Pure liquid water"   font 'Arial,10' offset 0,-0.5,0  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1
set xlabel "r_{ij} (Å)" font 'Arial,9'  offset 0,1.,0
plot "AIMD_water" using ($1):($2) title      "AIMD" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     'AMOEBA_water' using ($1):($2) title "AMOEBA"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     "AMBER_water" using ($1):($2) title "SPC"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.40,0.0
set xrange [2:6] 
set yrange [0:5]
set xlabel "r_{ij} (Å)" font 'Arial,9'  offset 0,1.,0
unset ytics
set ytics format " "

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

set title "MgCl_2 [2 M]"  font 'Arial,10'  textcolor rgb "blue"
c=1
plot "AIMD_mgcl2" using ($1):($2) title      "AIMD" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     'AMOEBA_mgcl2' using ($1):($2) title "AMOEBA"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     "AMBER_mgcl2" using ($1):($2) title "AMBER/SPC"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\


unset label 
unset arrow 

unset multiplot
unset output

