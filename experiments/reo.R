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
dat = matrix(c(reo_raw, crossbeam, option, (heapptr-58)*2+58), ncol=4)
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat/thou, log='x', type='b', pch=1:4, xlab="data size (bytes)",
     ylab = "Mean RTT (μs)", ylim=c(0, max(c(option, reo_rs))*1.1/thou))
legend("topleft", legend=c("reo-rs", "channel", "option", "copy") , col=1:4,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:4
)
dev.off()

mypng("rtt_1.png")
op <-par(mar = c(5.1, 4.1, 1.8, 1.8))
matplot(x, dat/thou, log='xy', type='b', pch=1:4, xlab="data size (bytes)", ylab = "Mean RTT (μs)")
legend("topleft", legend=c("reo-rs", "channel", "option", "copy") , col=1:4,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:4
)
dev.off()


mypng("rtt_for_pres.png")
op <-par(mar = c(5.1, 4.1, 1.8, 1.8))
matplot(x, dat[,-3]/thou, log='xy', type='b', pch=1:4, xlab="data size (bytes)", ylab = "Mean RTT (μs)")
legend("topleft", legend=c("reo-rs", "channel", "memcpy") , col=1:4,  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:4
)
dev.off()


#########################################################
### "SIMO" group getting. N-way replicator with COPY type data
### 

x = 2^c(0:11)
y = c(92, 508, 1174, 1802, 12567, 13195,
      85, 483, 1148, 1570, 10891, 13152,
      85, 471, 1144, 1483, 10802, 13166,
      91, 461, 1238, 1616, 10936, 13180,
      89, 488, 1439, 1826, 12258, 14540,
      87, 471, 1757, 2036, 11329, 13443,
      84, 485, 2046, 3307, 11539, 13892,
      86, 466, 3151, 4111, 12463, 14821,
      86, 480, 7311, 10994, 13598, 16597,
      88, 459, 14459, 15549, 17480, 20451,
      90, 497, 20913, 22444, 27094, 27837,
      87, 505, 38490, 44367, 43272, 42934)
my = matrix(y, ncol = length(x))
ty = t(my)


mypng("simo_0.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, ty/1000, log='x', type='b', pch=1:6, lty=1:6, col=1:6, ylab="runtime (μs)", xlab="clone work units")
legend("topleft", legend=c(0:5) , col=1:6,  ncol=6, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:6
)
dev.off()

mypng("simo_1.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, ty/1000, log='xy', type='b', pch=1:6, lty=1:6, col=1:6, ylab="runtime (μs)", ylim=c(0.06, 120), xlab="clone work units")
legend("topleft", legend=c(0:5) , col=1:6,  ncol=6, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=1:6
)
dev.off()

mypngbig("simo_2.png")
ty2 <- ty[,-c(1,2,3)]
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, ty2/ty[,3], log='xy', type='b', pch=4:6, ylim=c(0.8, 14),
        ylab="runtime factor relative to |g|=2", lty=4:6, col=4:6, xlab="clone work units")
legend("left", legend=c("|g|=5", "|g|=4", "|g|=3") , col=rev(4:6),  ncol=1, 
       y.intersp=1.3, cex=1, xjust=0, bty = "n", pch=rev(4:6)
)
abline(h=1, col=1)
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
dat <- matrix(c(y1-239, y2-239, y2b-239, y3-239, y4-239), ncol=5);
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
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
y_crossbea = c(1100, 1141, 1220, 1125, 1107, 1237, 1203, 1372, 1481, 2212, 3619, 13113);
y_reorsput = c(1459, 1505, 1485, 1458, 1462, 1484, 1731, 1631, 1688, 1982, 2770, 3717);
xlil = c(512, 1024, 2048, 4096, 8192)
y_reorsputlil = c(1500, 1618, 1747, 1847, 2295)

mypng("alternator_0.png")
dat = matrix(c(y_reorsput, y_crossbea), ncol=2)
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x, dat/thou, type = "b", lty=1:2, col=1:2, log='x', ylab="interaction duration (μs)", xlab="data size (bytes)", pch=1:2, ylim=c(0,8)) #plot
lines(xlil, y_reorsputlil/thou, type="b", col=4, pch=4)
revd=c(1,4,2)
legend("topleft", legend=c("reo-rs", "reo-rs (unsafe reference API)","handmade") , col=revd,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=revd)
dev.off()


mypng("alternator_1.png")
dat = matrix(c(y_reorsput, y_crossbea), ncol=2)
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
plot(x, y_reorsput/y_crossbea, type = "b", lty=1, col=1, log='x', ylab="slowdown wrt. handmade", xlab="data size (bytes)", pch=1, ylim=c(0,1.6)) #plot
lines(xlil, y_reorsputlil/y_crossbea[8:12], type="b", col=4, pch=4)
abline(h=1, lty=2, col=2)
legend("bottomleft", legend=c("reo-rs", "reo-rs (unsafe reference API)") , col=c(1,4),  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=c(1,4))
dev.off()




############################
### experiments/test_9
### mem refpass
# clone type data 8192 (moving through fifoM connector)
put_get = c(4971, 5063, 5121, 5235, 5290, 5385, 5523, 5700, 5828, 5988, 6604, 6357, 6380, 6561, 6783, 7013, 7180, 7531, 7893, 7929, 8022, 8259)
rawput_get = c(3305, 3419, 3450, 3506, 3539, 3701, 3759, 3953, 4232, 4309, 4512, 4612, 4690, 5075, 5159, 5436, 5524, 5708, 5928, 6157, 6503, 6737)
rawput_getsig = c(1558, 1578, 1651, 1751, 1880, 2008, 2215, 2507, 2461, 2523, 2630, 2794, 2941, 3098, 3320, 3661, 3667, 3960, 4237, 4382, 4611, 4848)
put_getsig = c(3339, 3248, 3329, 3531, 3621, 3727, 3860, 4015, 4207, 4356, 4518, 4697, 4902, 5083, 5230, 5490, 5594, 5919, 6146, 6276, 6519, 6750)
mypng("fifo_m_0.png")
nums = c(1:4)
dat = matrix(c(put_get, rawput_get, put_getsig, rawput_getsig), ncol=4)
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
matplot(x=(1:22), dat/thou, ylim=c(0, max(put_get)/thou*1.3), type='b', ylab="duration (μs)", xlab="fifo buffer slots", pch=nums, lty=nums, col=nums)
leggy = c("put_in_out", "in_out", "put_in", "in")
legend("topleft", legend=leggy , col=nums,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", pch=nums)
dev.off()

mypng("fifo_m_1.png")
op <- par(mar = c(5.1, 4.1, 1.5, 1.5))
plot(x=(1:22), put_get/thou, type='b', ylab="duration (μs)", xlab="fifo buffer slots", ylim= c(0, max(put_get/thou)*2), xlim=c(0, 26))
pg1 = put_get[1]/thou
abline(0, pg1,  col=2, lty=2)
abline(pg1, 0,  col=3, lty=3)
legend("topright", legend=c("put_in_out", "linear", "constant") , col=1:3,  ncol=1,
       y.intersp=1.1, cex=1, xjust=0, bty = "n", lty=1:3, pch=1:3)
dev.off()