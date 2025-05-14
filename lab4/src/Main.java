import java.util.*;
import java.util.concurrent.*;

public class Main {

    public static final int THREADS = 50;
    public static final int ITERATIONS = 100000;
    public static final double NSEC = 1000_000_000.0;
    public static final int MAP_SIZE = 3;
    public static final int SAMPLES = 5;

    public static Map<String, Integer> hashMap = new HashMap<>();
    public static Map<String, Integer> hashTable = new Hashtable<>();
    public static Map<String, Integer> syncMap = Collections.synchronizedMap(new HashMap<>());
    public static Map<String, Integer> cHashMap = new ConcurrentHashMap<>();

    public static void main(String[] args) {

        System.out.println("Collections:");
        double hashMapTime = compute(hashMap) / NSEC;
        double hashTableTime = compute(hashTable) / NSEC;
        double syncMapTime = compute(syncMap) / NSEC;
        double cHashMapTime = compute(cHashMap) / NSEC;

        System.out.println("Execution times:");
        System.out.println(String.format("\tHashMap: %.3f s,\n\tHashTable: %.3f s,\n\tSyncMap: %.3f s,\n\tConcurrentHashMap: %.3f s.",
                hashMapTime, hashTableTime, syncMapTime, cHashMapTime));

        // Проверка целостности данных для HashMap
        System.out.println("\nHashMap integrity check:");
        System.out.println("Expected size: " + MAP_SIZE + ", Actual size: " + hashMap.size());
        for (int i = 0; i < MAP_SIZE; i++) {
            String key = String.valueOf(i);
            System.out.println("Key: " + key + ", Value: " + hashMap.get(key));
        }

        System.out.println("\nhashTable integrity check:");
        System.out.println("Expected size: " + MAP_SIZE + ", Actual size: " + hashTable.size());
        for (int i = 0; i < MAP_SIZE; i++) {
            String key = String.valueOf(i);
            System.out.println("Key: " + key + ", Value: " + hashTable.get(key));
        }

        System.out.println("\nsyncMap integrity check:");
        System.out.println("Expected size: " + MAP_SIZE + ", Actual size: " + syncMap.size());
        for (int i = 0; i < MAP_SIZE; i++) {
            String key = String.valueOf(i);
            System.out.println("Key: " + key + ", Value: " + syncMap.get(key));
        }

        System.out.println("\ncHashMap integrity check:");
        System.out.println("Expected size: " + MAP_SIZE + ", Actual size: " + cHashMap.size());
        for (int i = 0; i < MAP_SIZE; i++) {
            String key = String.valueOf(i);
            System.out.println("Key: " + key + ", Value: " + cHashMap.get(key));
        }
    }

    private static long compute(Map<String, Integer> map) {

        System.out.print(String.format("\t%s", map.getClass().getName()));
        Object lock = new Object();
        long start = 0;
        long stop = 0;

        for (int k = 0; k < SAMPLES; k++) {

            // Очистка карты перед каждым прогоном
            map.clear();

            start = System.nanoTime();

            ExecutorService executorService = Executors.newFixedThreadPool(THREADS);

            List<Callable<String>> tasks = new ArrayList<>();
            List<Future<String>> results = new ArrayList<>();

            // create a list of tasks
            for (int i = 0; i < THREADS; i++) {
                tasks.add(() -> {
                    String threadName = Thread.currentThread().getName();
                    Random random = new Random();

                    try {
                        for (int j = 0; j < ITERATIONS; j++) {
                            // Выбираем случайный ключ из диапазона [0, MAP_SIZE-1]
                            int keyIndex = random.nextInt(30);
                            String key = String.valueOf(keyIndex);
                            int value = j;

//                           synchronized (lock){
                            map.merge(key, 1, Integer::sum);
//                                Integer readValue = map.get(key);
//                                if (readValue == null){
//                                    readValue = 0;
//                                }
//                                readValue = readValue + 1;
//
////                                // Запись в коллекцию
////                                map.put(key, readValue);
//
//                                if (readValue == null) {
//                                    System.err.println("Thread " + threadName + " read null for key " + key);
//                                }
//                          }

                            // Чтение из коллекции



                        }
                    } catch (Exception e) {
                        System.err.println("Thread " + threadName + " encountered error: " + e.getMessage());
                    }

                    return "Thread " + threadName + " done";
                });
            }

            // invoke all the tasks
            try {
                results = executorService.invokeAll(tasks);
            } catch (InterruptedException ie) {
                ie.printStackTrace();
            }

            // get results from futures
            try {
                for (Future<String> result : results) {
                    String s = result.get();
                    // System.out.println(s);
                }
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }

            // shutdown executor service
            executorService.shutdown();

            stop = System.nanoTime();
        }

        System.out.println("...done.");

        return stop - start;
    }
}