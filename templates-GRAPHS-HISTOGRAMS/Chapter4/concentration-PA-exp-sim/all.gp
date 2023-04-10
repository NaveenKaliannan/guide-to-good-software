set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,6'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,8'
set key spacing 1.4
set key right top


#set terminal postscript eps enhanced size 4.0in,1.8in
#set output 'salt-PA.eps'


set style fill transparent solid 0.25 # partial transparency
set style fill noborder # no separate top/bottom lines


set term png truecolor  # or "set term pngcairo"
set terminal pdfcairo enhanced size 4.0in,5.2in
set output 'salt-PA_c.pdf'


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
set tmargin at screen 0.965; set bmargin at screen 0.745
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.0093:0.003]


set format y '%.1t'  # Format for 'y' values using mantissa  


set label "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [arb. unit]" offset 4,0,0 at -1.3,-0.027 rotate by 90 left font 'Arial,9'


set title "TKE Experiments" font 'Arial,11'  offset 0.0,-0.5,0

set xrange [0:3.1]
set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6 
set xtics font 'Arial,9'
set label "MgCl_2"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
set xtics format " "
path_to_directory1="../with-and-witout-damping-function-PFFMD/with"
set key font 'Arial,8'
set key bottom



set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

c=1
c=0.4
plot "../experiment/H2O.dat" using ($1+1.15):($2*c) title       "H_2O" with line ls 1 lc rgb "black" lw 1.5 dt 4,\
     "../experiment/MgCl2_1M.dat" using ($1+1.15):($2*c) title    "1 M" with line ls 1 lc rgb "green" lw 1.5 dt 4,\
     "../experiment/MgCl2_2M.dat" using ($1+1.15):($2*c) title    "2 M" with line ls 1 lc rgb "blue" lw 1.5 dt 4,\
     "../experiment/MgCl2_4M.dat" using ($1+1.15):($2*c) title "4 M"   with line ls 1 lc rgb "red" lw 1.5 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.965; set bmargin at screen 0.745
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:3.1]
unset ytics
set ytics format " "
set xtics format " "
path_to_directory1="../with-and-witout-damping-function-PFFMD/with"
set title "PFFMD (AMOEBA)" font 'Arial,11'  offset 0.0,-0.5,0
set label "MgCl_2"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label

set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

c=1
c=2.5
unset key
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/mgcl2-1mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "1 M" with line ls 1 lc rgb "green" lw 0.5 dt 4,\
     path_to_directory1."/mgcl2-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\
     path_to_directory1."/mgcl2-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/mgcl2-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\
     path_to_directory1."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2 dt 4,\
     path_to_directory1."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "red" notitle,\

unset title
unset label 
unset arrow 

set tmargin at screen 0.965; set bmargin at screen 0.745
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set key 
set xtics format " "
set label "MgCl_2"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
set title "FFMD (AMBER/SPC)" font 'Arial,11'   offset 0.0,-0.5,0
path_to_directory1="../FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied/with-damping"


set arrow 1 from 2, -0.004  to 2, -0.0025 fill lc rgb "brown" 

set key bottom font 'Arial,8'
c=1
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/mgcl2-1mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title    "1 M" with line ls 1 lc rgb "green" lw 0.5 dt 4,\
     path_to_directory1."/mgcl2-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\
     path_to_directory1."/mgcl2-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/mgcl2-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\
     path_to_directory1."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2 dt 4,\
     path_to_directory1."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "red" notitle,\

unset title
unset label 
unset arrow 
#----------------
#-  second plot  -
#----------------

# labels and axis
set tmargin at screen 0.74; set bmargin at screen 0.51
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.0093:0.003]


set format y '%.1t'  # Format for 'y' values using mantissa  
set xtics format " "


set xrange [0:3.1]
set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6 
set xtics font 'Arial,9'
set label "Na_2SO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="../with-and-witout-damping-function-PFFMD/with"


set arrow 1 from  2, -0.004  to 2, -0.0025 fill lc rgb "brown" 

set key bottom
c=1
c=0.4
plot "../experiment/H2O.dat" using ($1+1.15):($2*c) title       "H_2O" with line ls 1 lc rgb "black" lw 2 dt 4,\
     "../experiment/Fig2_Fig3_Na2SO4.txt" using ($1+1.15):($2*c) title    "0.75 M" with line ls 1 lc rgb "green" lw 2 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.74; set bmargin at screen 0.51
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:3.1]
unset ytics
set ytics format " "

path_to_directory1="../with-and-witout-damping-function-PFFMD/with"
set xtics format " "
set label "Na_2SO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label


set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

c=1
c=2.5
unset key
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "1 M"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($4*c -  0  ) title "1 M"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($4*c + 0.00012):($4*c - 0.00012) with filledcurves lc "red" notitle,\

unset label 
unset arrow 

set tmargin at screen 0.74; set bmargin at screen 0.51
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set key 

set label "Na_2SO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
path_to_directory1="../FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied/with-damping"
set xtics format " "
set key bottom font 'Arial,8'


set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

c=1
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "1 M"   with line ls 1 lc rgb "green" lw 0.5 dt 4,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "green" notitle,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($4*c -  0  ) title "H_2O around SO_4^{2-}"   with line ls 1 lc rgb "red" lw 0.5 dt 4,\
     path_to_directory1."/na2so4-1mol/EDIDsecond.dat" using ($1*0.001):($4*c + 0.00012):($4*c - 0.00012) with filledcurves lc "red" notitle,\

unset label 
unset arrow
#----------------
#-  third plot  -
#----------------

# labels and axis
set tmargin at screen 0.505; set bmargin at screen 0.275
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.0093:0.003]


set format y '%.1t'  # Format for 'y' values using mantissa  



set xtics format " "
set xrange [0:3.1]
set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6 
set xtics font 'Arial,9'
set label "MgSO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"

path_to_directory1="../with-and-witout-damping-function-PFFMD/with"


set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

set key bottom
c=1
c=0.4
plot "../experiment/H2O.dat" using ($1+1.15):($2*c) title       "H_2O" with line ls 1 lc rgb "black" lw 2 dt 4,\
     "../experiment/Fig2_Fig3_MgSO4.txt" using ($3+1.15):($4*c) title    "2 M" with line ls 1 lc rgb "blue" lw 2 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.505; set bmargin at screen 0.275
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:3.1]
unset ytics
set ytics format " "

set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

path_to_directory1="../with-and-witout-damping-function-PFFMD/with"
set xtics format " "
set label "MgSO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
c=1
c=2.5
unset key
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/mgso4-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "MgSO_4 (2 mol/L)"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/mgso4-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\


unset label 
unset arrow 

set tmargin at screen 0.505; set bmargin at screen 0.275
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set key 

set label "MgSO_4"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
set xtics format " "
path_to_directory1="../FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied/with-damping"

set arrow 1 from 2, -0.004  to 2, -0.0025 fill lc rgb "brown" 

set key bottom font 'Arial,8'
c=1
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/mgso4-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/mgso4-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\

unset label 
unset arrow
#----------------
#-  fourth plot  -
#----------------

# labels and axis
set tmargin at screen 0.27; set bmargin at screen 0.06
set size 0.45, 1
set origin -0.06, 0.0


set xrange [0:3.1]
set yrange [-0.0093:0.003]


set format y '%.1t'  # Format for 'y' values using mantissa  



set xrange [0:3.1]
set ytics offset 0.5,0,0
set xtics offset 0,0.5,0
set ytics -0.010, 0.002, 0.006 font 'Arial,6 
set xtics font 'Arial,9'
set label "NaCl"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
set xtics format
set xtics 0,0.5,3.5 offset 0,0.5,0
path_to_directory1="../with-and-witout-damping-function-PFFMD/with"

set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

set key bottom
c=1
c=0.4
plot "../experiment/H2O.dat" using ($1+1.15):($2*c) title       "H_2O" with line ls 1 lc rgb "black" lw 2 dt 4,\
     "../experiment/Fig2_Fig3_NaCl.txt" using ($3+1.15):($4*c) title    "2 M" with line ls 1 lc rgb "blue" lw 2 dt 4,\
     "../experiment/Fig2_Fig3_NaCl.txt" using ($1+1.15):($2*c) title "4 M"   with line ls 1 lc rgb "red" lw 2 dt 4,\


unset label 
unset arrow 
unset ylabel
unset ytics
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.27; set bmargin at screen 0.06
set size 0.45, 1
set origin 0.24,0.0
set xrange [0:3.1]
set xlabel "t (ps)" font 'Arial,11'  offset 0,1.2,0
unset ytics
set ytics format " "
set xtics offset 0,0.5,0
path_to_directory1="../with-and-witout-damping-function-PFFMD/with"

set label "NaCl"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
set arrow 1 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

c=1
c=2.5
unset key
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/nacl-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "Nacl (2 mol/L)"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/nacl-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\
     path_to_directory1."/nacl-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0 ) title   "Nacl (4 mol/L)"   with line ls 1 lc rgb "red" lw 0.2 dt 4,\
     path_to_directory1."/nacl-4mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "red" notitle,\

unset xlabel
unset label 
unset arrow 

set tmargin at screen 0.27; set bmargin at screen 0.06
set size 0.45, 1
set origin 0.54,0.0

set xrange [0:3.1] 
set key 
set xtics offset 0,0.5,0

set label "NaCl"  at 0.2,0.002 font 'Arial,9'  textcolor rgb "blue"
unset label
path_to_directory1="../FFMD-150000-trajectories-Starting-frames-long-NVT-trajectories-then-pulse-applied/with-damping"

set arrow 2 from 2, -0.0025 to 2, -0.004 fill lc rgb "brown" 

set key bottom font 'Arial,8'
c=1
plot path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c - 0) title       "H_2O" with line ls 1 lc rgb "black" lw 0.2 dt 4,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "black" notitle,\
     path_to_directory1."/nacl-2mol/EDIDsecond.dat" using ($1*0.001):($2*c -  0  ) title "2 M"   with line ls 1 lc rgb "blue" lw 0.5 dt 4,\
     path_to_directory1."/nacl-2mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "blue" notitle,\
     path_to_directory1."/nacl-4mol/EDIDsecond.dat" using ($1*0.001):($2*c - 0 ) title   "4 M"   with line ls 1 lc rgb "red" lw 0.2 dt 4,\
     path_to_directory1."/nacl-4mol/EDIDsecond.dat" using ($1*0.001):($2*c + 0.00012):($2*c - 0.00012) with filledcurves lc "red" notitle,\

unset multiplot
unset output

