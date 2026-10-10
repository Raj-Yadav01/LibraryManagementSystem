package com.lms.util;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.lms.service.BorrowingService;
import com.lms.serviceImpl.BorrowingServiceImpl;

public class OverdueFineScheduler {

    private static final ScheduledExecutorService scheduler =
            Executors.newSingleThreadScheduledExecutor();

    private static final BorrowingService borrowingService =
            new BorrowingServiceImpl();

    public static void start() {

        // Application start hote hi ek baar fine update
        borrowingService.updateOverdueFines();

        // Uske baad har 24 hours mein update
        scheduler.scheduleAtFixedRate(
                () -> {
                    try {
                        borrowingService.updateOverdueFines();

                        System.out.println(
                                "Overdue fine updated successfully."
                        );

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                },
                24,
                24,
                TimeUnit.HOURS
        );
    }

    public static void stop() {
        scheduler.shutdown();
    }
}