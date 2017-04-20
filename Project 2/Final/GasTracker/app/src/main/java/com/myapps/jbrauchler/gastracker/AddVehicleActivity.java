package com.myapps.jbrauchler.gastracker;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class AddVehicleActivity extends Activity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_vehicle);

    }

    public void addVehicleClickHandler(View view) {
        EditText y = (EditText) findViewById(R.id.year);
        String year = y.getText().toString();
        EditText ma = (EditText) findViewById(R.id.make);
        String make = ma.getText().toString();
        EditText mo = (EditText) findViewById(R.id.model);
        String model = mo.getText().toString();

        String es = "";
        y.setText(es);
        ma.setText(es);
        mo.setText(es);
        Intent intent = new Intent(AddVehicleActivity.this, MainActivity.class);

        startActivity(intent);
    }
}
