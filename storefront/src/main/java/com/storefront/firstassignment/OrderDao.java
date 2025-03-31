package com.storefront.firstassignment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.storefront.DatabaseConnector;

public class OrderDao {
    public static ArrayList<OrderPojo> getOrdersByUserId(int userId){
        
        Connection connection = DatabaseConnector.connect();
        
        ArrayList<OrderPojo> orders = new ArrayList<>(); 

        try {
            String query = "SELECT o.id as id,o.created_at as date,sum(oi.quantity*p.price) as total FROM orders o join order_items oi ON o.id = oi.order_id JOIN products p on oi.product_id = p.id WHERE user_id=? AND o.status='Shipped' GROUP BY o.id ORDER BY created_at;"; 
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            ResultSet set = preparedStatement.executeQuery(); 
            if (set.next()) {
                int id = set.getInt("id"); 
                String time = set.getString("date"); 
                int total = set.getInt("total"); 
                OrderPojo order = new OrderPojo(id, time, total); 
                orders.add(order); 
            }
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
        return orders; 
    }
}


