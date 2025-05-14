import java.util.concurrent.Semaphore;

public class MySemaphoreWithoutLock extends Semaphore {
    private int permits;
    public MySemaphoreWithoutLock(int permits) {
        super(permits);
        this.permits = permits;
    }

    public synchronized void acquire() throws InterruptedException {
        while (permits <= 0) {
            wait();
        }
        permits--;
    }

    public synchronized void release() {
        permits++;
        notify();
    }

    public synchronized int availablePermits() {
        return permits;
    }
}