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
set output 'HBstrength-water.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output 'HBstrength-water.pdf'


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
set size 0.43, 1
set origin -0.06, 0.0


set xrange [0:3.9]
set yrange [-16:-15.7]






set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -16, 0.1, -15.5 font 'Arial,6'
set xtics font 'Arial,6



set key
c=1
set label " {/Symbol D}E_{Donor+Acceptor} interac."  at 0.05,-15.72 font 'Arial,9'  textcolor rgb "blue"


set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set ylabel "H-bond strength ( kJ per mol )" offset 4.8,0,0 font 'Arial,9'
unset key
plot "hbstrength" using ($1*0.001):($2*c - 0) title    "{/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "black" lw 0.5,\
     'hbstrength' using ($1*0.001):($2*c + 0.0358):($2*c - 0.0358) with filledcurves lc "black" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*100000-15.914818242) title "E^2_{THz}"  with line ls 1 lc rgb "#f03232" lw 0.8 dt 7

unset ylabel
unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.43, 1
set origin 0.268,0.0
set xrange [0:3.9]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set ytics -20.80, 0.1, -20.20 font 'Arial,6'  offset 0.5,0,0 font 'Arial,6'

set yrange [-20.6:-20.20]

set label " Strongest {/Symbol D}E_{Donor} interac."  at 0.05,-20.23 font 'Arial,9'  textcolor rgb "blue"

set label "NaCl [4 M]"  at 0.2,0.0045 font 'Arial,9'  textcolor rgb "blue"
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset key
plot "hbstrength" using ($1*0.001):($3*c - 0) title    "{/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "black" lw 0.5,\
     'hbstrength' using ($1*0.001):($3 + 0.0358):($3 - 0.0358) with filledcurves lc "black" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*150000-20.5) title "E^2_{THz}"  with line ls 1 lc rgb "#f03232" lw 0.8 dt 7




unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.43, 1
set origin 0.59,0.0

set xrange [0:3.9]
set yrange [-10.15:-9.86]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set label "Second strongest {/Symbol D}E_{Donor} interac."  at 0.05,-9.88 font 'Arial,9'  textcolor rgb "blue"
set ytics -10.10, 0.1, -9.20 font 'Arial,6'  offset 0.5,0,0 font 'Arial,6'

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
unset key
plot "hbstrength" using ($1*0.001):($4*c - 0) title    "{/Symbol D}{/Symbol a}^{perm} + {/Symbol D}{/Symbol a}^{ind}" with line ls 1 lc rgb "black" lw 0.5,\
     'hbstrength' using ($1*0.001):($4*c + 0.0358):($4 - 0.0358) with filledcurves lc "black" notitle,\
      "pulse.dat" using ($1*0.001):(f($2)*100000-10.08) title "E^2_{THz}"  with line ls 1 lc rgb "#f03232" lw 0.8 dt 7



unset multiplot
unset output

