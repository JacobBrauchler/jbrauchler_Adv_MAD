package com.myapps.jbrauchler.superheroes;

/**
 * Created by jacobbrauchler on 4/11/17.
 */

import java.util.Arrays;
import java.util.ArrayList;

public class Hero {
    private String universe;
    private ArrayList<String> superheroes = new ArrayList<>();
    //constructor
    private Hero(String univ, ArrayList<String> heroes){
        this.universe = univ;
        this.superheroes = new ArrayList<String>(heroes);
    }
    public static final Hero[] heroes = {
            new Hero("DC", new ArrayList<String>(Arrays.asList("Superman", "Batman", "Wonder Woman",
                    "The Flash", "Green Arrow", "Catwoman"))),
            new Hero("Marvel", new ArrayList<String>(Arrays.asList("Iron Man", "Black Widow",
                    "Captain America", "Jean Grey", "Thor", "Hulk")))
    };
    public String getUniverse() {
        return universe;
    }
    public ArrayList<String> getSuperheroes() {
        return superheroes;
    }
    public String toString() {
        return this.universe;
    }
}
