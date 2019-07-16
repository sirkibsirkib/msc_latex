private static class Sync implements Component {
    public volatile Port<String> p0, p1;
    
    private Guard[] guards = new Guard[]{
        new Guard(){
            public Boolean guard(){
                return (p1.hasGet() && (!(p0.peek() == null)));
    }   },  };
    
    private Command[] commands = new Command[]{
        new Command(){
            public void update(){
                p1.put(p0.peek()); 
                p0.get();
    }   },  };
    
    public void run() {
        int i = 0;
        while (true) {
            if(guards[i].guard())commands[i].update();
            i = i==guard.length ? 0 : i+1;
            synchronized (this) {
                while(true) {
                    if (p1.hasGet() && (!(p0.peek() == null))) break;
                    try { 
                        wait(); 
                    } catch (InterruptedException e) { }
}   }   }   }   }