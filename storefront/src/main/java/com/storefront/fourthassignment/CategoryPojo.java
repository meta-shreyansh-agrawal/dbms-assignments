package com.storefront.fourthassignment;
public class CategoryPojo{
    int id; 
    String name; 
    int childCount; 

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getChildCount() {
        return childCount;
    }

    CategoryPojo(int id, String name,int childCount){
        this.id = id; 
        this.name = name; 
        this.childCount = childCount; 
    }
}