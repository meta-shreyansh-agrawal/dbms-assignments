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
            String query = "DELETE p FROM products p LEFT JOIN order_items oi ON p.id = oi.product_id LEFT JOIN orders o ON o.id = oi.order_id LEFT JOIN users u ON u.id = o.user_id WHERE (u.role = 'Shopper' AND o.created_at > NOW() - INTERVAL 12 MONTH) IS NULL;\n"; 
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
