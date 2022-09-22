
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,6'
set key spacing 2
set key right


set terminal postscript eps enhanced size 4.0in,4.8in
set output 'classify.eps'

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
set multiplot layout 5,2 rowsfirst

path_to_directory1="/home/naveenk/ExtendedDIDmodel/AMOEBA/simulationdata/8times/7.5"
path_to_directory2="/home/naveenk/ExtendedDIDmodel/AMBER/simulationdata/8times/7.5"
path_to_directory3="/home/naveenk/ExtendedDIDmodel/Experiments"

#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.965; set bmargin at screen 0.782
set size 0.37, 1
set origin 0.01, 0.0


set xrange [0:3.1]
set yrange [-0.0043:0.003]
set title "Non-polarizable force fields"  font 'Arial,8' 
set label "a) Ions " at 0.25,0.0023 font 'Arial,8'  textcolor rgb "blue"

#plotting
unset ytics
unset key
unset xlabel 
set xtics format ""


set key outside
set key right top
set key at 4.9, 0.0025

plot path_to_directory2."/0mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory2."/4mol/EDIDsecond.dat" using ($1*0.001):($10 - 0) title    "Mg" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($10 - 0 ) title   "Na "   with line ls 1 lc rgb "brown" lw 0.2,\
     path_to_directory2."/4mol/EDIDsecond.dat" using ($1*0.001):($11 -  0  ) title "Cl"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($11 - 0) title    "SO_4" with line ls 1 lc rgb "blue" lw 0.5,\


unset label 
unset label 
unset arrow 
unset ylabel
unset ytics
unset key



#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.965; set bmargin at screen 0.782
set size 0.37, 1
set origin 0.45,0.0


set xrange [0:3.1]
set yrange [-0.0043:0.003]
set title "Polarizable force fields"  font 'Arial,8' 


#plotting
unset ytics
unset key
unset xlabel 
set xtics format ""


set key
plot path_to_directory1."/twater/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory1."/tmgcl2/EDIDsecond.dat" using ($1*0.001):($10 - 0) title    "Mg" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory1."/tnacl/EDIDsecond.dat" using ($1*0.001):($10 - 0 ) title   "Na "   with line ls 1 lc rgb "brown" lw 0.2,\
     path_to_directory1."/tnacl/EDIDsecond.dat" using ($1*0.001):($11 -  0  ) title "Cl"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory1."/tnaf/EDIDsecond.dat" using ($1*0.001):($11 - 0 ) title   "F"   with line ls 1 lc rgb "blue" lw 0.2,\

unset title
unset label 

# labels and axis
set tmargin at screen 0.779; set bmargin at screen 0.599
set size 0.37, 1
set origin 0.01, 0.0

unset title
unset xtics
set xlabel
set xrange [0:3.1]
set yrange [-0.0043:0.003]


set label "b) H_2O around cation " at 0.25,0.0023 font 'Arial,8'  textcolor rgb "blue"

unset key
#plotting
set xrange [0:3.1]
set xtics format ""
unset ytics
set ytics format " "


set key
plot path_to_directory2."/0mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory2."/2mol/EDIDsecond.dat" using ($1*0.001):($3 - 0) title    "H_2O around Mg" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($3 - 0 ) title   "H_2O around Na "   with line ls 1 lc rgb "brown" lw 0.2,\


unset label 
unset arrow 
unset ylabel
unset ytics
unset key


unset label 
unset arrow 
unset ylabel
unset ytics
unset key



#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.779; set bmargin at screen 0.599
set size 0.37, 1
set origin 0.45,0.0

set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "
unset xlabel 
set key
plot path_to_directory1."/twater/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory1."/tmgcl2/EDIDsecond.dat" using ($1*0.001):($3 - 0) title    "H_2O around Mg" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory1."/tnacl/EDIDsecond.dat" using ($1*0.001):($3 - 0 ) title   "H_2O around  Na "   with line ls 1 lc rgb "brown" lw 0.2,\




# labels and axis
set tmargin at screen 0.599; set bmargin at screen 0.416
set size 0.37, 1
set origin 0.01, 0.0

unset title
unset xtics
set xlabel
set xrange [0:3.1]
set yrange [-0.0043:0.003]
set label "b) H_2O around anion " at 0.25,0.0023 font 'Arial,8'  textcolor rgb "blue"
set xlabel "t (ps)"
set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [arb. unit]" offset 0,0,0
unset key
#plotting
#plotting
unset ytics
unset key
unset xlabel 
set xtics format ""
unset ytics
set ytics format " "

set key
plot path_to_directory2."/0mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory2."/1mol/EDIDsecond.dat" using ($1*0.001):($4 - 0) title    "H_2O around CL" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($4 - 0 ) title   "H_2O around SO_4"   with line ls 1 lc rgb "brown" lw 0.2,\


unset label 
unset arrow 
unset ylabel
unset ytics
unset key


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.599; set bmargin at screen 0.416
set size 0.37, 1
set origin 0.45,0.0

set xrange [0:3.1]

unset ytics
set ytics format " "
unset xlabel 

set key
plot path_to_directory1."/twater/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory1."/t6mol/EDIDsecond.dat" using ($1*0.001):($4 - 0) title    "H_2O around SO_4" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory1."/tnaf/EDIDsecond.dat" using ($1*0.001):($4 - 0 ) title   "H_2O around  F"   with line ls 1 lc rgb "brown" lw 0.2,\

unset ylabel


# labels and axis
set tmargin at screen 0.416; set bmargin at screen 0.233
set size 0.37, 1
set origin 0.01, 0.0

unset title
unset xtics
set xlabel
set xrange [0:3.1]
set yrange [-0.0043:0.003]

set label "b) H_2O btwn cation and anion " at 0.25,0.0023 font 'Arial,8'  textcolor rgb "blue"


#plotting
unset ytics
unset key
unset xlabel 
set xtics format ""
unset ytics
set ytics format " "

set key
plot path_to_directory2."/0mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory2."/2mol/EDIDsecond.dat" using ($1*0.001):($5 - 0) title    "H_2O btwn Mg and Cl" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($5 - 0 ) title   "H_2O btwn Na and SO_4"   with line ls 1 lc rgb "brown" lw 0.2,\
     path_to_directory2."/nacl/EDIDsecond.dat" using ($1*0.001):($5 - 0 ) title   "H_2O btwn Na and Cl"   with line ls 1 lc rgb "blue" lw 0.2,\
     path_to_directory2."/mgso4/EDIDsecond.dat" using ($1*0.001):($5 - 0 ) title   "H_2O btwn Mg and SO_4"   with line ls 1 lc rgb "red" lw 0.2,\


unset label 
unset arrow 
unset ylabel
unset ytics
unset key


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.416; set bmargin at screen 0.233
set size 0.37, 1
set origin 0.45,0.0

set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "
unset xlabel 
set key
plot path_to_directory1."/twater/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory1."/tmgcl2/EDIDsecond.dat" using ($1*0.001):($5 - 0) title    "H_2O btwn Mg and Cl" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory1."/tnacl/EDIDsecond.dat" using ($1*0.001):($5 - 0 ) title   "H_2O btwn Na and Cl"   with line ls 1 lc rgb "brown" lw 0.2,\




# labels and axis
set tmargin at screen 0.233; set bmargin at screen 0.05
set size 0.37, 1
set origin 0.01, 0.0

unset title
unset xtics
set xlabel
set xrange [0:3.1]
set yrange [-0.0043:0.003]
set label "b) Bulk water " at 0.25,0.0023 font 'Arial,8'  textcolor rgb "blue"

unset key
#plotting
set xrange [0:3.1]
set xtics format
unset ytics
set ytics format " "
set xlabel "t (ps)"

set key
plot path_to_directory2."/0mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory2."/2mol/EDIDsecond.dat" using ($1*0.001):($7 - 0) title    "Bulk water in MgCl_2" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory2."/6mol/EDIDsecond.dat" using ($1*0.001):($7 - 0 ) title   "Bulk water in Na_2SO_4"   with line ls 1 lc rgb "brown" lw 0.2,\
     path_to_directory2."/nacl/EDIDsecond.dat" using ($1*0.001):($7 - 0 ) title   "Bulk water in NaCl"   with line ls 1 lc rgb "blue" lw 0.2,\
     path_to_directory2."/mgso4/EDIDsecond.dat" using ($1*0.001):($7 - 0 ) title   "Bulk water in MgSO_4"   with line ls 1 lc rgb "red" lw 0.2,\


unset label 
unset arrow 
unset ylabel
unset ytics
unset key


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.233; set bmargin at screen 0.05
set size 0.37, 1
set origin 0.45,0.0

set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "

set key
plot path_to_directory1."/twater/EDIDsecond.dat" using ($1*0.001):($2 - 0) title "Pure liquid H_2O" with line ls 1 lc rgb "black" dt 0 lw 0.5,\
     path_to_directory1."/tmgcl2/EDIDsecond.dat" using ($1*0.001):($7 - 0) title    "Bulk water in MgCl_2" with line ls 1 lc rgb "violet" lw 0.5,\
     path_to_directory1."/tnacl/EDIDsecond.dat" using ($1*0.001):($7 - 0 ) title   "Bulk water in NaCl"   with line ls 1 lc rgb "brown" lw 0.2,\
     path_to_directory1."/tnaf/EDIDsecond.dat" using ($1*0.001):($7 - 0 ) title   "Bulk water in NaF"   with line ls 1 lc rgb "blue" lw 0.2,\




set nomultiplot

unset multiplot
unset output

