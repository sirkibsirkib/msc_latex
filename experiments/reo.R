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
bil = 1000000000
#####################################################################

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
