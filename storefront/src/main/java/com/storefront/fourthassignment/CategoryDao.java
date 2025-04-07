package com.storefront.fourthassignment;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.storefront.DatabaseConnector;

public class CategoryDao {

    public static ArrayList<CategoryPojo> getChildCategoryCount(){
        Connection connection = DatabaseConnector.connect();
        ArrayList<CategoryPojo> categories = new ArrayList<>(); 
        try {
            String query = " select a.id,a.name,count(*) as child from categories a join categories b on a.id = b.parent_id group by a.id  order by a.name;"; 
            ResultSet set = connection.prepareStatement(query).executeQuery();
            while(set.next()){
                int id = set.getInt("id"); 
                int childCount = set.getInt("child"); 
                String name = set.getString("name");
                categories.add(new CategoryPojo(id,name,childCount)); 
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
        return categories; 
    }
}
