package com.myapps.jbrauchler.gastracker;


import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by jacobbrauchler on 4/19/17.
 */

public class Vehicle  {
    private String year;
    private String make;
    private String model;
    private ArrayList<String> mpgs = new java.util.ArrayList<>();

    private Vehicle(String year, String make, String model, ArrayList<String> mpgs){
        this.year = year;
        this.make = make;
        this.model = model;
        this.mpgs = new ArrayList<String>(mpgs);
    }

    public static final Vehicle[] vehicles = {
            new Vehicle("1998", "Toyota", "4Runner", new ArrayList<String>()),
            new Vehicle("2002", "Ford", "Mustang", new ArrayList<String>())
    };

    public void storeMpgs(Context context, long vehicleId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("Mpgs", Context.MODE_PRIVATE);
        //create an editor to write to the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set
        Set<String> set = new HashSet<String>();
        //add heroes to the set
        set.addAll(vehicles[(int) vehicleId].getMpgs());
        //pass the key/value pair to the shared preference file
        editor.putStringSet(vehicles[(int) vehicleId].getModel(), set);
        //save changes
        editor.commit();
    }

    public void loadMpgs(Context context, int vehicleId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("Mpgs", Context.MODE_PRIVATE);
        //create an editor to read from the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set with the hero list
        Set<String> set =sharedPrefs.getStringSet(vehicles[vehicleId].getModel(), null);
        //if there was a saved list add it to the heroes array
        if (set != null){
            Vehicle.vehicles[vehicleId].mpgs.addAll(set);
        }
        //if no hero list was saved, use the defaults
        else {
            switch (vehicleId) {
                case 0:
                    Vehicle.vehicles[0].mpgs.addAll(Arrays.asList("17.5", "16.8", "16.3", "17.25"));
                    break;
                case 1:
                    Vehicle.vehicles[1].mpgs.addAll(Arrays.asList("19.2", "19.6", "19.4", "19.35" ));
                    break;
                default:
                    break;
            }
        }
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public ArrayList<String> getMpgs() {
        return mpgs;
    }

    public void setMpgs(ArrayList<String> mpgs) {
        this.mpgs = mpgs;
    }
}
