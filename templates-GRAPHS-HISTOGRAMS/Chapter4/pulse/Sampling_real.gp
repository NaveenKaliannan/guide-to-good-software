
# Setting the terminal
set encoding utf8 
set terminal postscript enhanced 
set terminal postscript eps size 3.5,3 enhanced color \
    font 'Arial,14'  linewidth 1.5
set key box lw 1
set key width 0.5 height 1
set key font 'Arial,15'
set key spacing 2
unset key

#plotting
plot "pulse.dat" using ($1*0.001):($2) notitle "N = 1" with line ls 1 lw 2 lc rgb "red", 

# labels and axis
set title "THz pulse"
set xrange [0:3.1]
set yrange [-0.001:0.0015]
set xlabel "Time t (ps)"
set ylabel "Atomic unit"

# Output files
set terminal postscript eps enhanced size 4.5in,2.2in
set output 'Fig9.eps'
replot


