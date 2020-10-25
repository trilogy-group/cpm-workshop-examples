package com.devfactory.app;

import java.util.Scanner;

public class App 
{
    public static void main( String[] args )
    {
        Scanner sc = null; 

        try {
            System.out.println("What is your name?");
            sc = new Scanner(System.in); 
            String str= sc.nextLine();
            System.out.println("Hello " + str);
        } finally {
            sc.close();
        }
    }
}
