package com.myapps.jbrauchler.sportsteams;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements SportTeamFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        //get reference to the hero detail fragment
        SportTeamFragment sportTeamFragment = (SportTeamFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        //get the id passed in the intent
        int leagueId = (int) getIntent().getExtras().get("id");
        //pass the league id to the fragment
        sportTeamFragment.setLeague(leagueId);
    }

    @Override public void addteamclicked(View view){
        SportTeamFragment fragment = (SportTeamFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addteam();
    }
}
