
# Setting the terminal
set encoding utf8 
set term pdfcairo size 3.5,3 enhanced color \
    font 'Arial,9'  linewidth 1.5

set key width 0.5 height 1
set key font 'Arial,9'
set key spacing 2
set key off

# Output files
set terminal pdfcairo enhanced size 3.0in,4.5in
set output 'DP.pdf'

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
set multiplot layout 3,1 rowsfirst


#----------------
#-  First plot  -
#----------------

set tmargin at screen 0.97; set bmargin at screen 0.85
unset xlabel
unset ylabel
set yrange [-0.0009:0.0012]
set xrange [0:4000]
set ytics offset 0.5,0  add ("" 0)
unset xtics
unset ytics
set key off

set label "E_{THz}" at 600, 0.0003
set size 1., 0.3
set origin 0.0, 0.7
set xrange [500:4000]

plot "pulse.dat" using 1:2 notitle with line ls 1 lw 1 lc rgb "red" lt 1, "line.dat" using 1:2 notitle with line ls 0 lc rgb "black" lw 0.5, "line3.dat" using 2:4 notitle with line ls 0 lc rgb "black" lw 2, "line3.dat" using 1:4 notitle with line ls 0 lc rgb "black" lw 2


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.85; set bmargin at screen 0.475
set key top right notitle spacing 1.5

set ylabel '< cos {/Symbol q}>' offset 1.5,-0.5
set yrange [-0.06:0.07]
set xrange [500:4000]
set ytics #offset 0.5,graph 0.05
#set ytics #offset 0.5,0 add ("0" 0)
unset xtics

set size 1.,0.7
set origin 0.0,0.0

unset label 

set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines

plot "Don0.20_2750.dat" using ($1):($2 -  -0.0201707) title "Low {/Symbol g } "  with line ls 1 lc rgb "blue" lw 0.5, 'Don0.20_2750.dat' using 1:($2-0.008 - -0.0201707):($2+0.008 - -0.0201707) with filledcurves lc "blue" notitle, "Don0.80_2750.dat" using ($1):($2 - -0.0261388) title "High {/Symbol g }"  with line ls 1 lc rgb "red" lw 0.5, 'Don0.80_2750.dat' using 1:($2-0.008 - -0.0261388):($2+0.008 - -0.0261388) with filledcurves lc "red" notitle, "line.dat" using 1:2 notitle with line ls 0 lc rgb "black" lw 0.5, "total.dat" using ($1):($2 - -0.0275088) title "Overall" with line ls 1 lc rgb "green" lw 0.5, "line3.dat" using 1:3 notitle with line ls 0 lc rgb "black" lw 2

#-----------------
#-  third plot  -
#-----------------

set tmargin at screen 0.475; set bmargin at screen 0.1
set key top right notitle spacing 1.5
set xlabel "Time t (fs)"
set ylabel '< cos {/Symbol q}>' offset 1.5,-0.5
set yrange [-0.06:0.07]
set xrange [500:4000]
set ytics #offset 0.5,graph 0.05
#set ytics #offset 0.5,0 add ("0" 0)
set xtics

set size 1.,0.7
set origin 0.0,0.0

unset label 

##plot "Don0.20_3750.dat" using ($1):($2 - -0.020235) title "Low {/Symbol g }"  with line ls 1 lc rgb "blue" lw 0.5,"Don0.80_3750.dat" using ($1):($2 - -0.0248028) title "High {/Symbol g }"  with line ls 1 lc rgb "red" lw 0.5, "line.dat" using 1:2 notitle with line ls 0 lc rgb "black" lw 0.5, "total.dat" using ($1):($2 - -0.0275088) title "Overall" with line ls 0 lc rgb "black" lw 0.5, "line3.dat" using 2:3 notitle with line ls 0 lc rgb "black" lw 0.5

plot "Don0.20_3750.dat" using ($1):($2 - -0.020235) title "Low {/Symbol g } "  with line ls 1 lc rgb "blue" lw 0.5, 'Don0.20_3750.dat' using 1:($2-0.008  - -0.020235):($2+0.008 - -0.020235) with filledcurves lc "blue" notitle, "Don0.80_3750.dat" using ($1):($2 - -0.0248028) title "High {/Symbol g }"  with line ls 1 lc rgb "red" lw 0.5, 'Don0.80_3750.dat' using 1:($2-0.008- -0.0248028):($2+0.008 - -0.0248028) with filledcurves lc "red" notitle, "line.dat" using 1:2 notitle with line ls 0 lc rgb "black" lw 0.5, "total.dat" using ($1):($2 - -0.0275088) title "Overall" with line ls 1 lc rgb "green" lw 0.5, "line3.dat" using 2:3 notitle with line ls 0 lc rgb "black" lw 2

###plot "Don0.20_3750.dat" using ($1):($2 - -0.020235) title "Low {/Symbol g }"  with line ls 1 lc rgb "blue" lw 0.5,"Don0.80_3750.dat" using ($1):($2 - -0.0248028) title "High {/Symbol g }"  with line ls 1 lc rgb "red" lw 0.5, "line.dat" using 1:2 notitle with line ls 0 lc rgb "black" lw 0.5, "plot_3750.dat" using ($1):($2- -0.020235):($3) notitle with yerrorbars lc rgb "blue" lw 0.3, "plot_3750.dat" using ($1):($4 - -0.0248028):($3) notitle with yerrorbars lc rgb "red" lw 0.3, "total.dat" using ($1):($2 - -0.0275088) title "Overall" with line ls 0 lc rgb "black" lw 0.5, "line3.dat" using 2:3 notitle with line ls 0 lc rgb "black" lw 2

unset multiplot
unset output



