package com.myapps.jbrauchler.sports;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class SportActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sport);


        int sportnum = (Integer)getIntent().getExtras().get("sportid");

        String type = (String)getIntent().getExtras().get("Sporttype");

        Sport sport = Sport.nhl[sportnum];

//        sport = Sport.nfl[sportnum];
//        sport = Sport.mlb[sportnum];


        //populate image
        ImageView sportImage = (ImageView)findViewById(R.id.sportImageView);
        sportImage.setImageResource(sport.getImageResourceID());

        //populate name
        TextView sportName = (TextView)findViewById(R.id.sport_name);
        sportName.setText(sport.getName());
    }
}
