package com.example.boot.bean;

import lombok.*;

/*
 * 用户
 * */
@Data
@ToString
@NoArgsConstructor   //无餐构造器
//@AllArgsConstructor  //有惨构造器
@EqualsAndHashCode
public class User {

    private String name;
    private Integer age;
    private Pet pet;

    public User(String name, Integer age) {
        this.name = name;
        this.age = age;

    }
}
