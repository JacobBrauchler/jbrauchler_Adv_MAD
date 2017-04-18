package com.myapps.jbrauchler.gastracker;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Button;

public class CalculateActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_calculate);
    }

    public void buttonClickHandler(View view) {
        EditText mt = (EditText) findViewById(R.id.milesText);

        String milesString = mt.getText().toString();
        float miles = Float.parseFloat(milesString);
        EditText gt = (EditText) findViewById(R.id.gallonsText);
        String gallonsString = gt.getText().toString();
        float gallons = Float.parseFloat(gallonsString);
        float mpgNum = (miles/gallons);
        String mpgString = Float.toString(mpgNum);
        TextView MPG = (TextView) findViewById(R.id.MPG);
        String es = "";
        MPG.setText(mpgString);
        mt.setText(es);
        gt.setText(es);

    }
}
