package com.storefront.thirdassignment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.storefront.DatabaseConnector;

public class ProductDao {
    public static int deleteAdminProducts(){
        int count = 0; 
        Connection connection = DatabaseConnector.connect();
        try {
            connection.prepareStatement("SET SQL_SAFE_UPDATES = 0;"); 
            String query = "WHERE id NOT IN ( SELECT DISTINCT product_id FROM order_items oi JOIN orders o ON oi.order_id = o.id JOIN users u ON o.user_id = u.id WHERE u.role = 'Shopper' AND o.order_time >= NOW() - INTERVAL 1 YEAR);"; 
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            connection.prepareStatement("SET SQL_SAFE_UPDATES = 1;"); 
            count = preparedStatement.executeUpdate(); 
            connection.close();
        } catch (SQLException e) {
            System.out.println("Oops, Try again!");
            e.printStackTrace();
        }finally{
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count; 
    }
}
