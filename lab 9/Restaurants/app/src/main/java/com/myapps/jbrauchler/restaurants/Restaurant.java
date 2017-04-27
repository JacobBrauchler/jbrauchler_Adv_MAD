package com.myapps.jbrauchler.restaurants;

import com.google.firebase.database.Exclude;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by jacobbrauchler on 4/27/17.
 */

public class Restaurant {
    private String name;
    private String type;
    private String url;

    public Restaurant(){
        // Default constructor required for calls to DataSnapshot.getValue(RecipeItem.class)
    }

    public Restaurant(String newName, String newType, String newURL){
        name = newName;
        type = newType;
        url = newURL;
    }

    public String getName(){
        return name;
    }

    public String getType() { return type; }

    public String geturl(){
        return url;
    }

    //used when writing to the database
    @Exclude
    public Map<String, Object> toMap(){
        HashMap<String, Object> result = new HashMap<>();
        result.put("name", name);
        result.put("type", type);
        result.put("url", url);
        return result;
    }

    //the string representation of a recipe name
    public String toString(){
        return this.name;
    }
}
