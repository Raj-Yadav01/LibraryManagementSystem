package com.lms.util;

import java.sql.Connection;

public class ConnectionTest {

    public static void main(String[] args) {

        try {
            Connection connection = DbUtil.getConnection();

            if (connection != null) {
                System.out.println("Database Connected Successfully!");
                connection.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}