# RTT test
measurements for RTT using SPSC and Reo with FIFO1 on single thread
100_000 reps

## REO with 
N=0: 63.13461ms
q=0: 65.14954ms
q=1: 66.80122ms
q=2: 63.49879ms
q=3: 64.86871ms
q=4: 66.98967ms
q=5: 69.14193ms
q=6: 69.47564ms
q=7: 76.61765ms
q=8: 89.04745ms
q=9: 114.10968ms
q=10: 134.26562ms
q=11: 181.08886ms
q=12: 299.73297ms
q=13: 903.00934ms
q=14: 2.31012388s

## MPSC with N= 2<<q
N=0: 9.29991ms
q=0: 10.65254ms
q=1: 10.5035ms
q=2: 10.92912ms
q=3: 10.03323ms
q=4: 10.07968ms
q=5: 11.2787ms
q=6: 12.20944ms
q=7: 16.24493ms
q=8: 25.9815ms
q=9: 28.36046ms
q=10: 38.37119ms
q=11: 69.29128ms
q=12: 163.17103ms
q=13: 276.16403ms
q=14: 578.43417ms