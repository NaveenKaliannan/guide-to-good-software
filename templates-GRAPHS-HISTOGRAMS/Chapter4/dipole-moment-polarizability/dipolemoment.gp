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
set output 'validation.pdf'


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
set size 0.42, 1
set origin -0.06, 0.0


set xrange [2:10]
set yrange [-15:15]
set xtics font 'Arial,6'  offset 0,0.5,0
set ytics font 'Arial,6'  offset 0.5,0.0,0


set ylabel "Dipole Moment [Debye]" font 'Arial,9'  offset 3.2,0,0
set title "{/Symbol m}_x"  font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.3,0
unset key
plot "mgcl2-ref.dat" using ($1*0.001):($2) title    "first-principle" with line ls 1 lc rgb "black" lw 0.5,\
     "mgcl2.dat" using ($1*0.001):($2) title    "DID approach" with line ls 1 lc rgb "red" lw 0.5 dt 4,\




unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.42, 1
set origin 0.26,0.0

set xrange [2:10]
set yrange [10:18]
set xtics font 'Arial,6'  offset 0,0.5,0
set ytics font 'Arial,6'  offset 0.5,0.0,0


set ylabel "Polarizability [Å^3]" font 'Arial,9'  offset 3.2,0,0
set title "Diagonal component {/Symbol a}_{xx}"  font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.3,0
unset key
plot "mgcl2-ref.dat" using ($1*0.001):($5) notitle    "first-principle" with line ls 1 lc rgb "black" lw 0.5,\
     "mgcl2.dat" using ($1*0.001):($5) notitle    "DID approach" with line ls 1 lc rgb "red" lw 0.5 dt 4,\



unset label 
unset arrow 

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.42, 1
set origin 0.56,0.0

set xrange [2:10]
set yrange [-5:5]
set xtics font 'Arial,6'  offset 0,0.5,0
set ytics font 'Arial,6'  offset 0.5,0.0,0

unset ylabel
set title "Non diagonal component {/Symbol a}_{xy}"  font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="/home/naveenk/data/with-and-witout-damping-function-PFFMD/with"

set key
c=1

set xlabel "t (ps)" font 'Arial,9'  offset 0,1.3,0
set key
plot "mgcl2-ref.dat" using ($1*0.001):($8) title    "First-principle" with line ls 1 lc rgb "black" lw 0.5,\
     "mgcl2.dat" using ($1*0.001):($8) title    "DID" with line ls 1 lc rgb "red" lw 0.5 dt 4,\



unset multiplot
unset output

