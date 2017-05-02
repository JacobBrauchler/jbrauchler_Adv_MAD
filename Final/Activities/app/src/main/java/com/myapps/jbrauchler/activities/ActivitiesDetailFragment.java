package com.myapps.jbrauchler.activities;


import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


public class ActivitiesDetailFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long categoryId; //id of the category chosen

    //create listener
    private ButtonClickListener listener;

    public ActivitiesDetailFragment() {
        // Required empty public constructor
    }

    //set the league id
    public void setCategory(long id){
        this.categoryId = id;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        if (savedInstanceState !=null){
            categoryId = savedInstanceState.getLong("categoryId");
        }

        //if the team list is empty, load teams
        if (Activity.activities[0].getActivities().size() == 0 ) {
            Activity.activities[0].loadActivities(getActivity(), 0);
        }
        if (Activity.activities[1].getActivities().size() == 0 ) {
            Activity.activities[1].loadActivities(getActivity(), 1);
        }

        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_activities_detail, container, false);
    }

    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listActivities = (ListView) view.findViewById(R.id.detaillistView);

        // get team data
        ArrayList<String> activitylist = new ArrayList<String>();
        activitylist = Activity.activities[(int) categoryId].getActivities();

        //set array adapter
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, activitylist);

        //bind array adapter to the list view
        listActivities.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        //register context menu
        registerForContextMenu(listActivities);

    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("categoryId", categoryId);
    }

    //create interface
    interface ButtonClickListener{
        void addactivityclicked(View view);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addactivityclicked(view);
        }
    }

    public void addactivity(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Activity");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextActivity);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String activityName = editText.getText().toString();
                // add activity
                Activity.activities[(int) categoryId].getActivities().add(activityName);
                //refresh the list view
                ActivitiesDetailFragment.this.adapter.notifyDataSetChanged();
                Activity.activities[(int) categoryId].storeActivities(getActivity(), categoryId);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        //cast ContextMenu.ContextMenuInfo to AdapterView.AdapterContextMenuInfo since we're using an adapter
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        //get team name that was pressed
        String teamname = adapter.getItem(adapterContextMenuInfo.position);
        //set the menu title
        menu.setHeaderTitle("Delete " + teamname);
        //add the choices to the menu
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        //get the id of the item
        int itemId = item.getItemId();
        if (itemId == 1) { //if yes menu item was pressed
            //get the position of the menu item
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            //remove the team
            Activity.activities[(int) categoryId].getActivities().remove(info.position);
            //refresh the list view
            ActivitiesDetailFragment.this.adapter.notifyDataSetChanged();
            Activity.activities[(int) categoryId].storeActivities(getActivity(), categoryId);
        }
        return true;
    }

}
