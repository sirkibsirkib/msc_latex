Port<String> p0 = new PortWaitNotify<String>();
Port<String> p1 = new PortWaitNotify<String>();

Sender c0 = new Sender();
Receiver c1 = new Receiver();
Sync c2 = new Sync();

p0.setProducer(c0); c0.p0 = p0;
p0.setConsumer(c2); c2.p0 = p0;
p1.setProducer(c2); c2.p1 = p1;
p1.setConsumer(c1); c1.p1 = p1;

new Thread(c0).start();
new Thread(c1).start();
new Thread(c2).start();