set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,9'
set key spacing 1.6
set key right top


#set terminal postscript eps enhanced size 4.0in,1.8in
#set output 'salt-PA.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'na2so4-PA.pdf'


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
set yrange [-0.0093:0.003]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [arb. unit]" offset 4,0,0 font 'Arial,9'


set xrange [0:3.1]
set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6 
set xtics font 'Arial,9'
set label "{/Symbol D}{/Symbol a}_{PFFMD and with thole dampling}"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="../with-and-witout-damping-function-PFFMD/with"

unset key
c=1
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
c=2.5
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "Pure liquid water" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "MgCl_2 (1 mol/L)" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\


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
set xrange [0:3.1]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset ytics
set ytics format " "

path_to_directory1="../PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"
path_to_directory1="../with-and-witout-damping-function-PFFMD/without"

set label "{/Symbol D}{/Symbol a}_{PFFMD and No thole dampling}"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
c=1
c=2.5
unset key
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "Pure liquid water" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "MgCl_2 (1 mol/L)" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\


unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 

set label "{/Symbol D}{/Symbol a}_{FFMD}"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="../FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied/with-damping"

set key bottom font 'Arial,9'
c=1
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "Pure liquid water" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "Na_2SO_4 (1 mol/L)" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\


unset multiplot
unset output

