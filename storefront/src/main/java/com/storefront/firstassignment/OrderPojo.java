package com.storefront.firstassignment;

public class OrderPojo {
    private int id; 
    private String createdAt; 
    private int totalPrice; 

    public int getId() {
        return id;
    }

    public String getDate() {
        return createdAt;
    }

    public int getTotal() {
        return totalPrice;
    }

    OrderPojo(int id, String createdAt, int totalPrice){
        this.id = id; 
        this.createdAt = createdAt; 
        this.totalPrice = totalPrice; 
    }

}
