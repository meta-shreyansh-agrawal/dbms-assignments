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
            String query = "delete from products where p.id not in(SELECT * FROM products p join order_items oi on p.id=oi.product_id join order o on o.id = oi.order_id join user u on u.id = o.user_id where u.role = 'Shopper' and o.created_at > now()-interval 12 month);"; 
            PreparedStatement preparedStatement = connection.prepareStatement(query);
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
