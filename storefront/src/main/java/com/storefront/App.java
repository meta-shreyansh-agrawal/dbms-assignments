package com.storefront;

import java.util.ArrayList;
import java.util.Scanner;

import com.storefront.firstassignment.OrderDao;
import com.storefront.firstassignment.OrderPojo;
import com.storefront.fourthassignment.CategoryDao;
import com.storefront.fourthassignment.CategoryPojo;
import com.storefront.secondassignment.ImageDao;
import com.storefront.thirdassignment.ProductDao;

public final class App {
    public static void main(String[] args) {
       Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("===== Storefront Menu =====");
            System.out.println("1. View Orders by User ID");
            System.out.println("2. View Child Categories Count");
            System.out.println("3. Add Product Images in Batch");
            System.out.println("4. Delete Old Admin Products");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");

            choice = Utils.inputNumberInRange(scanner,1,5);

            switch (choice) {
                case 1:
                    System.out.print("Enter User ID: ");
                    int userId = Utils.inputNaturalNumber(scanner);
                    ArrayList<OrderPojo> orders = OrderDao.getOrdersByUserId(userId);
                    if (orders.isEmpty()) {
                        System.out.println("No orders found for this user.");
                    } else {
                        System.out.println("Orders:");
                        for (OrderPojo order : orders) {
                            System.out.println("Order ID: " + order.getId() + ", Date: " + order.getDate() + ", Total: " + order.getTotal());
                        }
                    }
                    break;

                case 2:
                    ArrayList<CategoryPojo> categories = CategoryDao.getChildCategoryCount();
                    if (categories.isEmpty()) {
                        System.out.println("No categories found.");
                    } else {
                        System.out.println("Categories:");
                        for (CategoryPojo category : categories) {
                            System.out.println("Category ID: " + category.getId() + ", Name: " + category.getName() + ", Child Count: " + category.getChildCount());
                        }
                    }
                    break;

                case 3:
                    System.out.print("Enter Product ID: ");
                    int productId = Utils.inputNaturalNumber(scanner);
                    System.out.println("Enter Image URLs (comma-separated): ");
                    String[] urls = scanner.nextLine().split(",");
                    ArrayList<String> imageUrls = new ArrayList<>();
                    for (String url : urls) {
                        imageUrls.add(url.trim());
                    }
                    boolean success = ImageDao.addProductImagesInBatch(productId, imageUrls);
                    if (success) {
                        System.out.println("Images added successfully!");
                    } else {
                        System.out.println("Failed to add images.");
                    }
                    break;

                case 4:
                    int deletedCount = ProductDao.deleteAdminProducts();
                    System.out.println(deletedCount + " old admin products deleted.");
                    break;

                case 5:
                    System.out.println("Exiting the application. Goodbye!");
                    break;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
            System.out.println();

        } while (choice != 5);

        scanner.close();

    }
}
