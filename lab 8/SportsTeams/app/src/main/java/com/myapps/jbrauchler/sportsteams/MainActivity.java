package com.myapps.jbrauchler.sportsteams;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity implements SportListFragment.SportListListener, SportTeamFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override public void itemClicked(long id){
        //get a reference to the frame layout that contains HeroDetailFragment
        View fragmentContainer = findViewById(R.id.fragment_container);
        //large layout device
        if (fragmentContainer != null) {
            //create new fragment instance
            SportTeamFragment frag = new SportTeamFragment();
            //create new fragment transaction
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            //set the id of the universe selected
            frag.setLeague(id);
            //replace the fragment in the fragment container
            ft.replace(R.id.fragment_container, frag);
            //add fragment to the back stack
            ft.addToBackStack(null);
            //set the transition animation-optional
            ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            //commit the transaction
            ft.commit();
        } else{//app is running on a device with a smaller screen
            Intent intent = new Intent(this, DetailActivity.class);
            intent.putExtra("id", (int) id);
            startActivity(intent);
        }
    }

    //to handle back button presses
    @Override public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0 ){
            getFragmentManager().popBackStack();
        } else {
            super.onBackPressed();
        }
    }

    @Override public void addteamclicked(View view){
        SportTeamFragment fragment = (SportTeamFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addteam();
    }

}

