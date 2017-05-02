package com.myapps.jbrauchler.activities;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by jacobbrauchler on 5/2/17.
 */

public class Activity {
    private String category;
    private ArrayList<String> Activities = new ArrayList<>();

    //constructor
    private Activity(String categ, ArrayList<String> activities){
        this.category = categ;
        this.Activities = new ArrayList<String>(activities);
    }

    public static final Activity[] activities = {
            new Activity("Indoor", new ArrayList<String>()),
            new Activity("outdoor", new ArrayList<String>())
    };

    public void storeActivities(Context context, long categoryId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("CategoryActivities", Context.MODE_PRIVATE);
        //create an editor to write to the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set
        Set<String> set = new HashSet<String>();
        //add Sports to the set
        set.addAll(activities[(int) categoryId].getActivities());
        //pass the key/value pair to the shared preference file
        editor.putStringSet(activities[(int) categoryId].getCategory(), set);
        //save changes
        editor.commit();
    }

    public void loadActivities(Context context, int categoryId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("CategoryActivities", Context.MODE_PRIVATE);
        //create an editor to read from the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set with the Sport list
        Set<String> set =sharedPrefs.getStringSet(activities[categoryId].getCategory(), null);
        //if there was a saved list add it to the Sports array
        if (set != null){
            Activity.activities[categoryId].Activities.addAll(set);
        }
        //if no Sport list was saved, use the defaults
        else {
            switch (categoryId) {
                case 0:
                    Activity.activities[0].Activities.addAll(Arrays.asList("Ice Hockey", "Weight Lifting", "Running"));
                    break;
                case 1:
                    Activity.activities[1].Activities.addAll(Arrays.asList("Baseball", "Football", "Soccer", "Running"));
                    break;
                default:
                    break;
            }
        }
    }

    public String getCategory(){
        return category;
    }

    public ArrayList<String> getActivities(){
        return Activities;
    }

    public String toString(){
        return this.category;
    }
}
