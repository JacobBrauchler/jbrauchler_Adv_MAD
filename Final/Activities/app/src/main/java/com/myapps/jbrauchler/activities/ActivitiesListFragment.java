package com.myapps.jbrauchler.activities;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class ActivitiesListFragment extends Fragment implements AdapterView.OnItemClickListener {


    private ActivityListListener listener;

    public ActivitiesListFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_activites_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if (view != null){
            //load data into fragment
            //get the list view
            ListView listCategory = (ListView) view.findViewById(R.id.activitieslistView);
            //define an array adapter
            ArrayAdapter<Activity> listAdapter = new ArrayAdapter<Activity>(getActivity(), android.R.layout.simple_list_item_1, Activity.activities);
            //set the array adapter on the list view
            listCategory.setAdapter(listAdapter);

            //attach the listener to the listview
            listCategory.setOnItemClickListener(this);
        }
    }

    //create interface
    interface ActivityListListener{
        void itemClicked(long id);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ActivityListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            //tells the listener an item was clicked
            listener.itemClicked(id);
        }
    }

}
