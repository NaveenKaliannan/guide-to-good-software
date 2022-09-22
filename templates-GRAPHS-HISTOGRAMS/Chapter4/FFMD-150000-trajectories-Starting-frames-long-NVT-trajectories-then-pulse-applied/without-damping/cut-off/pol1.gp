
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,10'  linewidth 1
##set key box lw 1
set key width 0.5 height 0.5
set key font 'Arial,8'
set key spacing 2.4
#set key top left horiz
set key outside top
set key at screen 1, graph 1


set terminal postscript eps enhanced size 4.0in,1.8in
set output 'Fig1.eps'

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
set size 0.41, 1
set origin 0.02, 0.0


set xrange [0:3.1]
set yrange [-0.0034:0.002]
set ytics -0.006, 0.002, 0.006
set label gprintf('×10^{%T}',0.008) at graph 0.0, screen 0.94 offset 0.55,-3 font 'Arial,8'
set format y '%.1t'  # Format for 'y' values using mantissa  

set xlabel "t (ps)"
set ylabel "{/Symbol a}_{xx} - 0.5 ({/Symbol a}_{yy} + {/Symbol a}_{zz}) in [Å^3]" offset 0,0,0
set title "Pure liquid H_2O"  font 'Arial,8' 
unset key
#plotting

path_to_directory1="3.5"
path_to_directory2="5.7"
path_to_directory3="7.5"
path_to_directory4="15"


plot path_to_directory1."/pureliquidwater/permpol.dat" using ($1*0.001):($2 - 0) notitle with points ls 1 ps 0.2 pt 6 lc rgb "blue" lw 0.2,\
     path_to_directory1."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2 - 0) notitle with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory2."/pureliquidwater/EDIDsecond.dat" using (($1 + 0) *0.001 ):($2 -  0  ) notitle   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory3."/pureliquidwater/EDIDsecond.dat" using ($1*0.001):($2 - 0 ) notitle   with line ls 1 lc rgb "black" lw 0.2,\

unset label 
unset arrow 
unset ylabel
unset ytics
unset key
#-----------------
#-  Second plot  -
#-----------------

set tmargin at screen 0.88; set bmargin at screen 0.15
set size 0.41, 1
set origin 0.36,0.0
set title "MgCl_2 solution [4 mol/L]"  font 'Arial,8' 
set xrange [0:3.1]
set xlabel "t (ps)"
unset ytics
set ytics format " "

set key
# {/Symbol a}^{perm} + {/Symbol a}^{ind,XXDID}_{with r_t = 0.0 Å}
plot path_to_directory1."/mgcl2-4mol/permpol.dat" using ($1*0.001):($2 - 0) title       "{/Symbol a}^{Perm.} + DID^{1,2} with r_t = 0.0 Å" with points ls 1 ps 0.2 pt 6 lc rgb "blue" lw 0.2,\
     path_to_directory1."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2 - 0) title    "{/Symbol a}^{Perm.} + DID^{1,2} with r_t = 3.5 Å" with line ls 1 lc rgb "green" lw 0.5,\
     path_to_directory2."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2 -  0  ) title "{/Symbol a}^{Perm.} + DID^{1,2} with r_t = 5.7 Å"   with line ls 1 lc rgb "red" lw 0.5,\
     path_to_directory4."/mgcl2-4mol/EDIDsecond.dat" using ($1*0.001):($2 - 0 ) title   "{/Symbol a}^{Perm.} + DID^{1,2} with r_t = 15. Å"   with line ls 1 lc rgb "black" lw 0.2,\


unset label 
unset arrow 


unset multiplot
unset output

