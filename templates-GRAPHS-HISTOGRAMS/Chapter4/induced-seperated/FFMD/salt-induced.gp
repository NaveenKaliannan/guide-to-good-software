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
set output 'salt-PA.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'mgcl2-total-induced_FFMD.pdf'


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


set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [10^{-3} Å^3]" offset 4,0,0 font 'Arial,9'


set xrange [0:3.1]

set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6' 
set xtics font 'Arial,6

set label "{/Symbol D}{/Symbol a}^{tot}"  at 0.2,0.0045 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset key
plot "water/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O (ref.)" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     'water/EDIDsecond.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "black" notitle,\
     "mgcl2-1mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "1 M"   with line ls 1 lc rgb "green" lw 0.5,\
     'mgcl2-1mol/EDIDsecond.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "green" notitle,\
     "mgcl2-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5,\
     'mgcl2-2mol/EDIDsecond.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "blue" notitle,\
     "mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2,\
     'mgcl2-4mol/EDIDsecond.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "red" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*1000) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7


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

set title "FFMD"  offset 0,-0.5,0
path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

set label "{/Symbol D}{/Symbol a}^{Perm}"  at 0.2,0.0045 font 'Arial,9'  textcolor rgb "blue"
c=1

unset key
plot "water/permpol.dat" using ($1*0.001):($2*c - 0) title       "H_2O (ref.)" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     'water/permpol.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "black" notitle,\
     "mgcl2-1mol/permpol.dat" using ($1*0.001):($2*c -  0  ) title "1 M"   with line ls 1 lc rgb "green" lw 0.5,\
     'mgcl2-1mol/permpol.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "green" notitle,\
     "mgcl2-2mol/permpol.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5,\
     'mgcl2-2mol/permpol.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "blue" notitle,\
     "mgcl2-4mol/permpol.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2,\
     'mgcl2-4mol/permpol.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "red" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*1000) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7


unset title
unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set label "{/Symbol D}{/Symbol a}^{ind}"  at 0.2,0.0045 font 'Arial,9'  textcolor rgb "blue"

set key
c=1
plot "water/induced.dat" using ($1*0.001):($2*c - 0) title       "H_2O (ref.)" with line ls 1 lc rgb "black" lw 0.2 dt 1,\
     'water/induced.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "black" notitle,\
     "mgcl2-1mol/induced.dat" using ($1*0.001):($2*c -  0  ) title "1 M"   with line ls 1 lc rgb "green" lw 0.5,\
     'mgcl2-1mol/induced.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "green" notitle,\
     "mgcl2-2mol/induced.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5,\
     'mgcl2-2mol/induced.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "blue" notitle,\
     "mgcl2-4mol/induced.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2,\
     'mgcl2-4mol/induced.dat' using ($1*0.001):($2*c + 0.00009):($2*c - 0.00009) with filledcurves lc "red" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*1000) title "E^2_{THz}"  with line ls 1 lc rgb "red" lw 0.8 dt 7



unset multiplot
unset output

