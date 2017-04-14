package com.myapps.jbrauchler.sports;

/**
 * Created by jacobbrauchler on 4/13/17.
 */

public class Sport {
    private String name;
    private int imageResourceID;

    //constructor
    private Sport(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Sport[] nhl = {
            new Sport("Colorado Avalanche", R.drawable.sports),
            new Sport("Edmonton Oilers", R.drawable.sports),
            new Sport("Washington Capitals", R.drawable.sports),
            new Sport("Chicago Blackhawks", R.drawable.sports),
            new Sport("Toronto Maple Leafs", R.drawable.sports)
    };
    public static final Sport[] nfl = {
            new Sport("Denver Broncos", R.drawable.sports),
            new Sport("New England Patriots", R.drawable.sports),
            new Sport("Washington Redskins", R.drawable.sports),
            new Sport("Chicago Bears", R.drawable.sports),
    };
    public static final Sport[] mlb = {
            new Sport("Colorado Rockies", R.drawable.sports),
            new Sport("New York Yankees", R.drawable.sports),
            new Sport("Washington Capitals", R.drawable.sports),
            new Sport("San Diego Padres", R.drawable.sports),
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    public String toString(){
        return this.name;
    }
}
