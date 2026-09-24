package com.codewithcarl.store;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class homecontroller {
    @Value("${spring.application.name}")
    private String appName;
    

    @RequestMapping("/")
    public String carl() {
        System.out.println("AppName: " + appName);
        return "carl.html";
    }
}
