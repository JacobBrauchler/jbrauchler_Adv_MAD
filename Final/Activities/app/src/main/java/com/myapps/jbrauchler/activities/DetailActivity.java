package com.myapps.jbrauchler.activities;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements ActivitiesDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        //get reference to the hero detail fragment
        ActivitiesDetailFragment activitiesDetailFragment = (ActivitiesDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        //get the id passed in the intent
        int categoryId = (int) getIntent().getExtras().get("id");
        //pass the category id to the fragment
        activitiesDetailFragment.setCategory(categoryId);
    }

    @Override public void addactivityclicked(View view){
        ActivitiesDetailFragment fragment = (ActivitiesDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addactivity();
    }
}
