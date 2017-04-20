package com.myapps.jbrauchler.gastracker;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.content.Context;
import android.widget.ListView;




public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                String bulbtype = (String) listView.getItemAtPosition(position);
                //create new intent
                Intent intent = new Intent(MainActivity.this, MpgActivity.class);


                //start intent
                startActivity(intent);
            }
        };

        ListView listview = (ListView) findViewById(R.id.vehiclelistView);

        //ArrayAdapter<Vehicle> listAdapter = new ArrayAdapter<Vehicle>(this, android.R.layout.simple_list_item_1, Vehicle.vehicles);

        //listview.setAdapter(listAdapter);

        listview.setOnItemClickListener(itemClickListener);
    }


    public boolean onCreateOptionsMenu(Menu menu){
        //inflate menu to add items to the action bar
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        //get the ID of the item on the action bar that was clicked
        switch (item.getItemId()){
            case R.id.add_vehicle:
                //start order activity
                Intent intent = new Intent(this, AddVehicleActivity.class);
                startActivity(intent);
                return true;
            case R.id.calculate:
                //start order activity
                intent = new Intent(this, CalculateActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }



}
