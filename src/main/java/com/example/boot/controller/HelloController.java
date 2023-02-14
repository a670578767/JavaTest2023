package com.example.boot.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Controller
 * @ResponseBody
 * = @RestController
 */
@RestController
public class HelloController {

    @RequestMapping("/hello")
    public String handle01() {
        return "hello springboot2";
    }
}
