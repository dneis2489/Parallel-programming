import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

public class Main {

    public static final int THREADS = 4;
    public static final int COUNT = 2;
    public static MySemaphore mySemaphore = new MySemaphore(COUNT);
    public static Semaphore mySemaphoreWithoutLock = new MySemaphoreWithoutLock(COUNT);
    public static Semaphore regularSemaphore = new Semaphore(COUNT);
    private static final AtomicInteger activeThreads = new AtomicInteger(0);
    private static final AtomicInteger maxActiveThreads = new AtomicInteger(0);

    public static void main(String[] args) {
        System.out.println("-------------------\nRegular semaphore:\n-------------------");
        runTask(regularSemaphore);
        System.out.println("--------------\nMy semaphore:\n--------------");
        runTask(mySemaphore);
        System.out.println("--------------\nMy semaphore without lock:\n--------------");
        runTask(mySemaphoreWithoutLock);
    }

    private static void runTask(Semaphore semaphore) {
        List<Callable<String>> tasks = new ArrayList<>();

        for (int i = 0; i < THREADS; i++) {
            tasks.add(() -> {
                String threadName = Thread.currentThread().getName();
                semaphore.acquire();
                try {
                    int currentActive = activeThreads.incrementAndGet();
                    if (currentActive > maxActiveThreads.get()) {
                        maxActiveThreads.set(currentActive);
                    }
                    System.out.println("Поток " + threadName + " работает. Активных потоков: " + currentActive);
                    Thread.sleep(1000); // Симуляция работы
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    Thread.currentThread().interrupt();
                } finally {
                    activeThreads.decrementAndGet();
                    semaphore.release();
                }

                return "Thread " + threadName + " done";
            });
        }

        try (ExecutorService es = Executors.newFixedThreadPool(THREADS)) {
            // invoke all the tasks
            try {
                es.invokeAll(tasks);
            } catch (InterruptedException ie) {
                ie.printStackTrace();
                Thread.currentThread().interrupt();
            }
        }

        System.out.println("Максимальное количество активных потоков: " + maxActiveThreads.get());
    }
}