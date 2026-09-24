package com.codewithcarl.store;

import org.springframework.stereotype.Service;

@Service
public class orderService {
    private paymentService PaymentService;

    public orderService(paymentService paymentService) {
        this.PaymentService = paymentService;
    };
    public void placeOrder() {
        PaymentService.processPayment(10);
    };   

    public void setPaymentService(paymentService paymentService) {
        this.PaymentService = paymentService;
    }
};