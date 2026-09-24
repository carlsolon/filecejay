package com.codewithcarl.store;
import org.springframework.stereotype.Service;
@Service
public class paypalPayment implements paymentService{
    @Override
    public void processPayment(double amount) {
        // Logic to process payment via PayPal
        System.out.println("PayPal");
        System.out.println("Amount: " + amount);
    }
}