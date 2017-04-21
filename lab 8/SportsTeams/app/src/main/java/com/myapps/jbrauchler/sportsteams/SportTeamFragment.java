package com.myapps.jbrauchler.sportsteams;


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

public class SportTeamFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long leagueId; //id of the league chosen

    //create listener
    private ButtonClickListener listener;

    public SportTeamFragment() {
        // Required empty public constructor
    }

    //set the league id
    public void setLeague(long id){
        this.leagueId = id;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState !=null){
            leagueId = savedInstanceState.getLong("leagueId");
        }

        //if the team list is empty, load teams
        if (Sport.teams[0].getSportTeams().size() == 0 ) {
            Sport.teams[0].loadSports(getActivity(), 0);
        }
        if (Sport.teams[1].getSportTeams().size() == 0 ) {
            Sport.teams[1].loadSports(getActivity(), 1);
        }
        if (Sport.teams[2].getSportTeams().size() == 0 ) {
            Sport.teams[2].loadSports(getActivity(), 2);
        }
        if (Sport.teams[3].getSportTeams().size() == 0 ) {
            Sport.teams[3].loadSports(getActivity(), 3);
        }

        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_sport_team, container, false);
    }

    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listTeams = (ListView) view.findViewById(R.id.teamlistView);

        // get team data
        ArrayList<String> teamlist = new ArrayList<String>();
        teamlist = Sport.teams[(int) leagueId].getSportTeams();

        //set array adapter
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, teamlist);

        //bind array adapter to the list view
        listTeams.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        //register context menu
        registerForContextMenu(listTeams);

    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("leagueId", leagueId);
    }

    //create interface
    interface ButtonClickListener{
        void addteamclicked(View view);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addteamclicked(view);
        }
    }

    public void addteam(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add team");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextTeam);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String teamName = editText.getText().toString();
                // add team
                Sport.teams[(int) leagueId].getSportTeams().add(teamName);
                //refresh the list view
                SportTeamFragment.this.adapter.notifyDataSetChanged();
                Sport.teams[(int) leagueId].storeSports(getActivity(), leagueId);
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
            Sport.teams[(int) leagueId].getSportTeams().remove(info.position);
            //refresh the list view
            SportTeamFragment.this.adapter.notifyDataSetChanged();
            Sport.teams[(int) leagueId].storeSports(getActivity(), leagueId);
        }
        return true;
    }
}

