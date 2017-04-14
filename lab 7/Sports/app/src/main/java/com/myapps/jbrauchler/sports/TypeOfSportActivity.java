package com.myapps.jbrauchler.sports;

import android.content.Intent;
import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class TypeOfSportActivity extends ListActivity {
    private String sporttype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //create new intent
        Intent i = getIntent();
        sporttype = i.getStringExtra("sporttype");

        //get the list view
        ListView listSports = getListView();

        //define an array adapter
        ArrayAdapter<Sport> listAdapter;

        //initialize the array adapter with the right list of bulbs
        switch (sporttype){
            case "NFL":
                listAdapter = new ArrayAdapter<Sport>(this, android.R.layout.simple_list_item_1, Sport.nfl);
                break;
            case "NHL":
                listAdapter = new ArrayAdapter<Sport>(this, android.R.layout.simple_list_item_1, Sport.nhl);
                break;
            case "MLB":
            listAdapter = new ArrayAdapter<Sport>(this, android.R.layout.simple_list_item_1, Sport.mlb);
            break;
            default: listAdapter = new ArrayAdapter<Sport>(this, android.R.layout.simple_list_item_1, Sport.nhl);
        }

        //set the array adapter on the list view
        listSports.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(TypeOfSportActivity.this, SportActivity.class);
        //TypeOfSportActivity type_of_sport_activity = (TypeOfSportActivity) listView.getItemAtPosition(position);
        intent.putExtra("sportid", (int) id);
        //String team = type_of_sport_activity.getName();
        intent.putExtra("sporttype", sporttype);
        startActivity(intent);
    }

}
