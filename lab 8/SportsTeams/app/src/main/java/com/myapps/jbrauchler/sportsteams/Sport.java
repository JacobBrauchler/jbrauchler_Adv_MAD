package com.myapps.jbrauchler.sportsteams;

/**
 * Created by jacobbrauchler on 4/20/17.
 */

import android.content.Context;
import android.content.SharedPreferences;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Sport {
    private String league;
    private ArrayList<String> sportTeams = new ArrayList<>();

    //constructor
    private Sport(String univ, ArrayList<String> teams){
        this.league = univ;
        this.sportTeams = new ArrayList<String>(teams);
    }

    public static final Sport[] teams = {
            new Sport("NHL Hockey", new ArrayList<String>()),
            new Sport("NFL Football", new ArrayList<String>()),
            new Sport("MLS Soccer", new ArrayList<String>()),
            new Sport("MLB Baseball", new ArrayList<String>())
    };

    public void storeSports(Context context, long leagueId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("SportTeams", Context.MODE_PRIVATE);
        //create an editor to write to the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set
        Set<String> set = new HashSet<String>();
        //add Sports to the set
        set.addAll(teams[(int) leagueId].getSportTeams());
        //pass the key/value pair to the shared preference file
        editor.putStringSet(teams[(int) leagueId].getLeague(), set);
        //save changes
        editor.commit();
    }

    public void loadSports(Context context, int leagueId){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("SportTeams", Context.MODE_PRIVATE);
        //create an editor to read from the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set with the Sport list
        Set<String> set =sharedPrefs.getStringSet(teams[leagueId].getLeague(), null);
        //if there was a saved list add it to the Sports array
        if (set != null){
            Sport.teams[leagueId].sportTeams.addAll(set);
        }
        //if no Sport list was saved, use the defaults
        else {
            switch (leagueId) {
                case 0:
                    Sport.teams[0].sportTeams.addAll(Arrays.asList("Avalanche", "Blackhawks", "Oilers", "Flames", "Penguins"));
                    break;
                case 1:
                    Sport.teams[1].sportTeams.addAll(Arrays.asList("Broncos", "Raiders", "Patriots", "Chiefs", "Chargers"));
                    break;
                case 2:
                    Sport.teams[2].sportTeams.addAll(Arrays.asList("Rapids", "Galaxy"));
                    break;
                case 3:
                    Sport.teams[3].sportTeams.addAll(Arrays.asList("Rockies", "Dodgers", "Phillies", "Pirates", "Diamondbacks"));
                    break;
                default:
                    break;
            }
        }
    }

    public String getLeague(){
        return league;
    }

    public ArrayList<String> getSportTeams(){
        return sportTeams;
    }

    public String toString(){
        return this.league;
    }

}

