package com.myapps.jbrauchler.sports;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class FavoriteActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorite);

        //get reference to action bar
        ActionBar actionBar = getActionBar();
        //enable the up button
        actionBar.setDisplayHomeAsUpEnabled(true);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                String sporttype = (String) listView.getItemAtPosition(position);
                AlertDialog alertDialog = new AlertDialog.Builder(FavoriteActivity.this).create();
                alertDialog.setTitle("Favorite");
                alertDialog.setMessage("Your favorite sport is " + sporttype + "!");
                alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.dismiss();
                            }
                        });
                alertDialog.show();
                //start intent
                //startActivity(intent);
            }
        };
        //get the list view
        ListView listview = (ListView) findViewById(R.id.listView);

        //add listener to the list view
        listview.setOnItemClickListener(itemClickListener);

    }
}
