#define AdminConsol 1000
#define AdminPlayers 2006

private ["_c", "_player_variable_name", "_player_variable"];

_c = 0;
_player_variable_name = "";


for [{_c=0}, {_c < (count playerstringarray)}, {_c=_c+1}] do {
	_player_variable_name = playerstringarray select _c;
	_player_variable = missionNamespace getVariable _player_variable_name;

	if ([_player_variable] call player_exists) then {
		private["_player_name", "_index"];
		_player_name = (name _player_variable);
		_index = lbAdd [AdminPlayers, format ["%1 - (%2)", _player_variable_name, _player_name]];
		lbSetData [AdminPlayers, _index, format["%1", _player_variable]];
	};
};

isAdminInvisible = false;

_array = [];
    if (isMod || isAdmin || isSnAdmin || isAdminDev || isDeveloper) then
        {
           _newarray =
           [
			["------ Commands ------",	{}],


			["Admin Camera (Toggle)", {
				handle = [] execVM "camera.sqf";
			}],
			["Admin Camera (GCAM)", {
				handle = [] execVM "gcam.sqf";
			}],
			["Server Message", {
				MessageText = _inputText;
				scode = format ['titleText ["%1", "PLAIN"];', MessageText];
				player setVehicleInit scode;
				processInitCommands;
				clearVehicleInit player;
				hint "Done the message was sent to all players";
				scode = nil;
			}],

			["Weapongedon", {
				_distance = parseNumber(_inputText);

				if ((typeName _distance) == (typeName (1234))) then {

					if (_distance > 8000) exitwith{player groupchat format["Range must be 8000 or less"];};

						player groupchat format["Starting Weapongedon at a range of %1 meters", _distance];
						{
							{
								if ({alive _x} count crew _x == 0) then {
										deleteVehicle _x;
								};
							} foreach((getpos player) nearObjects [_x, _distance]);
						} forEach (droppableitems + ["WeaponHolder","Bag_Base_EP1","WeaponHolderBase"]);
					}
					else {
						hint "ERROR: expected number";
					};
			}],

			["Carmagedon", {
				_distance = parseNumber(_inputText);

				if ((typeName _distance) == (typeName (1234))) then {

					if (_distance > 8000) exitwith{player groupchat format["Range must be 8000 or less"];};

						player groupchat format["Starting Carmagedon at a range of %1 meters", _distance];
						{
							{
								if ({alive _x} count crew _x == 0) then {
										deleteVehicle _x;
								};
							} foreach((getpos player) nearObjects [_x, _distance]);
						} forEach (droppableitems + ["LandVehicle", "Air", "Car", "Motorcycle", "Bicycle", "UAV", "Wreck", "Wreck_Base", "HelicopterWreck", "UH1Wreck", "UH1_Base", "UH1H_base", "AH6_Base_EP1","CraterLong", "Ka60_Base_PMC", "Ka137_Base_PMC", "A10"]);
					}
					else {
						hint "ERROR: expected number";
					};
			}],

			["Give Player Money (Select)", {
				private["_variableName"];
				_variableName = (vehicleVarName _selectedplayer);
				if (isNil "_variableName") exitWith{};
				if (_variableName == "") exitWith {};
				_amount = parseNumber(_inputText);

				if ((typeName _amount) == (typeName (1234))) then
				{
					hint format["Giving player %1 %2 dollars", _variableName, _amount];
					format['
						[] spawn
						{
							if (player != %1) exitWith {};
							liafu = true;
							[player, %2] call transaction_bank;
							player groupChat "A Server Administrator has sent you %2 dollars";
						};
					', _selectedplayer, _amount] call broadcast;
				}
				else
				{
					hint "ERROR: expected number";
				};

			}],

            ["Kick Player to Lobby", {

			format['
            [] spawn
                    {
                        if (player != %1) exitWith {};
                        liafu = true;
                        player groupChat "You have been kicked to the lobby by a server moderator.";
                        sleep 3;
                        failMission "END1";
                    };
                ', _selectedplayer] call broadcast;

            }],
			["Declare Martial Law", {
				MessageText = "Martial Law has been declared in Rasman!";
				scode = format ['titleText ["%1", "PLAIN"];', MessageText];
				player setVehicleInit scode;
				processInitCommands;
				clearVehicleInit player;
				hint "Done the message was sent to all players";
				scode = nil;
			}],
			["End Martial Law", {
				MessageText = "Martial Law has been lifted in Rasman!";
				scode = format ['titleText ["%1", "PLAIN"];', MessageText];
				player setVehicleInit scode;
				processInitCommands;
				clearVehicleInit player;
				hint "Done the message was sent to all players";
				scode = nil;
			}],
			["Declare War", {
				MessageText = "OPFOR has declared war against BLUFOR!";
				scode = format ['titleText ["%1", "PLAIN"];', MessageText];
				player setVehicleInit scode;
				processInitCommands;
				clearVehicleInit player;
				hint "Done the message was sent to all players";
				scode = nil;
			}],
			["End War", {
				MessageText = "OPFOR has ended the war against BLUFOR!";
				scode = format ['titleText ["%1", "PLAIN"];', MessageText];
				player setVehicleInit scode;
				processInitCommands;
				clearVehicleInit player;
				hint "Done the message was sent to all players";
				scode = nil;
			}],

			["Give ALL Players Money", {
				private["_variableName"];
				_variableName = (vehicleVarName _selectedplayer);
				if (isNil "_variableName") exitWith{};
				if (_variableName == "") exitWith {};
				_amount = parseNumber(_inputText);

				if ((typeName _amount) == (typeName (1234))) then
				{
					hint format["Giving all players %1 dollars", _amount];
					format['
						[] spawn
						{
							liafu = true;
							[player, %2] call transaction_bank;
							player groupChat "A Server Administrator has sent you %2 dollars";
						};
					', _selectedplayer, _amount] call broadcast;
				}
				else
				{
					hint "ERROR: expected number";
				};

			}]

             ];
          _array = _array + _newarray;
        };

    if (isAdmin || isSnAdmin || isAdminDev || isDeveloper) then
        {
           _newarray =
           [
			["----- Admin Commands -----",	{}],
			["Self Teleport", {
				hint "Click on the map to Teleport!";
				liafu = true;
				closeDialog 0;
				openMap true;
				onMapSingleClick "onMapSingleClick """";liafu = true; (vehicle player) setpos [_pos select 0, _pos select 1, 0]; openMap false;";
			}],

			["Give ALL Players Money", {
				private["_variableName"];
				_variableName = (vehicleVarName _selectedplayer);
				if (isNil "_variableName") exitWith{};
				if (_variableName == "") exitWith {};
				_amount = parseNumber(_inputText);

				if ((typeName _amount) == (typeName (1234))) then
				{
					hint format["Giving all players %1 dollars", _amount];
					format['
						[] spawn
						{
							liafu = true;
							[player, %2] call transaction_bank;
							player groupChat "A Server Administrator has sent you %2 dollars";
						};
					', _selectedplayer, _amount] call broadcast;
				}
				else
				{
					hint "ERROR: expected number";
				};

			}],

			["Remove player weapons", {
				format['
					[] spawn
					{
						if (player != %1) exitWith {};
						liafu = true;
						removeAllWeapons player;
					};
				', _selectedplayer] call broadcast;
			}],
			["Kill player", {
				format['
					[] spawn
					{
						if (player != %1) exitWith {};
						liafu = true;
						(player) setDamage 1;
					};
				', _selectedplayer] call broadcast;
			}],

			["Destroy player vehicle", {
				format['
					[] spawn
					{
						if (player != %1) exitWith {};
						liafu = true;
						(vehicle player) setDamage 1;
					};
				', _selectedplayer] call broadcast;
			}],
			["Jail Player", {
				_jailminutes = parseNumber(_inputText);

				if (_jailminutes > 20) exitwith {player groupChat format["This value must be 20 minutes or lower"];};

				if ((typeName _jailminutes) == (typeName (1234))) then {

					format['server globalChat"%1 was sent to jail for %2 minute(s) by a server administrator";', _selectedplayer, _jailminutes] call broadcast;
					format['[%1, %2] call player_prison_time;', _selectedplayer, _jailminutes] call broadcast;
					format['[%1, 100] call player_prison_bail;', _selectedplayer] call broadcast;
					format['[%1] call player_prison_convict;', _selectedplayer] call broadcast;
					}
				else {
					hint "ERROR: expected number";
				};


			}],
			["Fix My Vehicle", {
				vehicle player setFuel 1;
				vehicle player setvehicleammo 1;
				vehicle player setDamage 0;
			}],



        	["Speed 5 - Nitro Vehicle", {
				(vehicle player) setvariable ["tuning", 5, true];
				(vehicle player) setvariable ["nitro", 1, true];
			}],



			["Heal World", {
			_objs = (position (vehicle player) nearObjects 100000); {_x setDamage 0} forEach _objs;
			(format ["titleText [""%1 has just performed a worldwide repair/heal!"", ""plain""];",name player]) call broadcast
			}],

			/*
            ["Add 100K Dollars to Bank", {
                    [player, 100000] call transaction_bank;
            }],

            ["Add 1M Dollars to Bank", {
                    [player, 1000000] call transaction_bank;
            }],
			*/
			["----- ITEMS -----",	{}],
			["10 Lockpicks", {
				[player, 'lockpick',10] call INV_AddInventoryItem;
			}],

			["Large Repair Kit", {
				[player, 'reparaturkit',1] call INV_AddInventoryItem;
			}],
/*
			["10 Bank insurance", {
				[player,'bankversicherung',10] call INV_AddInventoryItem;
			}],
*/
			["Refuel Can", {
				[player, 'kanister',1] call INV_AddInventoryItem;
			}],

			["Pistol", {
				{player addMagazine "17Rnd_9x19_glock17";} forEach [1,2,3,4,5,6,7,8];
				player addweapon "glock17_EP1";
				player action ["switchweapon", player, player, 0];
			}],
			["RangeFinder", {
				player addweapon "binocular_vector";
				player action ["switchweapon", player, player, 0];

			}],


			["NV Goggles - ADMIN CAM USE", {
				player addweapon "NVGoggles";
			}],

			["+1 Hour time", {
				[1] call time_move;
				player groupChat "+1 Hour, please wait for time to catch-up, before using again";
			}],

			["-1 Hour time", {
				[-1] call time_move;
				player groupChat "-1 Hour, please wait for time to catch-up, before using again";
			}],

			["Reset time(90m dy, 60m nt)", {
				player groupChat "Time reset (90-min day, 60-min night), please wait for synchronization to complete";
				[90,60] call time_reset;
			}],

			["Reset time(60m dy, 30m nt)", {
				player groupChat "Time reset (60-min day, 30-min night), please wait for synchronization to complete";
				[60,30] call time_reset;
			}],

			["Reset time(40m dy, 20m nt)", {
				player groupChat "Time reset (40-min day, 20-min night), please wait for synchronization to complete";
				[40,20] call time_reset;
			}]
        ];

          _array = _array + _newarray;
        };

    if (isSnAdmin || isAdminDev || isDeveloper) then
        {
           _newarray =
           [

		    ["----- SnAdmin Commands -----",	{}],

			["2-D Map Toggle", {
				handle = [] execVM "2dmap.sqf";
			}],

			["Toggle Invisibility (On)", {
						objMYPlayer = (vehicle player);
				        publicVariable "objMYPlayer";



				        strExecCode = 'objMYPlayer hideObject true;';

				        player setVehicleInit strExecCode;
				        processInitCommands;
				        clearVehicleInit player;
				        player groupChat format["Your are now Invisible"];
				        strExecCode = nil;
			}],
			["Toggle Invisibility (Off)", {
						objMYPlayer = (vehicle player);
				        publicVariable "objMYPlayer";



				        strExecCode = 'objMYPlayer hideObject false;';

				        player setVehicleInit strExecCode;
				        processInitCommands;
				        clearVehicleInit player;
				        player groupChat format["Your are no longer Invisible"];
				        strExecCode = nil;
			}]

             ];
          _array = _array + _newarray;
        };

    if (isAdminDev || isDeveloper) then
        {
           _newarray =
           [

		    ["------ Misc Commands ------",	{}],
			["Weapon: AKM - M1911", {
				{player addMagazine "30Rnd_762x39_AK47";} forEach [1,2,3,4,5,6,7,8];
				player addweapon "AK_47_S";
				{player addMagazine "7Rnd_45ACP_1911";} forEach [1,2,3,4,5,6,7,8];
				player addweapon "Colt1911";
				player action ["switchweapon", player, player, 0];
			}],

			["10 Satchel Charges", {
				handle = [] execVM "boomboom.sqf";
			}]


             ];
          _array = _array + _newarray;
        };

    if (isAdminDev || isDeveloper) then
        {
           _newarray =
           [

		    ["------- Dev Commands -------",	{}],

			["Add 100,000 Dollars to Inventory", {
				[player, 'money',100000] call INV_AddInventoryItem;
			}],

			["Add 1 Million Dollars to Inventory", {
				[player, 'money',1000000] call INV_AddInventoryItem;
			}],
			["Spawn Vehicle (Class Based)", {
				_item = _inputtext;
				_inputtext createVehicle [(getpos player select 0) + 0, (getpos player select 1) + 0, getpos player select 2];

			}],
			["Custom Command", {
				_command = _inputtext;
				call compile _command;
			}],
			/*
			["Custom Command (On Target)", {
				_command = _inputtext;
				private["_variableName"];
				_variableName = (vehicleVarName _selectedplayer);
				if (isNil "_variableName") exitWith{};
				if (_variableName == "") exitWith {};
				hint format["Executing %2 on %1", _variableName, _command];
					format['
						[] spawn
						{

							if (player != %1) exitWith {};
							liafu = true;
							call compile _command;
							player groupChat "Done";
						};
					', _selectedplayer, _command] call broadcast;

			}],
			*/

			["Spawn Armored SUV", {

			"ArmoredSUV_PMC" createVehicle [(getpos player select 0) + 10, (getpos player select 1) + 10, getpos player select 2];

			}],

			["Spawn M1128_MGS_EP1", {

			"M1128_MGS_EP1" createVehicle [(getpos player select 0) + 10, (getpos player select 1) + 10, getpos player select 2];

			}],

			/*
			["Spawn USBasicWeaponsBox", {

			"USBasicWeaponsBox" createVehicle [(getpos player select 0) + 10, (getpos player select 1) + 10, getpos player select 2];

			}],

			["Spawn WarfareBDepot", {

			"WarfareBDepot" createVehicle [(getpos player select 0) + 10, (getpos player select 1) + 10, getpos player select 2];

			}],

			["Spawn Land_fortified_nest_small", {

			"Land_fortified_nest_small" createVehicle [(getpos player select 0) + 0, (getpos player select 1) + 0, getpos player select 2];

			}],

			["Spawn Land_fort_bagfence_long", {

			"Land_fort_bagfence_long" createVehicle [(getpos player select 0) + 0, (getpos player select 1) + 0, getpos player select 2];

			}],

			["Spawn Land_fortified_nest_big", {

			"Land_fortified_nest_big" createVehicle [(getpos player select 0) + 0, (getpos player select 1) + 0, getpos player select 2];

			}],

			["Spawn Land_Fort_Watchtower_EP1", {

			"Land_Fort_Watchtower_EP1" createVehicle [(getpos player select 0) + 0, (getpos player select 1) + 0, getpos player select 2];

			}],
			*/
			["Weapon: VSS-Vintorez", {
				{player addMagazine "20Rnd_9x39_SP5_VSS";} forEach [1,2,3,4,5,6,7,8];
				player addweapon "VSS_vintorez";
				player action ["switchweapon", player, player, 0];
			}],

			["Campfire Song Song!", {
				//_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
    			//_soundToPlay = _soundPath + "Awesome\Sound\campfiresongsong.ogg";
    			//playSound3D [_soundToPlay, _obj, false, _pos, 10, 1, 50];
    			player say3D "campfiresongsong";
			}]

/*
			["COP - 1 List - BUGGED", {

				["COP_1"] spawn A_WBL_F_DIALOG_INIT;

			}]
			*/

		];
          _array = _array + _newarray;
        };

_endarray =
		[

		   ["FuckDaPolice", {}]
		];
_array = _array + _endarray;

{
	private["_text", "_code", "_index"];
	_text = _x select 0;
	_code = _x select 1;

	_index = lbAdd [AdminConsol, _text];
	lbSetData [AdminConsol, _index, format['call %1', _code]];
} forEach _array;



