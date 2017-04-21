package com.myapps.jbrauchler.sportsteams;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class SportListFragment extends Fragment implements AdapterView.OnItemClickListener{


    //create listener
    private SportListListener listener;

    public SportListFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_sport_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if (view != null){
            //load data into fragment
            //get the list view
            ListView listUniverse = (ListView) view.findViewById(R.id.sportlistView);
            //define an array adapter
            ArrayAdapter<Sport> listAdapter = new ArrayAdapter<Sport>(getActivity(), android.R.layout.simple_list_item_1, Sport.teams);
            //set the array adapter on the list view
            listUniverse.setAdapter(listAdapter);

            //attach the listener to the listview
            listUniverse.setOnItemClickListener(this);
        }
    }

    //create interface
    interface SportListListener{
        void itemClicked(long id);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (SportListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            //tells the listener an item was clicked
            listener.itemClicked(id);
        }
    }

}

