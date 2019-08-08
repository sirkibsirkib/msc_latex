setwd("C:/Users/chris/OneDrive/Documents/LaTeX/Msc2/experiments")

mypng <- function(filename) {
  png(
    filename,
    width     = 3.1,
    height    = 2.8,
    units     = "in",
    res       = 1000,
    pointsize = 9
  )
}
mypngbig <- function(filename) {
  png(
    filename,
    width     = 4.2,
    height    = 3.35,
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

x = 2^c(0,2,4,6,8, 10, 12, 14, 16, 18)
option = c(60, 60, 62, 64, 67, 65, 336, 1131, 4773, 22428);
heapptr = c(60, 58, 61, 61, 60, 87, 128, 313, 1165, 5690)
reo_raw = c(613, 609, 615, 624, 612, 693, 755, 1517, 3957, 19526)
crossbeam = c(101, 94, 95, 101, 214, 317, 886, 3764, 19652, 119739)

reo_rs = c(662, 621, 642, 612, 658, 655, 773, 1432, 3923, 20072);

mypng("rtt_0.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(reo_raw, crossbeam, option, (heapptr-58)*2+58), ncol=4)
matplot(x, dat/thou, log='x', type='b', pch=1:4, xlab="data size (bytes)",
     ylab = "Mean RTT (μs)", ylim=c(0, max(c(option, reo_rs))*1.1/thou))
legend("topleft", legend=c("reo-rs", "channel", "option", "copy") , col=1:4,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:4
)
dev.off()

mypng("rtt_1.png")
op <-par(mar = c(5.1, 4.1, 1.8, 1.8))
matplot(x, dat/thou, log='xy', type='b', pch=1:2, xlab="data size (bytes)", ylab = "Mean RTT (μs)")
legend("topleft", legend=c("reo-rs", "channel", "option", "copy") , col=1:4,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:4
)
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
y2 = c(244, 373, 611, 675, 751, 895, 1008, 1134, 1257, 1391, 1511, 1635, 1780, 1895, 2011, 2153, 2278, 2405, 2533, 2661, 2786, 2911, 3039, 3170, 3287, 3420, 3540, 3682, 3819, 3929, 4065, 4194, 4310, 4426, 4554, 4695, 4828, 4940, 5078, 5352);

# swap then check false
y2b = c(247, 477, 698, 996, 1160, 1369, 1680, 1840, 2082, 2313, 2505, 2760,
        2970, 3224, 3515, 3606, 3801, 4131, 4354, 4592, 4872, 5048, 5267,
        5505, 5732, 5929, 6178, 6419, 6645, 6895, 7477, 7353, 7554, 7799,
        7986, 8209, 8545, 8822, 8922, 9183);

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

leggy = c("guard", "false",  "swap", "ands", "alloc");
mypng("check_time_0.png")
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat <- matrix(c(y1-239, y2-239, y2b-239, y3-239, y4-239), ncol=5);
matplot(x, dat/thou, type="l", lty=1:5, col=1:5, ylab="overhead (μs)", xlab="unsatisfied rules") #plot
legend("topleft", legend=leggy , col=1:5,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:5)
dev.off()

mypng("check_time_1.png")
 op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat/thou, type="l", lty=1:5, col=1:5, log='y', ylim=c(0.07, 80), ylab="overhead (ns)", xlab="unsatisfied rules") #plot
legend("bottomright", legend=leggy , col=1:4,  ncol=2,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:5)
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
### experiments/test_8
### reo-rs vs handmade alternator

x =          c(4,    8,    16,   32,   64,   128,  256,  512,  1024, 2048, 4096, 8192);
y_crossbea = c(1108, 1079, 1111, 1125, 1107, 1181, 1203, 1302, 1481, 2212, 3541, 11717);
y_reorsput = c(1483, 1576, 1996, 1458, 1462, 1581, 1731, 1550, 1688, 1982, 2770, 3717);
xlil = c(1024, 2048, 4096, 8192)
y_reorsputlil = c(1618, 1747, 1881, 2371)
dat <- matrix(c(y_handmade, y_reorsput), ncol=2);

mypngbig("alternator.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(y_crossbea, y_reorsput), ncol=2)
matplot(x, dat/thou, type = "b", lty=1:2, col=1:2, log='x', ylab="interaction duration (μs)", xlab="data size (bytes)", pch=1:2, ylim=c(0,8)) #plot
lines(xlil, y_reorsputlil/thou, type="b", col=3, pch=3)
revd=c(2,3,1)
legend("topleft", legend=c("reo-rs", "reo-rs (unsafe reference API)","handmade") , col=revd,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=revd)
dev.off()




############################
### experiments/test_9
### mem refpass
# clone type data 8192 (moving through fifoM connector)
put_get = c(4971, 5063, 5121, 5235, 5290, 5385, 5523, 5700, 5828, 5988, 6604, 6357, 6380, 6561, 6783, 7013, 7180, 7531, 7893, 7929, 8022, 8259)
rawput_get = c(3305, 3419, 3450, 3506, 3539, 3701, 3759, 3953, 4232, 4309, 4512, 4612, 4690, 5075, 5159, 5436, 5524, 5708, 5928, 6157, 6503, 6737)
rawput_getsig = c(1558, 1578, 1651, 1751, 1880, 2008, 2215, 2507, 2461, 2523, 2630, 2794, 2941, 3098, 3320, 3661, 3667, 3960, 4237, 4382, 4611, 4848)
put_getsig = c(3339, 3248, 3329, 3531, 3621, 3727, 3860, 4015, 4207, 4356, 4518, 4697, 4902, 5083, 5230, 5490, 5594, 5919, 6146, 6276, 6519, 6750)
mypngbig("fifo_m.png")
nums = c(1:4)
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
dat = matrix(c(put_get, rawput_get, put_getsig, rawput_getsig), ncol=4)
matplot(x=(1:22), dat/thou, ylim=c(0, max(put_get)/thou*1.3), type='b', ylab="duration (μs)", xlab="fifo buffer slots", pch=nums, lty=nums, col=nums)
leggy = c("put_in_out", "in_out", "put_in", "in")
legend("topleft", legend=leggy , col=nums,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=nums)
dev.off()

