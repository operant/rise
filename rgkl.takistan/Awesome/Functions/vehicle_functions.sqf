if (not(isNil "vehicle_functions_defined")) exitWith {};


// --------- Set variable functions
vehicle_set_var = {
	private["_vehicle", "_variable_name", "_variable_value", "_variable_type"];

	_vehicle = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	_variable_type = _this select 3;
	
	[_vehicle, _variable_name, _variable_value, _variable_type, true] call vehicle_set_var_checked;
};

vehicle_set_var_checked = {
	private["_vehicle", "_variable_name", "_variable_value", "_checked", "_variable_type"];

	_vehicle = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	_variable_type = _this select 3;
	_checked = _this select 4;
	
	
	if (isNil "_vehicle") exitWith {};
	if (isNil "_variable_name") exitWith {};
    if (isNil "_variable_value") exitWith {};
	if (isNil "_variable_type") exitWith {};
	if (isNil "_checked") exitWith {};
	
	if (typeName _variable_name != "STRING") exitWith {};
	if (typeName _variable_type != "STRING") exitWith {};
	if (typeName _variable_value != _variable_type) exitWith {};
	if (typeName _checked != "BOOL") exitWith {};
	
	private["_current_value"];
	_current_value = [_vehicle, _variable_name, _variable_type] call vehicle_get_var;
	if(_checked && (str(_current_value) == str(_variable_value))) exitWith {};
	
	_vehicle setVariable [_variable_name, _variable_value, true];
	[_vehicle, _variable_name, _variable_value] call stats_vehicle_save;
};

vehicle_set_string = {
	_this set [3, "STRING"];
	_this call vehicle_set_var;
};

vehicle_set_string_checked = {
	private["_checked"];
	_checked = _this select 3;
	_this set [3, "STRING"];
	_this set [4, _checked];
	_this call vehicle_set_var_checked;
};

vehicle_set_array = {
	_this set [3, "ARRAY"];
	_this call vehicle_set_var;
};

vehicle_set_array_checked = {
	private["_checked"];
	_checked = _this select 3;
	_this set [3, "ARRAY"];
	_this set [4, _checked];
	_this call vehicle_set_var_checked;
};

vehicle_set_bool = {
	_this set [3, "BOOL"];
	_this call vehicle_set_var;
};

vehicle_set_scalar = {
	_this set [3, "SCALAR"];
	_this call vehicle_set_var;
};

// --- UPDATE functions 

vehicle_update_array = {
	_this set [3, "ARRAY"];
	_this call vehicle_set_var;
};

vehicle_update_bool = {
	_this set [3, "BOOL"];
	_this call vehicle_set_var;
};

vehicle_update_scalar = {
	_this set [3, "SCALAR"];
	_this call vehicle_set_var;
};

vehicle_update_string = {
	_this set [3, "STRING"];
	_this call vehicle_set_var;
};

// GET functions

vehicle_get_var = {
	private["_vehicle", "_variable_name", "_variable_type", "_variable_value"];
	_vehicle = _this select 0;
	_variable_name = _this select 1;
	_variable_type = _this select 2;
	
	if (isNil "_vehicle") exitWith {};
	if (isNil "_variable_name") exitWith {};
	if (isNil "_variable_type") exitWith {};
	if ((typeName _variable_name) != "STRING") exitWith {};
	if ((typeName _variable_type) != "STRING") exitWith {};
	_variable_value = _vehicle getVariable _variable_name;
	_variable_value = if(isNil "_variable_value") then { "" } else { _variable_value };
	_variable_value = if ((typeName _variable_value) != _variable_type) then { "" } else { _variable_value };
	_variable_value
};
vehicle_get_string = {
	_this set [2, "STRING"];
	(_this call vehicle_get_var)
};

vehicle_get_array = {
	_this set [2, "ARRAY"];
	(_this call vehicle_get_var)
};

vehicle_get_bool = {
	_this set [2, "BOOL"];
	(_this call vehicle_get_var)
};

vehicle_get_scalar = {
	_this set [2, "SCALAR"];
	(_this call vehicle_get_var)
};

vehicle_despawn = { _this spawn {
	if (not(isServer)) exitWith {};
	private["_vehicle", "_delay"];
	
	//diag_log format["vehicle_despawn %1", _this];
	
	_vehicle = _this select 0;
	_delay = _this select 1;
	
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	
	if (isNil "_delay") exitWith {};
	if (typeName _delay != "SCALAR") exitWith {};
	
	[_vehicle, "saved_driver_uid", ""] call vehicle_set_string;
	[_vehicle] call vehicle_stop_track;

	//diag_log format["vehicle_despawn %1, waiting", _this];
	[_delay] call isleep;
	//diag_log format["vehicle_despawn %1, deleting", _this];
	deleteVehicle _vehicle;	
};};

vehicle_unload_stats = {
	private["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	
	private["_stats_uid"];
	_stats_uid = [_vehicle] call stats_get_uid;
	if (_stats_uid == "") exitWith {};
	
	[_stats_uid] call unloadPlayerVariables;
};

vehicle_stop_track = {
	private["_vehicle"];
	_vehicle = _this select 0;
	
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	[_vehicle] call vehicle_save_stats;
	[_vehicle] call vehicle_unload_stats;
	_vehicle setVariable ["track", false];
};

vehicle_track = {
	private["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	
	private["_track"];
	_track = _vehicle getVariable "track";
	if (isNil "_track") exitWith {};
	if (typeName _track != "BOOL") exitWith {};
	if (not(_track)) exitWith {};
	[_vehicle] call vehicle_save_stats;
};

vehicle_start_track = {
	private["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	_vehicle setVariable ["track", true, true]; 
};



vehicle_GetIn_handler = {
	private["_vehicle", "_position", "_player"];
	_vehicle = _this select 0;
	_position = _this select 1;
	_player = _this select 2;
	
	if (_player != player) exitWith {};
	
	if (_position == "driver") then {
		[_player] call player_save_side_vehicle;
		private["_entred_driver_uid"];
		_entred_driver_uid = ([_player] call stats_get_uid);
		_vehicle setVariable ["active_driver_uid", _entred_driver_uid, true];
		
		private["_saved_driver_uid"];
		_saved_driver_uid = [_vehicle, "saved_driver_uid"] call vehicle_get_string;
		
		if (_saved_driver_uid == _entred_driver_uid) then {
			[_vehicle, "saved_driver_uid", ""] call vehicle_set_string;
			[_vehicle] call vehicle_stop_track;
		}
		else {
			[_vehicle] call vehicle_track;
		};
		
		
	};
};



vehicle_GetOut_handler = {
	private["_vehicle", "_position", "_player"];
	_vehicle = _this select 0;
	_position = _this select 1;
	_player = _this select 2;
	
	if (_player != player) exitWith {};
	
	if (_position == "driver") then {
		[_player] call player_save_side_vehicle;
		_vehicle setVariable ["active_driver_uid", "", true];
		
		private["_exited_driver_uid"];
		_exited_driver_uid = [_player] call stats_get_uid;
		
		private["_saved_driver_uid"];
		_saved_driver_uid = [_vehicle, "saved_driver_uid"] call vehicle_get_string;
		
		if ((_saved_driver_uid == _exited_driver_uid)) then {
			[_vehicle, "saved_driver_uid", ""] call vehicle_set_string;
			[_vehicle] call vehicle_stop_track;
		}
		else {
			[_vehicle] call vehicle_track;
		};
		
		
	};
};

vehicle_save_gear_request_receive = {
	/*
	private["_str"];
	_str = format["vehicle_save_gear_request_receive %1", _this];
	player groupChat _str;
	diag_log _str;
	*/
	
	private["_variable", "_request"];
	_variable = _this select 0;
	_request = _this select 1;

	if (isNil "_request") exitWith {};
	if (typeName _request != "ARRAY") exitWith {};

	private["_vehicle"];
	_vehicle = _request select 0;
	private["_gear", "_weapons", "_magazines"];
	//diag_log format["getting gear for %1", _vehicle];
	_gear = [_vehicle] call vehicle_get_gear;
	if (isNil "_gear") exitWith {};
	//diag_log format["saving %1, %2", _vehicle, _gear];
	_weapons = _gear select vehicle_gear_weapons_cargo;
	_magazines = _gear select vehicle_gear_magazines_cargo;
	[_vehicle, "weapons", _weapons] call vehicle_set_array;
	[_vehicle, "magazines", _magazines] call vehicle_set_array;
};


vehicle_save_gear_setup = {
	if (not(isServer)) exitWith {};
	//player groupChat format["vehicle_save_gear_setup %1", _this];
	vehicle_side_gear_request_buffer =  " ";
	publicVariableServer "vehicle_side_gear_request_buffer";
	"vehicle_side_gear_request_buffer" addPublicVariableEventHandler { _this call vehicle_save_gear_request_receive;};
};


vehicle_save_gear = {
	private["_vehicle"]; 
	_vehicle = _this select 0;
	if (not([_vehicle] call vehicle_exists)) exitWith {};

	vehicle_side_gear_request_buffer = [_vehicle];
	if (isServer) then {
		["", vehicle_side_gear_request_buffer] call vehicle_save_gear_request_receive;
	}
	else {
		publicVariable "vehicle_side_gear_request_buffer";
	};
};

vehicle_save_stats = {
	/*
	private["_str"];
	_str = format["vehicle_save_stats %1, %2", _this, (driver(_this select 0))];
	diag_log _str;
	player groupChat _str;
	*/
	//diag_log format["item_name = %1", ([_vehicle, "item_name"] call vehicle_get_string)];
	
	private["_vehicle"];

	_vehicle = _this select 0;
	
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	if (_vehicle isKindOf "Man") exitWith {};
	
	private["_dirver"];
	_driver = driver(_vehicle);
	
	private["_name", "_class", "_driver_uid", "_velocity", "_position_atl", "_vector_direction", "_vector_up", "_fuel", "_damage", "_engine_state", "_fuel"];
	
	_name = vehicleVarName _vehicle;
	_class = typeOf _vehicle;
	_velocity = velocity _vehicle;
	_position_atl = getPosATL _vehicle;
	_vector_direction = vectorDir _vehicle;
	_vector_up = vectorUp _vehicle;
	_fuel = fuel _vehicle;
	_damage = damage _vehicle;
	_engine_state = isEngineOn _vehicle;
	
	private["_driver_uid"];
	//_driver_uid = [_vehicle, "active_driver_uid"] call vehicle_get_string;
	_driver_uid = "";
	if ([_driver] call player_exists) then {
		_driver_uid = [_driver] call stats_get_uid;
	};
	
	/*
	private["_str"];
	_str = format[ "_driver_uid = %1, typeName _driver_uid = %2 ", _driver_uid,  (typeName _driver_uid)];
	diag_log _str;
	player groupChat _str;
	*/
	
	[_vehicle, "name", _name] call vehicle_set_string;
	[_vehicle, "saved_driver_uid", _driver_uid] call vehicle_set_string;
	[_vehicle, "class", _class] call vehicle_set_string;
	[_vehicle, "velocity", _velocity] call vehicle_set_array;
	[_vehicle, "position_atl", _position_atl] call vehicle_set_array;
	[_vehicle, "vector_direction", _vector_direction] call vehicle_set_array;
	[_vehicle, "vector_up", _vector_up] call vehicle_set_array;
	[_vehicle, "fuel", _fuel] call vehicle_set_scalar;
	[_vehicle, "damage", _damage] call vehicle_set_scalar;
	[_vehicle, "engine_state", _engine_state] call vehicle_set_bool;
	[_vehicle] call vehicle_save_gear;
	[_vehicle] call vehicle_save_storage;
	[_vehicle, "item_name", ([_vehicle, "item_name"] call vehicle_get_string), false] call vehicle_set_string_checked; 
};



vehicle_init_stats = {
	private["_vehicle"];
	
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	if (typeName _vehicle != "OBJECT") exitWith {};
	
	private["_driver", "_velocity", "_position_atl", "_vector_direction", "_vector_up", "_fuel", "_damage", "_engine_state", "_weapons", "_magazines"];
	
	_velocity = [_vehicle, "velocity"] call vehicle_get_array;
	_position_atl = [_vehicle, "position_atl"] call vehicle_get_array;
				
	_vector_direction = [_vehicle, "vector_direction"] call vehicle_get_array;
	_vector_up =[_vehicle, "vector_up"] call vehicle_get_array;
	_fuel = [_vehicle, "fuel"] call vehicle_get_scalar;
	_damage = [_vehicle, "damage"] call vehicle_get_scalar;
	_engine_state = [_vehicle, "engine_state"] call vehicle_get_bool;
	_weapons = [_vehicle, "weapons"] call vehicle_get_array;
	_magazines= [_vehicle, "magazines"] call vehicle_get_array;
	
	private["_gear"];
	_gear = [];
	_gear set [vehicle_gear_weapons_cargo, _weapons];
	_gear set [vehicle_gear_magazines_cargo, _magazines];
	
	[_vehicle,_gear] call vehicle_set_gear;
	
	_vehicle setPosATL _position_atl;
	_vehicle setVectorDirAndUp [_vector_direction, _vector_up];
	_vehicle setVelocity _velocity;
	_vehicle engineOn _engine_state;
	_vehicle setDamage _damage;
	_vehicle setFuel _fuel;
};

vehicle_set_modifications = {
	private["_vehicle", "_item", "_silent"];
	
	_vehicle = _this select 0;
	_item = _this select 1;
	_silent = _this select 2;
	
	if (isNil "_vehicle") exitWith {};
	if (isNil "_item") exitWith {};
	if (isNil "_silent") then { _silent = false; };
	
	if (typeName _vehicle != "OBJECT") exitWith {};
	if (typeName _item != "STRING") exitWith {};
	if (typeName _silent != "BOOL") exitWith {};
	_vehicle setVariable ["item_name", _item, true];
	
	switch (_item) do {
		case "blank": { };
		/* Octavia_ill, Octavia_PMC, Octavia_UN, Octavia_Cop, Octavia_Civ */
		case "Octavia_Civ": {};
		case "Octavia_ill": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0, "#(argb,8,8,3)color(0.5,0,0.5,0.5,ca)"]'; 
			processInitCommands;
		};
		case "Octavia_Cop": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.5,ca)"]'; 
			processInitCommands;
		};
		case "Octavia_UN": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0, "#(argb,8,8,3)color(1,1,1,0.5,ca)"]'; 
			processInitCommands;
		};
		case "Octavia_PMC": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0, "#(argb,8,8,3)color(0,0,0,1,ca)"]';
			processInitCommands;
		};
		case "SUV_UN_EP1_retex": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suvpolice.paa"]'; 
			processInitCommands;
		};
		case "SUV_TK_EP1_vip": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suvdonator.paa"]'; 
			processInitCommands;
		};
		
		case "SUV_TK_EP1_retex_special": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suv_special_force.paa"]'; 
			processInitCommands;
		};
		
		case "SUV_UN_EP1_retex_don": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suvpolice.paa"]'; 
			processInitCommands;
		};
		case "SUV_TK_EP1_don": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suvdonator.paa"]'; 
			processInitCommands;
		};
		case "SUV_TK_EP1_vip": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\suvdonator.paa"]'; 
			processInitCommands;
		};
		case "SUV_TK_EP1_news": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0,"images\news_suv.paa"]'; 
			processInitCommands;
		};
		case "MH6J_EP1_news": {
			_vehicle setVehicleInit 'liafu = true; this setObjectTexture [0, "images\news_chopper.paa"]'; 
			processInitCommands;
		};
		
		case "ArmoredSUV_PMC": {
			[_vehicle] call armored_suv_close_minigun;
		};
		case "Ka60_PMC": {
			if(not(_silent)) then { hint "Reconfiguring helicopter armament..."; };
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addweapon "TwinM134";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
			_vehicle removeweapon "57mmLauncher";
		};
		case "Ka60_GL_PMC": {
			if(not(_silent)) then { hint "Reconfiguring helicopter armament..."; };
			_vehicle removeweapon "57mmLauncher";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
			_vehicle addweapon "M240_veh";
			_vehicle addmagazine "100Rnd_762x51_M240";
			_vehicle addmagazine "100Rnd_762x51_M240";
			_vehicle addmagazine "100Rnd_762x51_M240";
			_vehicle addmagazine "100Rnd_762x51_M240";
			_vehicle addmagazine "100Rnd_762x51_M240";
		};
		case "HMMWV_DES_EP1_don": {
			if(not(_silent)) then { hint "Reconfiguring vehicle..."; };
			_vehicle setvariable ["tuning", 3, true];
		};
		
		
		case "Ka60_PMC_don": {
			if(not(_silent)) then { hint "Reconfiguring helicopter armament..."; };
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addweapon "TwinM134";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
		};
		
		
		case "AH6J_EP1": {
			if(not(_silent)) then { hint "Reconfiguring helicopter armament..."; };
			_vehicle removeweapon "FFARLauncher_14";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
		};
		case "An2_TK_Cop": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle addweapon "M3P";
			_vehicle addmagazine "250Rnd_127x99_M3P";
			_vehicle addmagazine "250Rnd_127x99_M3P";
			_vehicle addmagazine "250Rnd_127x99_M3P";
			_vehicle addweapon "TwinM134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
		};
		
		case "A10_US_EP1": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle removeweapon "SidewinderLaucher_AH1Z";
			_vehicle removeweapon "BombLauncherA10";
			_vehicle removeweapon "FFARLauncher_14";
		};
		case "Su25_Ins": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle addmagazine "1350Rnd_30mmAP_A10";
			_vehicle addmagazine "2Rnd_Maverick_A10";
			_vehicle removeweapon "AirBombLauncher";
			_vehicle removeweapon "R73Launcher_2";
			_vehicle removeweapon "GSh301";
			_vehicle removeweapon "S8Launcher";
			_vehicle addweapon "GAU8";
			_vehicle addweapon "SidewinderLaucher_AH1Z";
			
		};
			case "F35B_don": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle addmagazine "1350Rnd_30mmAP_A10";
			_vehicle removeweapon "GAU12";
			_vehicle removeweapon "BombLauncherF35";
			_vehicle addmagazine "14Rnd_FFAR";
			_vehicle addweapon "FFARLauncher_14";
			_vehicle addweapon "GAU8";
			
			
		};
		case "Su25_Ins_don": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle removeweapon "AirBombLauncher";
			_vehicle removeweapon "R73Launcher_2";
			_vehicle removeweapon "GSh301";
			_vehicle removeweapon "S8Launcher";
			_vehicle addmagazine "1350Rnd_30mmAP_A10";
			_vehicle removeweapon "GAU12";
			_vehicle removeweapon "BombLauncherF35";
			_vehicle addmagazine "14Rnd_FFAR";
			_vehicle addweapon "FFARLauncher_14";
			_vehicle addweapon "GAU8";
			_vehicle addmagazine "2Rnd_Sidewinder_F35";
			_vehicle addweapon "SidewinderLaucher_F35";
		
			
			
		};
		case "C130J_US_EP1_cop": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle addweapon "2A72";
			_vehicle addmagazine "250Rnd_30mmAP_2A72";
			_vehicle addmagazine "250Rnd_30mmHE_2A72";
			_vehicle addmagazine "250Rnd_30mmAP_2A72";
			_vehicle addmagazine "250Rnd_30mmHE_2A72";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";			
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addmagazine "2000Rnd_762x51_M134";
			_vehicle addweapon "TwinM134";
			
			
			
		};
		case "An2_TK_EP1": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle addweapon "DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addweapon "TwinVickers";
			_vehicle addmagazine "500Rnd_TwinVickers";
			_vehicle addmagazine "500Rnd_TwinVickers";
			_vehicle addmagazine "500Rnd_TwinVickers";
			_vehicle addmagazine "500Rnd_TwinVickers";
		};
		case "L39":{
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			_vehicle removeweapon "GSh23L_L39";
			_vehicle removeweapon "57mmLauncher";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
		};
		case "Su34_civ":{
			if(not(_silent)) then { hint "De-Militarizing jet.....hold please...";};
			_vehicle removeweapon "CMFlareLauncher";
			_vehicle removeweapon "GSh301";
			_vehicle removeweapon "Ch29Launcher_Su34";
			_vehicle removeweapon "R73Launcher";
			_vehicle removeweapon "80mmLauncher";
			};
		case "L39_UN":{
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			
			_vehicle removeweapon "57mmLauncher";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
		};
		case "L39_TK_EP1": {
			if(not(_silent)) then { hint "Reconfiguring plane armament...";};
			
			_vehicle removeweapon "57mmLauncher";
			_vehicle addweapon "CMFlareLauncher";
			_vehicle addmagazine "60Rnd_CMFlareMagazine";
		};
		case "BTR40_MG_TK_INS_EP1": {
			if(not(_silent)) then { hint "Reconfiguring vehicle armament...";};
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle removemagazine "50Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
			_vehicle addmagazine "150Rnd_127x107_DSHKM";
		};
		case "Ka137_MG_PMC": {
			if(not(_silent)) then { hint "Reconfiguring vehicle armament...";};
			_vehicle removemagazine "200Rnd_762x54_PKT";
			_vehicle removemagazine "200Rnd_762x54_PKT";
			_vehicle addmagazine "1500Rnd_762x54_PKT";
		};
	};
};


vehicle_save_storage = {
	/*
	private["_str"];
	_str =  format["vehicle_save_storage %1", _this];
	player groupChat _str;
	diag_log _str;
	*/
	
	private["_vehicle"];
	_vehicle = _this select 0;
	
	private["_storage_name"];
	_storage_name = [_vehicle] call vehicle_storage_name;
	
	if (_storage_name == "") exitWith {};
	private["_storage_variable"];
	_storage_variable = [_vehicle, _storage_name] call vehicle_get_array;
	
	/*
	private["_str"];
	_str =  format["vehicle_save_storage %1, %2, %3", _vehicle, _storage_name, _storage_variable];
	player groupChat _str;
	diag_log _str;
	*/
		
	[_vehicle, _storage_name, _storage_variable, false] call vehicle_set_array_checked;
};


vehicle_storage_name = {
	private["_vehicle"];
	_vehicle = _this select 0;
	if (not([_vehicle] call vehicle_exists)) exitWith {""};
	private["_vehicle_name"];
	_vehicle_name = vehicleVarName _vehicle;
	(format["%1_storage", _vehicle_name])
};

vehicle_set_init = {
	private["_vehicle", "_vehicle_name"];
	_vehicle = _this select 0;
	_vehicle_name = _this select 1;
	
	if (isNil "_vehicle") exitWith {};
	if (isNil "_vehicle_name") exitWith {};
	
	if (typeName _vehicle != "OBJECT") exitWith {};
	if (typeName _vehicle_name != "STRING") exitWith {};
	
	_vehicle setVehicleInit format['
		this setVehicleVarname "%1";
		%1 = this;
		clearWeaponCargo this;
		clearMagazineCargo this;
		this lock true;
		mounted_actions_init = if (isNil "mounted_actions_init") then { [] } else {mounted_actions_init};
		mounted_actions_init = mounted_actions_init + [%1];
		[%1] call mounted_add_actions;
	
		this addEventHandler ["GetIn", { _this spawn vehicle_GetIn_handler}];
		this addEventHandler ["GetOut", { _this spawn vehicle_GetOut_handler}];
	',_vehicle_name];
	processInitCommands;
};

vehicle_generate_name = {
	private["_restart_count"];
	_restart_count = server getVariable "restart_count";
	_vehicle setDir (getDir _logic);
	_vehicle_name = format["vehicle_%1_%2_%3", player, _restart_count, round(time)];
	_vehicle_name
};

vehicle_handle_mpkilled = { _this spawn {
	private["_unit", "_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
	[_unit, 60] call vehicle_despawn;
};};

vehicle_create = {
	private["_class", "_position", "_name", "_exact"];
	
	_class = _this select 0;
	_position = _this select 1;
	_exact = _this select 2;
	
	if (isNil "_class") exitWith {};
	if (isNil "_position") exitWith {};
	if (isNil "_exact") exitWith {};
	
	if (typeName _class != "STRING") exitWith {};
	if (typeName _position != "ARRAY") exitWith {};
	if (typeName _exact != "BOOL") exitWith {};
	
	
	private["_vehicle"];
	_vehicle = createVehicle [_class, _position, [], 0, "NONE"];
	if (_exact) then {
		_vehicle setPosATL _position;
	};
	
	_vehicle addEventHandler ["fired", {_this execVM "Awesome\EH\EH_fired_vehicle.sqf"}];
	_vehicle addMPEventhandler ["MPKilled", {_this call vehicle_handle_mpkilled}];
	
	_vehicle setVariable ["isPlayerVehicle", true, true];
	[player, _vehicle] call vehicle_add;
	
	_vehicle
};


vehicle_recreate = {
	//player groupChat format["Recreating _this = %1", _this];
	private["_name", "_class"];
	_name = _this select 0;
	_class = _this select 1;
	
	if (isNil "_name") exitWith {};
	if (typeName _name != "STRING") exitWith {nil};
	if (isNil "_class") exitWith {};
	if (typeName _class != "STRING") exitWith {nil};
	
	private["_vehicle"];
	private["_vehicle"];
	_vehicle = missionNamespace getVariable _name;
	if (not(isNil "_vehicle")) exitWith {_vehicle};
	if (not(isNil "_vehicle")) exitWith {_vehicle};
	
	private["_data"];
	//player groupChat format["Recreating _name = %1", _name];
	_data = [_name] call stats_load_request_send;
	_vehicle = [_class, [0,0,0], false] call vehicle_create;
	[_vehicle, _name] call vehicle_set_init;	
	[_data, _vehicle] call stats_compile_sequential;
	sleep 1;
	[_vehicle] call vehicle_init_stats;
	private["_item_name"];
	_item_name = [_vehicle, "item_name"] call vehicle_get_string;
	[_vehicle, _item_name, true] call vehicle_set_modifications;
	(_vehicle)
};


vehicle_create_shop_extended = {
	//player groupChat format["vehicle_create_shop_extended %1", _this];
	private["_logic", "_class", "_item", "_exact"];
	_logic = _this select 0;
	_class = _this select 1;
	_item = _this select 2;
	_exact = _this select 3;
	
	private["_vehicle_name", "_position"];
	_vehicle_name = call vehicle_generate_name;
	_position = getPosATL _logic;
	
	private["_vehicle"];
	_vehicle = [_class, _position, _exact] call vehicle_create;
	
	if (not(isNil "_vehicle")) then {
		_vehicle setDir (getDir _logic);
	};
	
	//player groupChat format["_vehicle_name = %1,  _vehicle = %2", _vehicle_name, _vehicle];
	[_vehicle, _vehicle_name] call vehicle_set_init;
	[_vehicle, _item, false] call vehicle_set_modifications;
	(_vehicle)
};


vehicle_create_shop = {
	private["_logic", "_class", "_item"];
	_logic = _this select 0;
	_class = _this select 1;
	_item = _this select 2;
	
	([_logic, _class, _item, not(isPlayer _logic)] call vehicle_create_shop_extended)
};




vehicle_exists = {
	private["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {false};
	if (typeName _vehicle != "OBJECT") exitWith {false};
	true
};


vehicle_gear_weapons_cargo = 0;
vehicle_gear_magazines_cargo = 1;

vehicle_get_gear = {
	private["_vehicle"]; 
	_vehicle = _this select 0;
	if (not([_vehicle] call vehicle_exists)) exitWith {nil};
	
	private["_weapons_cargo", "_magazines_cargo"];
	_weapons_cargo = getWeaponCargo _vehicle;
	_magazines_cargo = getMagazineCargo  _vehicle;

	private["_gear"];
	_gear = [];
	_gear set [vehicle_gear_weapons_cargo, _weapons_cargo];
	_gear set [vehicle_gear_magazines_cargo, _magazines_cargo];
	_gear
};


vehicle_set_gear = {
	//player groupChat format["vehicle_set_gear %1", _this];
	private["_vehicle", "_gear"];
	_vehicle = _this select 0;
	_gear = _this select 1;
	if (not([_vehicle] call vehicle_exists)) exitWith {};
	if (isNil "_gear") exitWith {};
	if (typeName _gear != "ARRAY") exitWith {};
	
	private["_weapons_cargo", "_magazines_cargo"];	
	
	_weapons_cargo = _gear select vehicle_gear_weapons_cargo;
	_magazines_cargo = _gear select vehicle_gear_magazines_cargo;
	
	if (isNil "_weapons_cargo") exitWith {};
	if (isNil "_magazines_cargo") exitWith {};

	if (typeName _weapons_cargo != "ARRAY") exitWith {};
	if (typename _magazines_cargo != "ARRAY") exitWith {};

	
	private["_cargo_weapons_class", "_cargo_weapons_count", "_cargo_magazines_class", "_cargo_magazines_count"];
	_cargo_weapons_class  = _weapons_cargo select 0;
	_cargo_weapons_count	= _weapons_cargo select 1;
	_cargo_magazines_class = _magazines_cargo select 0;
	_cargo_magazines_count= _magazines_cargo select 1;
		
	private["_i"];
	
	_i = 0;
	while { _i < (count _cargo_weapons_class) } do {
		private["_weapon_class", "_weapon_count"];
		_weapon_class = _cargo_weapons_class select _i;
		_weapon_count = _cargo_weapons_count select _i;
		_vehicle addWeaponCargoGlobal [_weapon_class, _weapon_count];
		_i = _i + 1;
	};
		
	_i = 0;
	while { _i < (count _cargo_magazines_class) } do { 
		private["_magazine_class", "_magazine_count"];
		_magazine_class = _cargo_magazines_class select _i;
		_magazine_count = _cargo_magazines_count select _i;
		_vehicle addMagazineCargoGlobal [_magazine_class, _magazine_count];
		_i = _i + 1;
	};
};

vehicle_reset_gear = {
	//player groupChat format["vehicle_reset_gear %1", _this];
	private["_vehicle"];
	_vehicle = _this select 0;
	if (not([_vehicle] call vehicle_exists)) exitWith {};
	
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
};

vehicle_unflip = {
	_vcl = (nearestobjects [getpos player, ["LandVehicle"], 10] select 0);
	//if (_vcl == "") exitwith {player groupchat "No vehicles in range";};
	if (([player, _vcl] call vehicle_owner)) then {
		if ((count crew _vcl) > 0) exitWith {player groupChat "The vehicle is not empty!";};

		player groupChat "Turning your vehicle over, wait 10 seconds within 10meters.";
		sleep 10;

		if (player distance _vcl <= 10) then {
			_vcl setPosATL [ (getPosATL _vcl select 0), (getPosATL _vcl select 1), (getPosATL _vcl select 2) + 2];;
			format['%1 setvectorup [0.001,0.001,1];', _vcl] call broadcast;
			player groupchat "Your vehicle has been reset";
		} 
		else {
			player groupchat "Try again, stay within 10m";
		};
	}
	else {
		player groupchat "You need the keys to unflip a vehicle";
	};
};

vehicle_lockpick = {
	private["_incarpark"];
	_incarpark = false;

	_vehicle  = [10] call INV_LocateClosestVehicle;
			
	if (isNil "_vehicle") exitWith {
		player groupChat "No vehicle close enough";
	};
			
	if (([player, _vehicle] call vehicle_owner)) exitWith {	
		player groupChat "You already own this vehicle.";
	};
	player groupChat format["lockpicking %1", _vehicle];

	format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;

	{
		if (_vehicle in (list _x)) then {
			_incarpark = true;
		};
	} forEach INV_VehicleGaragen;	

	private["_near_cops", "_near_civilians"];
	_near_cops = [player, 40] call player_near_cops;
	_near_civilians = [player, 40] call player_near_civilians;
		
	if ((random 100) < lockpickchance) then {
		[player, _vehicle] call vehicle_add;
		player groupChat localize "STRS_inventar_lockpick_success";		
		
		if ((_near_cops || _near_civilians || _incarpark) && not(iscop or isopf)) then {
			private["_message"];
			_message =  format["%1 was seen stealing a vehicle (registration plate: %2)!", player, _vehicle];
			format['hint (toString(%1));', toArray(_message)] call broadcast;
			[player, "vehicle theft", 10000] call player_update_warrants;
		};
	}
	else {																																						
		player groupChat localize "STRS_inventar_lockpick_noluck";
		
		if ((_near_cops || _near_civilians || _incarpark) && not(iscop or isopf)) then { 
			[player, "attempted vehicle theft", 2000] call player_update_warrants;
			private["_message"];
			_message = format["%1 was seen attempting to lockpick a vehicle (Registration plate: %2)", player, _vehicle];
			format['hint (toString(%1));', toArray(_message)] call broadcast;
		};			
	};
};

vehicle_owner = {
	private["_player", "_vehicle"];
	_player = _this select 0;
	_vehicle = _this select 1;
	if (not([_player] call player_human)) exitWith{false};
	if (not([_vehicle] call vehicle_exists)) exitWith {false};
	
	private["_vehicles"];
	_vehicles = [player] call vehicle_list;
	(_vehicle in _vehicles)

};



vehicle_is_player_owner = {
	private["_vehicle"];
	
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {false};
	if (typeName _vehicle != "OBJECT") exitWith {false};
	
	private["_vehicles"];
	_vehicles = [player] call vehicle_list;
	(_vehicle in _vehicles)
};

vehicle_build_string_array = {
	private["_vehicles", "_vehicles_string_array"];
	
	_vehicles = [player] call vehicle_list;
	_vehicles_string_array = [];
	
	{
		if (true) then {
			private["_vehicle"];
			_vehicle = _x;
			if (isNil "_vehicle") exitWith {};
			if (typeName _vehicle != "OBJECT") exitWith{};
			if (isNull _vehicle) exitWith {};
			if (not(alive _vehicle)) exitWith {};
			private["_vehicle_name"];
			_vehicle_name = vehicleVarName _vehicle;
			if (isNil "_vehicle_name") exitWith{};
			if (typeName "_vehicle_name" != "STRING") exitWith{};
			
			_vehicles_string_array = _vehicles_string_array + [_vehicle_name];
		};
	} foreach _vehicles;
	
	_vehicles_string_array
};


vehicle_save = {
	private["_vehicles_string_array"];
	_vehicles_string_array = call vehicle_build_string_array;
	["vehicles_name_list", _vehicles_string_array] spawn stats_client_save;
};

//initializes the player's list of owned vehicles from the stats list of vehicle names (strings)
vehicle_load = {
	if (not(isClient)) exitWith {};
	
	private["_player"];
	_player = player;
	
	[_player, "vehicles_list"] call stats_update_variables_list;
	["vehicles_name_list", []] call stats_init_variable;

	private["_vehicle_names"];
	_vehicle_names = vehicles_name_list;
	if (isNil "_vehicle_names") exitWith {};
	if (typeName _vehicle_names != "ARRAY") exitWith {};
	private["_vehicle", "_vehicle_name"];
	{
		_vehicle_name = _x;
		_vehicle = missionNamespace getVariable _vehicle_name;
		if (isNil "_vehicle") exitWith {};
		[_player, _vehicle] call vehicle_add;
	} foreach _vehicle_names;
		
	
};

vehicle_add = {
	private["_player", "_vehicle"];
	_player = _this select 0;
	_vehicle = _this select 1;		
	if (not([_player] call player_human)) exitWith {false};
	if (not([_vehicle] call vehicle_exists)) exitWith {false};	
	private["_vehicles"];
	_vehicles  = [_player] call vehicle_list;
	if (_vehicle in _vehicles) exitWith {};
	_vehicles = _vehicles - [objNull];
	_vehicles = _vehicles + [_vehicle];
	_player setVariable ["vehicles_list", _vehicles, true];
	call vehicle_save;
};

vehicle_remove = {
	private["_player", "_vehicle"];
	_player = _this select 0;
	_vehicle = _this select 1;
	if (not([_player] call player_human)) exitWith {false};
	if (not([_vehicle] call vehicle_exists)) exitWith {false};
	
	
	private["_vehicles"];
	_vehicles  = [_player] call vehicle_list;
	_vehicles = _vehicles - [objNull];
	_vehicles = _vehicles - [_vehicle];
	_player setVariable ["vehicles_list", _vehicles, true];
	
	call vehicle_save;
};

vehicle_list = {
	private["_player", "_vehicles"];
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {[]};
	
	_vehicles =  _player getVariable "vehicles_list";
	_vehicles = if (isNil "_vehicles") then {[]} else {_vehicles};
	_vehicles = if (typeName _vehicles != "ARRAY") then {[]} else {_vehicles};
	_vehicles
};


call vehicle_load;
call vehicle_save_gear_setup;
vehicle_functions_defined = true;