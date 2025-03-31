package com.storefront.secondassignment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.storefront.DatabaseConnector;

public class ImageDao {
    public static boolean addProductImagesInBatch(int productId, ArrayList<String> imageUrls){
        Connection connection = DatabaseConnector.connect();
        boolean flag = false; 
        try {
            String query = "INSERT INTO images(product_id,image_url) VALUES (?,?);"; 
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            for(String url: imageUrls){
                preparedStatement.setInt(1, productId);
                preparedStatement.setString(2, url);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch(); 
            connection.close();
            flag = true; 
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
        return flag; 
    }
}
