package com.example.boot.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/*
 * 宠物
 * */
@Data
@ToString
@NoArgsConstructor   //午餐构造器
@AllArgsConstructor  //全惨构造器
public class Pet {
    private String name;

}
