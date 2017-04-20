package com.myapps.jbrauchler.gastracker;

import android.app.Activity;
import android.os.Bundle;
import android.content.Intent;
import android.view.View;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SaveMpgActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_save_mpg);
        Intent i = getIntent();

        String mpg = i.getStringExtra("mpg");
        TextView MPG = (TextView) findViewById(R.id.MpgValue);
        MPG.setText(mpg);
        TextView CurrentDate = (TextView) findViewById(R.id.CurrentDate);
        CurrentDate.setText(now());

    }


    public static final String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());

    public static String now() {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(date);
        return sdf.format(cal.getTime());
    }


    public void saveMpgClickHandler(View view) {
        TextView MPG = (TextView) findViewById(R.id.MPG);
        String mpg = MPG.getText().toString();
        TextView Date = (TextView) findViewById(R.id.CurrentDate);
        String date = Date.getText().toString();
        EditText GasStation = (EditText) findViewById(R.id.gasStation);
        String gasStation = GasStation.getText().toString();
        Spinner spinner = (Spinner)findViewById(R.id.spinner);
        String vehicle = spinner.getSelectedItem().toString();

        Intent intent = new Intent(SaveMpgActivity.this, MpgActivity.class);

        startActivity(intent);
    }
}
