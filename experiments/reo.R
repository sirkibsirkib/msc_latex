setwd("C:/Users/chris/OneDrive/Documents/LaTeX/Msc2/experiments")

mypng <- function(filename) {
  png(
    filename,
    width     = 3.4,
    height    = 3.0,
    units     = "in",
    res       = 1000,
    pointsize = 9
  )
}
mypngbig <- function(filename) {
  png(
    filename,
    width     = 4.4,
    height    = 3.5,
    units     = "in",
    res       = 1000,
    pointsize = 9
  )
}
thou = 1000
bil = thou*thou*thou
#####################################################################
### RTT. measuring Reo's fifo1 on a single thread vs mpsc
### x represents changing data size in bytes (0,1,2,4,8,16)  x gives q where bytes=q&2-1
### 100_000 data movements
### 10 reps with fresh proto objects

x = c(0, 2^(1:14))
reps = 100000
reo = c(63.13461, 65.14954, 66.80122, 63.49879, 64.86871, 66.98967, 69.14193,
      69.47564, 76.61765, 89.04745, 114.10968, 134.26562,
      181.08886, 299.73297, 903.00934);
mpsc = c(9.29991, 10.65254, 10.5035, 10.92912, 10.03323, 10.07968, 11.2787,
         12.20944, 16.24493, 25.9815, 28.36046, 38.37119,
         69.29128, 163.17103, 276.16403);

mypng("rtt_0.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(reo, mpsc), ncol=2)
matplot(x, dat/reps/thou*bil, log='x', type='b', pch=1:2, xlab="data size (bytes)",
     ylim=c(1, 3010), ylab = "Mean RTT (ns)")
legend("topleft", legend=c("fifo1", "mpsc channel") , col=1:2,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:2
)
dev.off()

mypng("rtt_1.png")
op <-par(mar = c(5.1, 4.1, 1.8, 1.8))
dat = matrix(c(reo, mpsc), ncol=2)
plot(x, (reo-mpsc)/reps/thou*bil, log='x', type='b', pch=3, col=3, lty=3,
     xlab="data_size (bytes)", ylim=c(1, 3010), ylab = "fifo1 RTT overhead (ns)")
dev.off()


#########################################################
### "SIMO" group getting. N-way replicator with COPY type data
### x represents changing data size in bytes (0,1,2,4,8,16)  x gives q where bytes=q&2-1
### 25_000 data movements
### 100 reps with fresh proto objects

x = c(0,2^4,2^8,2^12,2^16);
getters1 = c(532, 544, 570, 990, 6241);
getters2 = c(941, 979, 1028, 1805, 9336);
getters3 = c(1712, 1678, 1755, 2534, 10868);
getters4 = c(9735, 9792, 9781, 11697, 19656);
getters5 = c(11339, 10450, 11031, 12465, 25713)

mypng("simo_copy_0.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(getters1, getters2, getters3, getters4, getters5), ncol=5)
matplot(x, dat/thou, log='x', type='b', pch=1:5, xlab="data size (bytes)", col=1:5, lty=1:5,
     ylim=c(0.3, 27), ylab = "Mean sync time (μs)")
revd = rev(1:5)
legend("topleft", legend=revd , col=revd,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=revd
)
dev.off()


### now plotted relative to getters=1
mypng("simo_copy_1.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(getters2/getters1, getters3/getters1, getters4/getters1, getters5/getters1), ncol=4)
matplot(x, dat, log='x', type='b', pch=2:5, xlab="data size (bytes)",
     ylim=c(0.8, 20), ylab = "Ratio vs getters=1", col=2:5, lty=2:5)

abline(h=1, col=1, lty=1)
revd = rev(2:5)
legend("left", legend=revd , col=revd,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=revd
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
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat <- matrix(c(getters1, getters2, getters3, getters4, getters5), ncol=5);
matplot(x, dat/thou, log='xy', type="b", pch=1:5, xlab="clone work units",
        ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=1:5, lty=1:5, xlim=c(4, 12000))
revd = rev(1:5)
legend("right", legend=revd , col=revd,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=revd)
dev.off()

mypng("clone_compete_1.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(getters1, getters2, getters3, getters4, getters5), ncol=5)
matplot(x, dat/thou, log='', type="l", xlab="clone work units",
     ylim=c(0.5, 100), ylab = "mean sych time (μs)", col=1:5, lty=1:5)
revd=rev(1:5)
legend("topleft", legend=revd , col=revd,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", lty=revd)
dev.off()


mypngbig("clone_compete_2.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat <- matrix(c(getters3/getters2, getters4/getters2, getters5/getters2), ncol=3);
matplot(x, dat, log='x', type="b", pch=3:5, xlab="clone work units",
     ylim=c(0.5, 8), ylab = "synch time relative to getters=2", col=3:5, lty=3:5)
abline(h=1, col=2)
revd = rev(3:5)
legend("topright", legend=revd , col=revd,  ncol=1,
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=revd)
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
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat <- matrix(c(y1-239, y2-239, y3-239, y4-239), ncol=4);
matplot(x, dat/thou, type="l", lty=1:4, col=1:4, ylab="overhead (μs)", xlab="unsatisfied rules") #plot
legend("topleft", legend=leggy , col=1:4,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("check_time_1.png")
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat/thou, type="l", lty=1:4, col=1:4, log='y', ylim=c(0.07, 80), ylab="overhead (ns)", xlab="unsatisfied rules") #plot
legend("bottomright", legend=leggy , col=1:4,  ncol=2,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:4)
dev.off()



###################################################
### bitset effectiveness. comparing normal hashset to bitset for the SUBSET operation
x = c(2^(0:12));
bits1 = c(92, 94, 91, 76, 128, 102, 83, 104, 111, 118, 138, 141, 240);
bits5 = c(88, 77, 82, 83, 89, 90, 192, 93, 71, 66, 236, 135, 158);
bits9 = c(81, 85, 82, 90, 105, 93, 89, 85, 102, 150, 119, 125, 200);
set1 = c(72, 105, 94, 70, 88, 117, 161, 277, 484, 918, 2027, 3519, 7258);
set5 = c(66, 124, 96, 122, 179, 513, 838, 1335, 2673, 3986, 11548, 18570, 32123);
set9 = c(61, 145, 103, 140, 219, 617, 1217, 1919, 2922, 5501, 12790, 23882, 54884);

leggy = c("10% full", "50% full", "90% full")

mypng("bits_0.png")
dat <- matrix(c(bits1, bits5, bits9), ncol=3);
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat, type="b", pch=1:3, lty=1:3, col=1:3, log='x', ylab="run time (ns)", xlab="number of ports", ylim=c(0, 280)) #plot
legend("topleft", legend=leggy , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=1:3)
dev.off()


mypng("bits_1.png")
dat <- matrix(c(set1/bits1, set5/bits5, set9/bits9), ncol=3);
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat, type="b", pch=1:3, lty=1:3, col=1:3, log='xy', ylim=c(0.6, 320), ylab="speedup", xlab="number of ports") #plot
abline(h=1, lty=3, col=3)
legend("topleft", legend=leggy , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=1:3)
dev.off()




###################################################
## isolated gets
x1 = 1:20
java8 = c(13450, 14239, 11348, 11086, 13324, 15790, 17781, 19612, 21592, 23142,
          25529, 29588, 30348, 32504, 37723, 40388, 40695, 43408, 46420, 47324);

rs8 = c(228, 699, 1405, 1825, 2413, 1803, 2098, 2206, 2264, 2584,
        2637, 2809, 2942, 3188, 3525, 3804, 3841, 3972, 4944, 4523);

rs0 = c(232, 691, 1429, 1455, 1616, 1767, 2023, 2056, 2102, 2345,
       2455, 2731, 2802, 2995, 3154, 3431, 3489, 3784, 3874, 4184);

rs1k = c(296, 663, 1429, 1797, 2167, 1883, 2034, 2511, 2300, 2442,
         2611, 3141, 3098, 3038, 3263, 3461, 3615, 3787, 3951, 4198);

rs8k = c(596, 837, 1533, 2038, 1903, 1950, 2115, 2320, 2297, 2388,
         2462, 2563, 2683, 2850, 2849, 2935, 2951, 3081, 3166, 3628);

dat <- matrix(c(rs0, rs8k, java8), ncol=3);
leggy = c("rust_8", "rust_8000", "java_8");
mypng("rust_v_java_0.png")
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x1, dat/thou, type = "l", lty=1:3, col=1:3, log='', ylab="interaction duration (μs)", xlab="concurrent getters") #plot
legend("topleft", legend=leggy , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:3)
dev.off()
mypng("rust_v_java_1.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x1, dat/thou, type = "l", lty=1:3, col=1:3, log='y', ylab="interaction duration (μs)", xlab="concurrent getters") #plot
legend("bottomright", legend=leggy , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:3)
dev.off()


x2 = 1:10
java_clone = c(24028, 20681, 31330, 40265, 47562, 59921, 63577, 74591, 80451, 89866);
rs64k = c(3424, 5689, 8308, 9448, 10298, 8877, 9089, 9579, 9831, 9459,
          9701, 9645, 9919, 9810, 10384, 10061, 9743, 10026, 9943, 10108);
dat <- matrix(c(rs64k[1:10], java8[1:10], java_clone), ncol=3);
mypngbig("rust_v_java_2.png")
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x2, dat/thou, type = "b", pch=1:3, lty=1:3, col=1:3, log='y', ylab="interaction duration (μs)", xlab="concurrent getters") #plot
leggy = c("rust_value", "java_reference", "java_value");
legend("bottomright", legend=leggy , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=1:3)
dev.off()




###################################
### reo-rs vs handmade alternator

x =          c(4,    8,    16,   32,   64,   128,  256,  512,  1024, 2048, 4096);
y_wrong___ = c(1658, 1620, 1617, 1704, 1698, 1733, 2013, 2014, 2609, 2956, 4529);
y_handmade = c(1674, 1693, 1700, 1722, 1764, 1728, 1743, 1845, 2077, 2946, 4147);
y_reorsput = c(1448, 1500, 1475, 1475, 1598, 1583, 1893, 1912, 2281, 3316, 7865);
y_crossbea = c(1097, 1198, 1072, 1134, 1060, 1126, 1175, 1347, 1470, 2373, 3454);
dat <- matrix(c(y_handmade, y_reorsput), ncol=2);

mypngbig("alternator.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(y_crossbea, y_reorsput), ncol=2)
matplot(x, dat/thou, type = "b", lty=1:3, col=1:3, log='x', ylab="interaction duration (μs)", xlab="data size (bytes)", pch=1:2, ylim=c(0,8)) #plot
lines(c(1024, 2048, 4096), c(2164, 2941, 6062)/thou, type="b", col=3, pch=3)
legend("topleft", legend=c("handmade", "reo-rs", "reo-rs (unsafe reference API)") , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=1:3)
dev.off()

