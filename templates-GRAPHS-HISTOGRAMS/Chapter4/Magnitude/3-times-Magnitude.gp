set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,9'
set key spacing 1.5
set key right top

time=3
set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,1.8in
set output '3-times-Magnitude.pdf'


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


set xrange [0:3.2]
set yrange [-0.005:0.005]

set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.01, 0.001, 0.02 font 'Arial,6'
set xtics font 'Arial,6

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key top left
plot "pulse.dat" using ($1*0.001):($2*time) title "E_{THz} (atomic unit)"  with line ls 1 lc rgb "#f03232" lw 0.8 dt 7

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
set xrange [0:3.2]

set yrange [-0.00081:0.00081]
set ytics -0.004, 0.0002, 0.006 font 'Arial,6'  offset 0.5,0,0 font 'Arial,6'
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key top left
plot "3/EDID.dat" using ($1*0.001):($2 - 0) title    "{/Symbol D}{/Symbol a} (Å^3)" with line ls 1 lc rgb "black" lw 0.5,\
     '3/EDID.dat' using ($1*0.001):($2 + 0.00015):($2 - 0.00015) with filledcurves lc "black" notitle,\



unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.43, 1
set origin 0.59,0.0

set xrange [0:3.2]
set yrange [-0.06:0.078]
set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key 
set ytics -0.2, 0.02, 0.4 font 'Arial,6'  offset 0.5,0,0 font 'Arial,6'

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.5,0
set key top left

plot "3/cosine-KE.dat" using ($1*0.001):($3 -0.5 ) title    "Rel. KE_{trans} " with line ls 1 lc rgb "blue" lw 0.5,\
     '3/cosine-KE.dat' using ($1*0.001):($3 -0.5 + 0.001 ):($3  -0.5 - 0.001 ) with filledcurves lc "blue" notitle,\
      "3/cosine-KE.dat" using ($1*0.001):($4 -0.5 ) title    "Rel. KE_{rotat} " with line ls 1 lc rgb "green" lw 0.5,\
     '3/cosine-KE.dat' using ($1*0.001):($4  -0.5 + 0.001 ):($4 -0.5 - 0.001 ) with filledcurves lc "green" notitle,\
      "3/cosine-KE.dat" using ($1*0.001):($29) title    "< cos {/Symbol q} > " with line ls 1 lc rgb "red" lw 0.5 dt 7,\
     '3/cosine-KE.dat' using ($1*0.001):($29 + 0.001 ):($29 - 0.001 ) with filledcurves lc "red" notitle,\



unset multiplot
unset output

