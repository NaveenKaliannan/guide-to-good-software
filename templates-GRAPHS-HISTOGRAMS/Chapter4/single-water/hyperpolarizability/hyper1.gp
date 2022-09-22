
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1.5
set key width 0.5 height 0.5
set key font 'Arial,6'
set key spacing 2
set key right


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'Fig5.eps'

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

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.35, 1
set origin -0.009, 0.0


set label "{/Symbol b}_{xxx}" at 0.5,30  font 'Arial,20' textcolor rgb "black"
set xrange [0:2]
set yrange [-40:40]
set xlabel "t (ps)"
set ylabel "Hyperpolarizability [atomic unit]" offset 1,0,0

##set ytics 1, 1, 2


#plotting
plot "abinito" using ($1*0.001):($2) title "Ab inito method (BLYP and TZV2P basis)"  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using ($1*0.001):($2) title "Our parameters"  with line ls 1 lc rgb "red" lw 0.5

unset label 
unset arrow 
unset ylabel
unset ytics
unset key
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.27,0.0

set label "{/Symbol b}_{yyy}" at 0.5,30  font 'Arial,20' textcolor rgb "black"
set xrange [0:2]
set xlabel "t (ps)"

plot "abinito" using ($1*0.001):($3) notitle  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using ($1*0.001):($3) notitle  with line ls 1 lc rgb "red" lw 0.5

unset label 
unset arrow 
#-----------------
#-  third plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.57,0.0

set label "{/Symbol b}_{zzz}" at 0.5,30 font 'Arial,20' textcolor rgb "black"
set xrange [0:2]
set xlabel "t (ps)"

plot "abinito" using ($1*0.001):($4) notitle  with line ls 1 lc rgb "blue" lw 1, "ourparameters" using ($1*0.001):($4) notitle  with line ls 1 lc rgb "red" lw 0.5

unset multiplot
unset output






