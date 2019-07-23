setwd("C:/Users/chris/OneDrive/Documents/LaTeX/Msc2/experiments")

mypng <- function(filename) {
  png(
    filename,
    width     = 3.3,
    height    = 3.3,
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
plot(x, getters1/thou, log='', type='l', xlab="clone work units",
     ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=2, lty=2)
lines(x, getters2/thou, type='l', col=3, lty=3)
lines(x, getters3/thou, type='l', col=3, lty=3)
lines(x, getters4/thou, type='l', col=4, lty=4)
lines(x, getters5/thou, type='l', col=5, lty=5)
legend("topleft", legend=1:5 , col=1:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("clone_compete_1.png")
plot(x, getters1/thou, log='xy', type='l', xlab="clone work units",
     ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=3, lty=2)
lines(x, getters2/thou, type='l', col=3, lty=3)
lines(x, getters3/thou, type='l', col=3, lty=3)
lines(x, getters4/thou, type='l', col=4, lty=4)
lines(x, getters5/thou, type='l', col=5, lty=5)
legend("topleft", legend=1:5 , col=1:5,  ncol=2,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()
