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
set output 'cosine-theta-pure-liquid-water.pdf'


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
set yrange [-0.065:0.06]


set format y '%.1t'  # Format for 'y' values using mantissa  


set ylabel "< cos {/Symbol q} >" offset 4,0,0 font 'Arial,9'


set xrange [0:3.1]

set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.060, 0.02, 0.06 font 'Arial,6' 
set xtics font 'Arial,6
set label gprintf('×10^{%T}',0.01) at graph 0.0, screen 0.94 offset 0.55,0 font 'Arial,8'

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key
set key right bottom
plot "total.dat" using ($1*0.001):($2*c - 0.020) title    "All water" with line ls 1 lc rgb "red" lw 0.5,\
     'total.dat' using ($1*0.001):($2*c - 0.020 + 0.006):($2*c - 0.020 - 0.006) with filledcurves lc "red" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*30000) title "E^2_{THz}"  with line ls 1 lc rgb "gray" lw 0.8


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

path_to_directory1="/home/naveenk/data/PFFMD-57000-trajectories-Starting-frames-Long-NVT-trajectrories-then-pulse-applied/polarizabilityanistropy"

c=1

set key

plot "cos1875" using ($1*0.001):($2 -  0.0179785 )  title "High {/Symbol g}_d"   with line ls 1 lc rgb "red" lw 0.5, \
     'cos1875' using ($1*0.001):($2 -  0.0179785 + 0.006):($2 -  0.0179785 - 0.006) with filledcurves lc "red" notitle,\
     "cos1875" using ($1*0.001):($4 - 0.0214689  ) title "Medium {/Symbol g}_d"  with line ls 1 lc rgb "green" lw 0.5,\
     'cos1875' using ($1*0.001):($4 - 0.0214689 + 0.006):($4 - 0.0214689 - 0.006) with filledcurves lc "green" notitle,\
     "cos1875" using ($1*0.001):($3 - 0.0295646 ) title "Low {/Symbol g}_d "  with line ls 1 lc rgb "blue" lw 0.5, \
     'cos1875' using ($1*0.001):($3 - 0.0295646 + 0.006):($3 - 0.0295646 - 0.006) with filledcurves lc "blue" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*30000) title "E^2_{THz}"  with line ls 1 lc rgb "gray" lw 0.8,\
     "line.dat" using ($1*0.001):2 notitle with line ls 1 dt 2 lc rgb "black" lw 1,\


set ytics format



unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.45, 1
set origin 0.58,0.0

set xrange [0:3.1] 
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set yrange [0:1]
set key
c=1
set ytics 0, 0.2, 1 font 'Arial,6' 
set ytics offset 0.5,0,0


set ylabel "{/Symbol g}_d value" offset 4.5,0,0 font 'Arial,9'
plot "gamma/cos1875" using ($1*0.001):($8 )  title "High {/Symbol g}_d"   with line ls 1 lc rgb "red" lw 0.2, \
     "gamma/cos1875" using ($1*0.001):($10 ) title "Medium {/Symbol g}_d"  with line ls 1 lc rgb "green" lw 0.2,\
     "gamma/cos1875" using ($1*0.001):($9 ) title  "Low {/Symbol g}_d"  with line ls 1 lc rgb "blue" lw 0.2, \
     "gamma/line.dat" using 1:2 notitle with line ls 1 dt 2 lc rgb "black" lw 1



unset multiplot
unset output

