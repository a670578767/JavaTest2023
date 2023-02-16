package com.example.boot.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Controller
 * @ResponseBody = @RestController
 */
@Slf4j
@RestController
public class HelloController {

    @RequestMapping("/hello")
    public String handle01() {
        return "hello springboot2";
    }
}
