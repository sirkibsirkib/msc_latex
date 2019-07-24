setwd("C:/Users/chris/OneDrive/Documents/LaTeX/Msc2/experiments")

mypng <- function(filename) {
  png(
    filename,
    width     = 3.4,
    height    = 3.4,
    units     = "in",
    res       = 1000,
    pointsize = 9
  )
}
milis = 1000
thou = 1000
bil = 1000000000
#####################################################################
### RTT. measuring Reo's fifo1 on a single thread vs mpsc
### x represents changing data size in bytes (0,1,2,4,8,16)  x gives q where bytes=q&2-1
### 100_000 data movements
### 10 reps with fresh proto objects

x = 0:14
reps = 100000
reo = c(63.13461, 65.14954, 66.80122, 63.49879, 64.86871, 66.98967, 69.14193,
      69.47564, 76.61765, 89.04745, 114.10968, 134.26562,
      181.08886, 299.73297, 903.00934);
mpsc = c(9.29991, 10.65254, 10.5035, 10.92912, 10.03323, 10.07968, 11.2787,
         12.20944, 16.24493, 25.9815, 28.36046, 38.37119,
         69.29128, 163.17103, 276.16403);

mypng("rtt_0.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, reo/reps/milis*bil, log='', type='l', xlab="q for type size = 2^q-1",
     ylim=c(1, 3010), ylab = "Mean RTT (ns)")
lines(x, mpsc/reps/milis*bil, type='l', col=2, lty=2)
legend("topleft", legend=c("fifo1", "mpsc channel") , col=1:2,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:2
)
dev.off()

mypng("rtt_1.png")
op <-par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, reo/reps/milis*bil - mpsc/reps/milis*bil, log='', type='l',
     xlab="q for type size = 2^q-1", ylim=c(1, 3010), ylab = "fifo1 RTT overhead (ns)")
dev.off()


#########################################################
### "SIMO" group getting. N-way replicator with COPY type data
### x represents changing data size in bytes (0,1,2,4,8,16)  x gives q where bytes=q&2-1
### 25_000 data movements
### 100 reps with fresh proto objects

x = c(0,4,8,12,16);


getters1 = c(532, 544, 570, 990, 6241);
getters2 = c(941, 979, 1028, 1805, 9336);
getters3 = c(1712, 1678, 1755, 2534, 10868);
getters4 = c(9735, 9792, 9781, 11697, 19656);
getters5 = c(11339, 10450, 11031, 12465, 25713)


mypng("simo_copy_0.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, getters1/thou, log='', type='l', xlab="q for type size = 2^q-1",
     ylim=c(0.3, 26), ylab = "Mean sync time (μs)")


lines(x, getters2/thou, type='l', col=2, lty=2)
lines(x, getters3/thou, type='l', col=3, lty=3)
lines(x, getters4/thou, type='l', col=4, lty=4)
lines(x, getters5/thou, type='l', col=5, lty=5)
legend("topleft", legend=1:5 , col=1:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:5
)
dev.off()


### now plotted relative to getters=1
mypng("simo_copy_1.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, getters2/getters1, log='', type='l', xlab="q for type size = 2^q-1",
     ylim=c(0.8, 20), ylab = "Ratio vs getters=1", col=2, lty=2)

abline(h=1)
lines(x, getters3/getters1, type='l', col=3, lty=3)
lines(x, getters4/getters1, type='l', col=4, lty=4)
lines(x, getters5/getters1, type='l', col=5, lty=5)
legend("left", legend=2:5 , col=2:5,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=2:5
)
dev.off()


#########################################################
### "SIMO cloning" group getting. N-way replicator with CLONE type data
### x is the time in WORK UNITS for some arbitrary clone operation.

x =        c(4,     8,     16,    32,    64,    128,   256,   512,   1024,  2048,  4096,  8192);
getters1 = c(697,   633,   663,   671,   683,   678,   667,   797,   926,   820,   940,   745);
getters2 = c(1872,  1849,  1960,  1883,  2336,  4682,  3626,  8554,  28168, 24925, 52270, 66560);
getters3 = c(3878,  5019,  4979,  3421,  3161,  4996,  8398,  13045, 18986, 32706, 49233, 77842);
getters4 = c(15510, 12252, 10923, 12419, 13574, 12961, 13218, 15832, 19988, 33457, 51436, 90750);
getters5 = c(14513, 13862, 13880, 14020, 15721, 16185, 15658, 18702, 20822, 31647, 55072, 92740);

mypng("clone_compete_0.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, getters1/thou, log='', type='l', xlab="clone work units",
     ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=1, lty=2)
lines(x, getters2/thou, type='l', col=2, lty=2)
lines(x, getters3/thou, type='l', col=3, lty=3)
lines(x, getters4/thou, type='l', col=4, lty=4)
lines(x, getters5/thou, type='l', col=5, lty=5)
legend("topleft", legend=1:5 , col=1:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("clone_compete_1.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, getters1/thou, log='xy', type='l', xlab="clone work units",
     ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=1, lty=1)
lines(x, getters2/thou, type='l', col=2, lty=2)
lines(x, getters3/thou, type='l', col=3, lty=3)
lines(x, getters4/thou, type='l', col=4, lty=4)
lines(x, getters5/thou, type='l', col=5, lty=5)
legend("topleft", legend=1:5 , col=1:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("clone_compete_2.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
plot(x, getters2/getters2, log='x', type='l', xlab="clone work units",
     ylim=c(0.5, 8), ylab = "mean sych time (μs)", col=2, lty=2)
lines(x, getters3/getters2, type='l', col=3, lty=3)
lines(x, getters4/getters2, type='l', col=4, lty=4)
lines(x, getters5/getters2, type='l', col=5, lty=5)
legend("topright", legend=2:5 , col=2:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=2:5)
dev.off()



#########################################################
### TIME TAKEN FOR TRAVERSING BOGUS RULES
x = seq(from=0, to=195, by=5);

# false guard
y1 = c(266, 320, 401, 419, 478, 519, 554, 610, 651, 662, 743, 757,
       791, 846, 881, 934, 980, 1012, 1058, 1118, 1150, 1642, 1550,
       1556, 1570, 1613, 1626, 1764, 1782, 1525, 1586, 1660, 1621,
       1704, 1750, 1765, 1840, 1858, 1899, 1959);

# check false
y2 = c(240, 354, 439, 528, 723, 725, 817, 901, 1013, 1181, 1541, 1649, 1327,
       1872, 1593, 1675, 2801, 2748, 2858, 3291, 3143, 2238, 2236, 2457, 2883,
       2584, 2741, 2804, 2968, 2914, 3281, 3171, 3189, 3310, 3384, 5012,
       3679, 3861, 3666, 3938);

# 5x5 nested ands
y3 = c(245, 805, 1959, 2055, 2802, 4219, 4758, 6340, 7473, 11064,
       7851, 12751, 10694, 10875, 10974, 10919, 12607, 14100, 14769, 17073,
       15114, 16913, 17482, 19473, 17983, 21433, 21630, 22035, 23387, 27550,
       27602, 26537, 29749, 29304, 31060, 32466, 32249, 32769, 34042, 35496);

# check alloc
y4 = c(271, 1845, 3533, 4751, 6293, 8941, 11445, 11088, 12416, 13894,
       15267, 16816, 18475, 19574, 21496, 22855, 24483, 25874, 29374,
       29293, 30857, 32457, 33821, 35937, 37297, 38989, 39578, 42063,
       42334, 47088, 45782, 45958, 45899, 48499, 50892, 54469, 76016,
       66190, 60281, 61970);

leggy = c("guard", "false", "ands", "alloc");
mypng("check_time_0.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
dat <- matrix(c(y1-250, y2-250, y3-250, y4-250), ncol=4);
matplot(x, dat/thou, type = c("l"), lty=1:4, col=1:4, ylab="overhead (μs)", xlab="unsatisfied rules") #plot
legend("topleft", legend=leggy , col=1:4,  ncol=2,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("check_time_1.png")
op <- par(mar = c(5.1, 4.1, 1.8, 1.8))
matplot(x, dat/thou, type = c("l"), lty=1:4, col=1:4, log='y', ylim=c(0.23, 100), ylab="overhead (μs)", xlab="unsatisfied rules") #plot
legend("bottomright", legend=leggy , col=1:4,  ncol=2,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:4)
dev.off()