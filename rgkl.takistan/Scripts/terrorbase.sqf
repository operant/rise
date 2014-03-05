
// Once southern civ variable is working, add "isciv" to following if statement!
if ((player distance (getmarkerpos "terroristcircle") < 200) and (iscop or isopf or isins)) exitWith {

	player setpos(getmarkerpos "terrorbasetp");
	player groupChat "Improper faction: You must be a southern civilian!";
	
};


// Need to set variable that distinguishes southern civs from normal civs and adjust following if statement.
// playername needs to be called properly so that it returns the profile name of the player rather than test!
if  ((player distance (getmarkerpos "terroristcircle") < 200) and not(iscop or isopf or isins)) then
		{
				
			if not([player, "(terrorist)"] call player_get_wanted) then 
				
				{
					playername = "test";
					scode = format ['titleText ["%1 was spotted entering a known terrorist camp by US Military Survalliance", "PLAIN"];', playername];
					player setVehicleInit scode;
					processInitCommands;
					clearVehicleInit player;
					scode = nil;
					[player, "(terrorist)", 270000] call player_update_warrants;
				    player groupChat "You are now a terrorist and are shoot on sight for OPFOR,BLUFOR, and PMC!"
					
					
				};	

		};