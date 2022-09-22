
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,6'
set key spacing 2
set key right top


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'Fig7_1.eps'

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
#-  running average
#----------------

# number of points in moving average
n = 2

# initialize the variables
do for [i=1:n] {
    eval(sprintf("back%d=0", i))
}

# build shift function (back_n = back_n-1, ..., back1=x)
shift = "("
do for [i=n:2:-1] {
    shift = sprintf("%sback%d = back%d, ", shift, i, i-1)
} 
shift = shift."back1 = x)"
# uncomment the next line for a check
# print shift

# build sum function (back1 + ... + backn)
sum = "(back1"
do for [i=2:n] {
    sum = sprintf("%s+back%d", sum, i)
}
sum = sum.")"
# uncomment the next line for a check
# print sum

# define the functions like in the gnuplot demo
# use macro expansion for turning the strings into real functions
samples(x) = $0 > (n-1) ? n : ($0+1)
avg_n(x) = (shift_n(x), @sum/samples($0))
shift_n(x) = @shift


#----------------
#-  First plot  -
#----------------

# labels and axis
set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.35, 1
set origin -0.01, 0.0

#set xrange [0:3.1]
#set ytics -0.010, 0.002, 0.006
#set label gprintf('×10^{%T}',0.008) at graph 0.0, screen 0.94 offset 0.55,-3 font 'Arial,8'
#set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)"
set ylabel "MSD of water molecules in [Å^2]" offset 1.4,0,0
set yrange [0:80]
set title "Mean square displacement"  font 'Arial,8' 
set xrange [0:3.1]
set xlabel "t (ps)"

path_to_directory1="/home/naveenk/data/Diffusion/msd/"

c=10000
plot "MSD/AMOEBA_water.csv" using ($1):($2/c) title       " Water (AMOEBA)" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
     "MSD/AMBER_water.csv" using ($1):($2/c) title    "Water (SPC)" with line ls 1 lc rgb "black" lw 0.5,\
     "MSD/AMOEBA_mgcl2-4mol.csv" using ($1):($2/c) title "4M MgCl_2 (AMOEBA)"   with line ls 1 lc rgb "red" lw 0.5 dt 0,\
     "MSD/AMBER_mgcl2-4mol.csv" using ($1):($2/c) title "4M MgCl_2 (AMBER/SPC)"   with line ls 1 lc rgb "red" lw 0.5,\


#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.31,0.0
set title "O-H vector orientation"  font 'Arial,8' 
set xlabel "t (ps)"
set xrange [0:1.5]
path_to_directory1="/home/naveenk/data/Diffusion/"
set ylabel "<cos {/Symbol q}>" offset 1.4,0,0
set yrange [0:2]
c=2.5
plot "rotation/PFFMD_water" using ($1*0.001):2 title       " Water (AMOEBA)" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
     "rotation/FFMD_water" using ($1*0.001):2 title    "Water (SPC)" with line ls 1 lc rgb "black" lw 0.5,\
     "rotation/PFFMD_mgcl2_4mol" using ($1*0.001):2 title "4M MgCl_2 (AMOEBA)"   with line ls 1 lc rgb "red" lw 0.5 dt 0,\
     "rotation/FFMD_mgcl2_4mol" using ($1*0.001):2 title "4M MgCl_2 (AMBER/SPC)"   with line ls 1 lc rgb "red" lw 0.5,\


set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.37, 1
set origin 0.64,0.0
set yrange [0:3.8]
set ytics 0,1,5
set xrange [2.4:5]
set xlabel "r (Å)"
set key 
set title "Radial distribution function" font 'Arial,8'  
set ylabel "g_{O-O}(r)" offset 1.2,0,0

set key
plot "rdf/AMOEBA_rdf_water.dat" using 1:2 title       "Water (AMOEBA)" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
     "rdf/AMBER_rdf_water.dat" using 1:2 title    "Water (SPC)" with line ls 1 lc rgb "black" lw 0.5,\
     "rdf_waterspecies/AMOEBA_water_around_mg" using 1:(0.2*$2+0.85*$4) title "H_2O around Mg^{2+} (AMOEBA)"   with line ls 1 lc rgb "red" lw 0.5 dt 0,\
     "rdf_waterspecies/AMBER_water_around_mg" using 1:(0.2*$2+0.85*$4) title "H_2O around Mg^{2+} (AMBER/SPC)"   with line ls 1 lc rgb "red" lw 0.5 ,\

#plot "rdf/AMOEBA_rdf_water.dat" using 1:2 title       "Water (AMOEBA)" with line ls 1 lc rgb "black" lw 0.2 dt 0,\
#     "rdf/AMBER_rdf_water.dat" using 1:2 title    "Water (SPC)" with line ls 1 lc rgb "black" lw 0.5,\
#     "rdf/AMOEBA_rdf_mgcl2-4mol.dat" using 1:2 title "4M MgCl_2 (AMOEBA)"   with line ls 1 lc rgb "red" lw 0.5 dt 0,\
#     "rdf/AMBER_rdf_mgcl2-4mol.dat" using 1:2 title "4M MgCl_2 (AMBER-SPC)"   with line ls 1 lc rgb "red" lw 0.5 ,\


unset multiplot
unset output

