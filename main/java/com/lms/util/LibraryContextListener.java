package com.lms.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class LibraryContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("=================================");
        System.out.println("Library Management System Started");
        System.out.println("Starting Overdue Fine Scheduler...");
        System.out.println("=================================");

        OverdueFineScheduler.start();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        System.out.println("Stopping Overdue Fine Scheduler...");

        OverdueFineScheduler.stop();
    }
}