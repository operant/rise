#include "macro.h"

if (not(isNil "player_functions_defined")) exitWith {};

player_exists = {
	private["_player"];
	_player = _this select 0;
	if (isNil "_player") exitWith {false};
	if (typeName _player != "OBJECT") exitWith {false};
	if (isNull _player) exitWith {false};
	true
};

player_human = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith { false};
	(isPlayer _player)
};

player_human_side = {
	private["_player"];
	_player = _this select 0;
	([_player] call stats_human_side)
};

player_ai_side = {
	private ["_player"];
	_player = _this select 0;
	if (isNil "_player") exitWith {sideUnknown};
	if (typeName _player != "OBJECT") exitWith {sideUnknown};
	if (isNull _player) exitWith {sideUnknown};
	
	(side _player)
};

player_side = {
	private["_player"];
	_player = _this select 0;
	if ([_player] call player_human) exitWith {
		([_player] call player_human_side)
	};
	([_player] call player_ai_side)
};

player_civilian = {
	private["_player"];
	_player = _this select 0;
	(([_player] call player_side) == civilian)
};

player_opfor = {
	private["_player"];
	_player = _this select 0;
	(([_player] call player_side) == east)
};

player_insurgent = {
	private["_player"];
	_player = _this select 0;
	(([_player] call player_side) == resistance)
};

player_cop = {
	private["_player"];
	_player = _this select 0;
	(([_player] call player_side) == west)
};

player_get_dead = {
	private["_player"];
	_player = _this select 0;
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	([_player, format["isdead_%1", _side]] call player_get_bool)
};

player_set_dead = {
	private["_player", "_dead"];
	_player = _this select 0;
	_dead = _this select 1;
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	[_player, format["isdead_%1", _side], _dead] call player_set_bool;
};

player_side_prefix = {
	private["_side"];
	_side = _this select 0;
	if (isNil "_side") exitWith {""};
	if (typeName _side != "SIDE") exitWith {""};
	
	if (_side == west) exitWith {"cop"};
	if (_side == east) exitWith {"opf"};
	if (_side == resistance) exitWith {"ins"};
	if (_side == civilian) exitWith {"civ"};
	""
};

player_prefix_side = {
	private["_prefix"];
	_prefix = _this select 0;
	if (isNil "_prefix") exitWith { sideUnknown };
	if (typeName _prefix != "STRING") exitWith {sideUnknown};
	
	_prefix = toLower(_prefix);
	if (_prefix == "cop") exitWith {west};
	if (_prefix == "opf") exitWith {east};
	if (_prefix == "civ") exitWith {civilian};
	if (_prefix == "ins") exitWith {resistance};
	
	sideUnknown
};

player_prone_states = [
	"amovppnemstpsnonwnondnon",
	"aidlppnemstpsnonwnondnon0s",
	"aidlppnemstpsnonwnondnon01",
	"aidlppnemstpsnonwnondnon02",
	"aidlppnemstpsnonwnondnon03",
	"amovppnemrunsnonwnondf",
	"amovppnemrunsnonwnondfl",
	"amovppnemrunsnonwnondl",
	"amovppnemrunsnonwnondbl",
	"amovppnemrunsnonwnondb",
	"amovppnemrunsnonwnondbr",
	"amovppnemrunsnonwnondr",
	"amovppnemrunsnonwnondfr",
	"amovppnemstpsnonwnondnon_turnl",
	"amovppnemstpsnonwnondnon_turnr",
	"awopppnemstpsgthwnondnon_end"
	];

player_vulnerale_states = [
	"amovpercmstpssurwnondnon", 
	"adthppnemstpsraswpstdnon_2", 
	"adthpercmstpslowwrfldnon_4", 
	"amovpercmwlkssurwnondf_forgoten", 
	"civillying01"
	];
	
player_vulnerale_states = player_vulnerale_states + player_prone_states;
player_vulnerable = {
	private ["_player"];
	_player = _this select 0;
	if (isNil "_player") exitWith { false };
	
	_state  = animationState _player;
	 
	if (_state in player_vulnerale_states) exitWith { true };

	private["_stunned", "_restrained"];
	_stunned = [_player, "isstunned"] call player_get_bool;
	_restrained = [_player, "restrained"] call player_get_bool;
	(_stunned || _restrained)
};


player_set_arrest = {
	private["_player", "_arrest"];
	_player = _this select 0;
	_arrest = _this select 1;
	
	if (isNil "_player") exitWith {};
	if (isNil "_arrest") exitWith {};
	
	if (typeName _arrest != "BOOL") exitWith {};
	
	private["_arrest_variable_name"];
	_arrest_variable_name = format["arrest"];

	_player setVariable [_arrest_variable_name, _arrest, true];
	[_player, _arrest_variable_name, _arrest] call stats_player_save;
};

player_get_arrest = {
	private["_player"];
	_player = _this select 0;
	
	if (isNil "_player") exitWith {};
	
	private["_arrest_variable_name"];
	_arrest_variable_name = format["arrest", _player];
	
	private["_arrest_variable"];
	_arrest_variable = _player getVariable _arrest_variable_name;
	_arrest_variable = if (isNil "_arrest_variable") then {false} else {_arrest_variable};
	_arrest_variable = if (typeName _arrest_variable != "BOOL") then {false} else {_arrest_variable};
	_arrest_variable
};



player_update_reason = {
	private["_player", "_reason"];
	_player = _this select 0;
	_reason = _this select 1;
	
	private["_reasons"];
	_reasons = [_player] call player_get_reason;
	
	if (_reason in _reasons) exitWith {};
	_reasons = _reasons + [_reason];
	[_player, _reasons] call player_set_reason;
};

player_set_reason = {
	private["_player", "_reason"];
	_player = _this select 0;
	_reason = _this select 1;

	if (isNil "_player") exitWith {};
	if (isNil "_reason") exitWith {};
	
	if (typeName _reason != "ARRAY") exitWith {};
	
	private["_reason_variable_name", "_reason_variable"];
	_reason_variable_name = format["warrants"];
	
	_player setVariable [_reason_variable_name, _reason, true];
	[_player, _reason_variable_name, _reason] call stats_player_save;
	
};

player_get_reason = {
	private["_player"];
	_player = _this select 0;
	

	if (isNil "_player") exitWith {};
	private["_reason_variable_name"];
	_reason_variable_name = format["warrants", _player];
	
	private["_reason_variable"];
	_reason_variable = _player getVariable _reason_variable_name;
	_reason_variable = if (isNil "_reason_variable") then {[]} else {_reason_variable};
	_reason_variable = if (typeName _reason_variable != "ARRAY") then { [] } else { _reason_variable };
	_reason_variable
};

player_set_wanted = {
	private["_player", "_wanted"];
	_player = _this select 0;
	_wanted = _this select 1;
	
	if (isNil "_player") exitWith {};
	if (isNil "_wanted") exitWith {};
	
	if (typeName _wanted != "BOOL") exitWith {};

	private["_wanted_variable_name"];
	_wanted_variable_name = format["wanted"];

	_player setVariable [_wanted_variable_name, _wanted, true];
	[_player, _wanted_variable_name, _wanted] call stats_player_save;
};

player_get_wanted = {
	private["_player"];
	_player = _this select 0;
	
	if (isNil "_player") exitWith {};
	
	private["_wanted_variable_name"];
	_wanted_variable_name = format["wanted", _player];
	
	private["_wanted_variable"];
	_wanted_variable = _player getVariable _wanted_variable_name;
	_wanted_variable = if (isNil "_wanted_variable") then {false} else {_wanted_variable};
	_wanted_variable = if (typeName _wanted_variable != "BOOL") then {false} else {_wanted_variable};
	_wanted_variable
};


player_update_bounty = {
	private["_player", "_bounty"];
	_player = _this select 0;
	_bounty = _this select 1;
	
	private["_current_bounty"];
	
	_current_bounty = [_player] call player_get_bounty;
	private["_new_bounty"];
	_new_bounty = (_current_bounty + _bounty);
	_new_bounty = if (_new_bounty < 0) then {0} else {_new_bounty};

	[_player, _new_bounty] call player_set_bounty;
};

player_set_bounty = {
	private["_player", "_bounty"];
	_player = _this select 0;
	_bounty = _this select 1;
	
	if (isNil "_player") exitWith {};
    if (isNil "_bounty") exitWith {};
	
	if (typeName _bounty != "SCALAR") exitWith {};
	_bounty = if (_bounty < 0) then {0} else {_bounty};
	_bounty = round(_bounty);
	
	private["_bounty_variable_name"];
	_bounty_variable_name = format["bounty"];
	
	_player setVariable [_bounty_variable_name, _bounty, true];
	[_player, _bounty_variable_name, _bounty] call stats_player_save;
};


player_get_bounty = {
	private["_player"];
	_player = _this select 0;

	if (isNil "_player") exitWith {};

	private["_bounty_variable_name"];
	_bounty_variable_name = format["bounty"];
	
	private["_bounty_variable"];
	_bounty_variable = _player getVariable _bounty_variable_name;
	_bounty_variable = if (isNil "_bounty_variable") then { 0 } else { _bounty_variable };
	_bounty_variable = if (typeName _bounty_variable != "SCALAR") then { 0 } else {_bounty_variable };
	_bounty_variable
};

player_update_warrants = {
	private["_player", "_reason", "_bounty"];
	_player = _this select 0;
	_reason = _this select 1;
	_bounty = _this select 2;
	
	[_player, true] call player_set_wanted;
	[_player, _reason] call player_update_reason;
	[_player, _bounty] call player_update_bounty;
};

player_reset_warrants = {
	private["_player"];
	_player = _this select 0;
	[_player, false] call player_set_wanted;
	[_player, 0] call player_set_bounty;
	[_player, []] call player_set_reason;
};

player_armed = {
	private["_player"];
	_player = _this select 0;
	([_player] call player_get_armed)
};

player_update_armed = {
	private["_player", "_armed"];
	_player = _this select 0;
	_armed = _this select 1;
	
	private["_carmed"];
	_carmed =[_player] call player_get_armed;
	if ( str(_carmed) == str(_armed)) exitWith {};
	//player groupChat format["_armed = %1", _armed];
	[_player, _armed] call player_set_armed;
};

player_get_armed = {
	private["_player"];
	_player = _this select 0;
	if (isNil "_player") exitWith {false};
	
	private["_armed"];
	_armed = _player getVariable "armed";
	_armed = if (isNil "_armed") then { false } else { _armed};
	_armed = if (typeName _armed != "BOOL") then {false} else {_armed};
	_armed
};

player_set_armed = {
	private["_player", "_armed"];
	_player = _this select 0;
	_armed = _this select 1;
	if (isNil "_player") exitWith {false};
	if (isNil "_armed") exitWith {false};
	if (typeName _armed != "BOOL") exitWith {false};
	
	_player setVariable ["armed", _armed, true];
};



player_update_scalar = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_scalar;
	[_player, _variable_name, (_current_value + _variable_value)] call player_set_scalar;
};

player_set_scalar = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};
    if (isNil "_variable_value") exitWith {};
	
	if (typeName _variable_name != "STRING") exitWith {};
	if (typeName _variable_value != "SCALAR") exitWith {};
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_scalar;
	if (_current_value == _variable_value) exitWith {};
	
	_player setVariable [_variable_name, _variable_value, true];
	[_player, _variable_name, _variable_value] call stats_player_save;
};

player_get_scalar = {
	private["_player", "_variable_name"];
	_player = _this select 0;
	_variable_name = _this select 1;

	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};

	private["_variable_value"];
	_variable_value = _player getVariable _variable_name;
	_variable_value = if (isNil "_variable_value") then { 0 } else { _variable_value };
	_variable_value = if (typeName _variable_value != "SCALAR") then { 0 } else {_variable_value };
	_variable_value
};


player_update_bool = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_bool;
	if (str(_current_value) == str(_variable_value)) exitWith {};
	[_player, _variable_name, _variable_value] call player_set_bool;
};


player_set_bool = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};
    if (isNil "_variable_value") exitWith {};
	
	if (typeName _variable_name != "STRING") exitWith {};
	if (typeName _variable_value != "BOOL") exitWith {};
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_bool;
	if (str(_current_value) == str(_variable_value)) exitWith {};
	
	_player setVariable [_variable_name, _variable_value, true];
	[_player, _variable_name, _variable_value] call stats_player_save;
};

player_get_bool = {
	private["_player", "_variable_name"];
	_player = _this select 0;
	_variable_name = _this select 1;

	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};

	private["_variable_value"];
	_variable_value = _player getVariable _variable_name;
	_variable_value = if (isNil "_variable_value") then { false } else { _variable_value };
	_variable_value = if (typeName _variable_value != "BOOL") then { false } else {_variable_value };
	_variable_value
};


player_update_bail = {
	private["_player", "_bail"];
	_player = _this select 0;
	_bail = _this select 1;
	
	private["_current_bail"];
	
	_current_bail = [_player] call player_get_bail;
	private["_new_bail"];
	_new_bail = (_current_bail + _bail);
	_new_bail = if (_new_bail < 0) then {0} else {_new_bail};

	[_player, _new_bail] call player_set_bail;
};

player_set_bail = {
	private["_player", "_bail"];
	_player = _this select 0;
	_bail = _this select 1;
	
	if (isNil "_player") exitWith {};
    if (isNil "_bail") exitWith {};
	
	if (typeName _bail != "SCALAR") exitWith {};
	_bail = if (_bail < 0) then {0} else {_bail};
	_bail = round(_bail);
	
	private["_bail_variable_name"];
	_bail_variable_name = format["bail"];
	
	_player setVariable [_bail_variable_name, _bail, true];
	[_player, _bail_variable_name, _bail] call stats_player_save;
};


player_get_bail = {
	private["_player"];
	_player = _this select 0;

	if (isNil "_player") exitWith {};

	private["_bail_variable_name"];
	_bail_variable_name = format["bail"];
	
	private["_bail_variable"];
	_bail_variable = _player getVariable _bail_variable_name;
	_bail_variable = if (isNil "_bail_variable") then { 0 } else { _bail_variable };
	_bail_variable = if (typeName _bail_variable != "SCALAR") then { 0 } else {_bail_variable };
	_bail_variable
};



/*
player_pmc_whitelist = {
	private["_player"];
	_player = _this select 0;
	
	if (isNil "_player") exitWith {};
	
	private["_uid"];
	_uid = getPlayerUID _player;
	
	if (isNil "_uid") exitWith {false};
	if (typeName _uid != "STRING") exitWith {false};
	if (_uid == "") exitWith {false};
	
	((A_WBL_V_ACTIVE_PMC_1 == 1) && (_uid in pmcwhitelist))
};

player_pmc_blacklist = {
	private["_player"];
	_player = _this select 0;
	
	if (isNil "_player") exitWith {};
	
	private["_uid"];
	_uid = getPlayerUID _player;
	
	if (isNil "_uid") exitWith {false};
	if (typeName _uid != "STRING") exitWith {false};
	if (_uid == "") exitWith {false};
	
	((A_WBL_V_ACTIVE_PMC_1 == 2) && (_uid in pmcblacklist))
};
*/

player_rob_station = {
	private["_player", "_station"];
	
	_player = _this select 0;
	_station = _this select 1;
	
	if (isNil "_player") exitWith {};
	if (isNil "_station") exitWith {};
	if (typeName _station != "SCALAR") exitWith {};
	
	if (not([_player] call player_armed)) exitwith {
		player groupchat "You need a gun to rob the station!";
	};
	
	private["_money_variable_name", "_money_variable"];
	_money_variable_name = format["station%1money", _station];
	_money_variable = missionNamespace getVariable _money_variable_name;
	
	[_player, "Robbed a gas station", wantedamountforrobbing] call player_update_warrants;
	format ['server globalChat "Someone robbed gas station %1!";', _station] call broadcast;
	
	[_player, 'money', _money_variable] call INV_AddInventoryItem;
	player sidechat format ["You stole $%1 from the gas station!", _money_variable];
	
	_money_variable = 0;
	missionNamespace setVariable [_money_variable_name, _money_variable];
	publicVariable _money_variable_name;
};

player_prison_time = {
	private["_player", "_minutes"];
	_player = _this select 0;
	_minutes = _this select 1;
	
	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	
	if (isNil "_minutes") exitWith {};
	if (typeName _minutes != "SCALAR") exitWith {};
	if (_minutes <= 0) exitWith {};

	private["_seconds"];
	_seconds = round(_minutes) * 60;
	[_player, "jailtimeleft", _seconds] call player_set_scalar;
	private["_message"];
	_message = format["%1-%2 was sent to prison for %3 minutes", _player, (name _player), strM(round(_seconds/60))];
	format['server globalChat toString(%1);', toArray(_message)] call broadcast;
	_seconds
};

player_prison_bail = {
	private["_player", "_percent"];
	_player = _this select 0;
	_percent = _this select 1;
	
	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	
	if (isNil "_percent") exitWith {};
	if (typeName _percent != "SCALAR") exitWith {};
	if (_percent <= 0) exitWith {};
	
	_percent = _percent / 100;
	
	private["_bail", "_money"];
	_money =  [_player] call player_get_total_money;
	_bail = round(_percent * _money);
	_bail = if (_bail <= 0) then { 100000 } else { _bail };
	[_player, _bail] call player_set_bail;
	private["_message"];
	_message = format["%1-%2 has a bail set at $%3", _player, (name _player), strM(_bail)];
	format['server globalChat toString(%1);', toArray(_message)] call broadcast;
	_bail
};

player_prison_strip = {
	private["_player"];
	_player = _this select 0;

	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	if (not([_player] call player_human)) exitWith {};
	
	//remove stolen cash, and illlal items
	[_player] call INV_RemoveIllegal;
	if (stolencash > 0) then {
		[_player, stolencash] call player_lose_money;
		private["_message"];
		_message = format["%1-%2 was a bank robber, and has been charded $%3!", _player, (name _player), stolencash];
		format['server globalChat toString(%1);', toArray(_message)] call broadcast;
	};
	stolencash = 0;
};

player_prison_reset = {
	private["_player"];
	_player = _this select 0;
	[_player, false] call player_set_arrest;
	[_player, "jailtimeleft", 0] call player_set_scalar;
	[_player, 0] call player_set_bail;
	[_player] call player_reset_warrants;
};

player_prison_release = {
	private["_player"];
	_player = _this select 0;
	_player setPosATL getMarkerPos "jail_freemarker";	
	_player setdamage 0; 
};
player_prison_release_opf = {
	private["_player"];
	_player = _this select 0;
	_player setPosATL getMarkerPos "jail_freemarker_opf";	
	_player setdamage 0; 
};
player_prison_loop_opf = { _this spawn {
	private["_player", "_time_left", "_bail_left"];
	_player = _this select 0;
	_time_left = _this select 1;
	_bail_left = _this select 2;

	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	if (not([_player] call player_human)) exitWith {};
	
	if (isNil "_time_left") exitWith {};
	if (typeName _time_left != "SCALAR") exitWith {};
	
	if (isNil "_bail_left") exitWith {};
	if (typeName _bail_left != "SCALAR") exitWith {};


	private["_player_name", "_time_original"];
	_player_name = (name _player);
	_time_original = _time_left;
	
	//move player to prison
	_player setPos (getMarkerPos "prisonspawn_opf");
	_player setDamage 0;
	
	//mark as arrested and clear warrants
	[_player] call player_reset_warrants;
	[_player, true] call player_set_arrest;
	[_player, "restrained", false] call player_set_bool;
	[_player, "stunned", false] call player_set_bool;
	
	
	while {_time_left >= 0 && _bail_left >= 0} do {
		_bail_left = floor(((_time_left/_time_original)) * ([_player] call player_get_bail));
		
		//only update the time and bail left every 30 seconds to avoid spamming the stats
		if ((_time_left % 30) == 0) then {
			[_player, _bail_left] call player_set_bail;
			[_player, "jailtimeleft", _time_left] call player_set_scalar;
		};
		
		hintsilent format["Time until release\n%1 seconds\nBail left to pay\n$%2", _time_left, strM(_bail_left)];
		//PLAYER DISAPPEARED ...
		if (isNull(_player)) exitWith { 
			private["_message"];
			_message = format["%1 has pulled a ninja escape from prison >_< !", _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
		};
		
		//PLAYER DIED
		if (not(alive _player)) exitWith {
			private["_message"];
			_message = format["%1-%2 has died while in prison",_player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player, "jailtimeleft", _time_left] call player_set_scalar;
			[_player, _bail_left] call player_set_bail;
			[_player, true] call player_set_arrest;
		};
		
		//PLAYER HAS BEEN SET FREE
		if (not([_player] call player_get_arrest)) exitWith {
			/*
			private["_message"];
			_message = format["%1-%2 has been set free by the authorities", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			*/
			[_player] call player_prison_reset;
			[_player] call player_prison_release_opf;
		};
		
		//PLAYER HAS ESCAPED PRISON
		if ((player distance prison_logic_opf) >= 100) exitWith {
			private["_message"];
			_message = format["%1-%2 has pulled a daring escape from prison >_< !", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player, false] call player_set_arrest;
			[_player, "jailtimeleft", 0] call player_set_scalar;
			[_player, 0] call player_set_bail;
			[_player, "(prison-break)", 20000] call player_update_warrants;
		};
		
		//PLAYER HAS SERVED HIS FULL SENTNECE
		if (_time_left <= 0 ) exitWith {
			private["_message"];
			_message = format["%1-%2 has been released from prison, after serving a %3 minute/s sentence", _player, _player_name, round(_time_original/60)];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player] call player_prison_reset;
			[_player] call player_prison_release_opf;
		};
		
		//PLAYER HAS PAID THE FULL BAIL
		if (_bail_left <= 0 && _time_left > 0 ) exitWith {
			private["_message"];
			_message = format["%1-%2 has been relased from prison, after paying bail", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player] call player_prison_reset;
			[_player] call player_prison_release_opf;
		};
		
		_time_left  = _time_left - 1;
		sleep 1;
	};
};};

player_prison_loop = { _this spawn {
	private["_player", "_time_left", "_bail_left"];
	_player = _this select 0;
	_time_left = _this select 1;
	_bail_left = _this select 2;

	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	if (not([_player] call player_human)) exitWith {};
	
	if (isNil "_time_left") exitWith {};
	if (typeName _time_left != "SCALAR") exitWith {};
	
	if (isNil "_bail_left") exitWith {};
	if (typeName _bail_left != "SCALAR") exitWith {};


	private["_player_name", "_time_original"];
	_player_name = (name _player);
	_time_original = _time_left;
	
	//move player to prison
	_player setPos (getMarkerPos "prisonspawn");
	_player setDamage 0;
	
	//mark as arrested and clear warrants
	[_player] call player_reset_warrants;
	[_player, true] call player_set_arrest;
	[_player, "restrained", false] call player_set_bool;
	[_player, "stunned", false] call player_set_bool;
	
	
	while {_time_left >= 0 && _bail_left >= 0} do {
		_bail_left = floor(((_time_left/_time_original)) * ([_player] call player_get_bail));
		
		//only update the time and bail left every 30 seconds to avoid spamming the stats
		if ((_time_left % 30) == 0) then {
			[_player, _bail_left] call player_set_bail;
			[_player, "jailtimeleft", _time_left] call player_set_scalar;
		};
		
		hintsilent format["Time until release\n%1 seconds\nBail left to pay\n$%2", _time_left, strM(_bail_left)];
		//PLAYER DISAPPEARED ...
		if (isNull(_player)) exitWith { 
			private["_message"];
			_message = format["%1 has pulled a ninja escape from prison >_< !", _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
		};
		
		//PLAYER DIED
		if (not(alive _player)) exitWith {
			private["_message"];
			_message = format["%1-%2 has died while in prison",_player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player, "jailtimeleft", _time_left] call player_set_scalar;
			[_player, _bail_left] call player_set_bail;
			[_player, true] call player_set_arrest;
		};
		
		//PLAYER HAS BEEN SET FREE
		if (not([_player] call player_get_arrest)) exitWith {
			/*
			private["_message"];
			_message = format["%1-%2 has been set free by the authorities", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			*/
			[_player] call player_prison_reset;
			[_player] call player_prison_release;
		};
		
		//PLAYER HAS ESCAPED PRISON
		if ((player distance prison_logic) >= 100) exitWith {
			private["_message"];
			_message = format["%1-%2 has pulled a daring escape from prison >_< !", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player, false] call player_set_arrest;
			[_player, "jailtimeleft", 0] call player_set_scalar;
			[_player, 0] call player_set_bail;
			[_player, "(prison-break)", 20000] call player_update_warrants;
		};
		
		//PLAYER HAS SERVED HIS FULL SENTNECE
		if (_time_left <= 0 ) exitWith {
			private["_message"];
			_message = format["%1-%2 has been released from prison, after serving a %3 minute/s sentence", _player, _player_name, round(_time_original/60)];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player] call player_prison_reset;
			[_player] call player_prison_release;
		};
		
		//PLAYER HAS PAID THE FULL BAIL
		if (_bail_left <= 0 && _time_left > 0 ) exitWith {
			private["_message"];
			_message = format["%1-%2 has been relased from prison, after paying bail", _player, _player_name];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			[_player] call player_prison_reset;
			[_player] call player_prison_release;
		};
		
		_time_left  = _time_left - 1;
		sleep 1;
	};
};};


player_prison_convict = {
	private["_player"];
	_player = _this select 0;

	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	if (not([_player] call player_human)) exitWith {};

	private["_time_left", "_bail_left"];
	_time_left = round([_player, "jailtimeleft"] call player_get_scalar);
	_bail_left = [_player] call player_get_bail;
	if (not(_time_left > 0 && _bail_left > 0)) exitWith {};
	
	[_player] call player_prison_strip;
	[_player, _time_left, _bail_left] call player_prison_loop;
};
player_prison_convict_opf = {
	private["_player"];
	_player = _this select 0;

	if (isNil "_player") exitWith {};
	if (_player != player) exitWith {};
	if (not([_player] call player_human)) exitWith {};

	private["_time_left", "_bail_left"];
	_time_left = round([_player, "jailtimeleft"] call player_get_scalar);
	_bail_left = [_player] call player_get_bail;
	if (not(_time_left > 0 && _bail_left > 0)) exitWith {};
	
	[_player] call player_prison_strip;
	[_player, _time_left, _bail_left] call player_prison_loop_opf;
};

player_near_cops = {
	private["_player", "_distance"];
	_player = _this select 0;
	_distance = _this select 1;
	(([_player, west, _distance] call player_near_side_count) > 0)
};
player_near_opf = {
	private["_player", "_distance"];
	_player = _this select 0;
	_distance = _this select 1;
	(([_player, east, _distance] call player_near_side_count) > 0)
};

player_near_civilians = {
	private["_player", "_distance"];
	_player = _this select 0;
	_distance = _this select 1;
	(([_player, civilian, _distance] call player_near_side_count) > 0)
};

player_near_side_count = {
	private["_player", "_side", "_distance"];
	
	_player = _this select 0;
	_side = _this select 1;
	_distance = _this select 2;
	
	(count ([_player, _side, _distance] call player_near_side))
};

player_near_side = {
	private["_player", "_side", "_distance"];
	
	_player = _this select 0;
	_side = _this select 1;
	_distance = _this select 2;
	
	if (not([_player] call player_human)) exitWith {0};
	
	if (isNil "_side") exitWith {0};
	if (typeName _side != "SIDE") exitWith {0};
	if (isNil "_distance") exitWith {0};
	if (typeName _distance != "SCALAR") exitWith {0};

	
	private["_near_side_players"];
	_near_side_players = [];
	{
		private["_cplayer", "_cside"];
		_cplayer = _x;
		_cside = ([_cplayer] call player_side); 
		if (([_cplayer] call player_human) && _cside == _side) then {
			if (not(_cplayer == _player)) then {
				_near_side_players = _near_side_players + [_cplayer];
			};
		};
	} 
	forEach (nearestobjects[(getpos _player), ["Man"], _distance]);
	
	_near_side_players
};


players_object_near = {
	private["_object", "_distance"];
	
	_object = _this select 0;
	_distance = _this select 1;
	
	if (isNil "_object") exitWith {[]};
	if (isNil "_distance") exitWith {[]};
	if (typeName _object != "OBJECT") exitWith {[]};
	if (typeName _distance != "SCALAR") exitWith {[]};
	
	private["_near_players"];
	_near_players = [];
	{
		private["_player_variable_name", "_player_variable"];
		_player_variable_name = _x;
		_player_variable = missionNamespace getVariable _player_variable_name;
		if ([_player_variable] call player_human) then {
			if ((_player_variable distance _object) < _distance) then {
				_near_players = _near_players + [_player_variable];
			};
		};
	} forEach playerstringarray;
	
	_near_players
};


player_get_index = {
	private["_player"];
	_player = _this select 0;
	
	if (not([_player] call player_human)) exitWith {-1};
	
	private["_player_index"];
	
	_player_index = (playerstringarray find (str(_player)));
	_player_index
};

player_prison_roe = { _this spawn {
	//player groupChat format["roe prison _this = %1", _this];
	
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {};
	if (_player != player) exitWith {};
	
	private["_time_left"];
	_time_left = [_player, "roeprisontime"] call player_get_scalar;
	if (_time_left <= 0) exitWith {
		[_player, "roeprison", false] call player_set_bool;
	};
	
	private["_message"];
	_message = format["%1-%2 has been sent to prison for %3 minute/s, for ROE violations",  _player, (name _player), strN(round(_time_left/60))];
	format['server globalChat toString(%1);', toArray(_message)] call broadcast;
	
	[_player, "roeprison", true] call player_set_bool;
	_player setPos (getPos CopPrison);
	[_player] call player_reset_gear;
	
	private["_time_original"];
	_time_original = _time_left;
	
	while {_time_left >= 0} do {
		//only update the time left every 30 seconds to avoid spamming the stats
		if ((_time_left % 30) == 0) then {
			[_player, "roeprisontime", _time_left] call player_set_scalar;
		};
		
		hintsilent format["Time until release\n%1 seconds", _time_left];
		
		//PLAYER DISAPPEARED ...
		if (isNull(_player)) exitWith { 
			[_player, "roeprisontime", _time_left] call player_set_scalar;
		};
		
		//PLAYER DIED
		if (not(alive _player)) exitWith {
			[_player, "roeprisontime", _time_left] call player_set_scalar;
		};
		
		//PLAYER HAS ESCAPED PRISON
		if ((_player distance CopPrison) >= 100) then {
			private["_message"];
			_message = format["%1-%2 attempted to escape from prison with %3 minute/s left on his sentence", _player, (name _player), strN(round(_time_left/60))];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			_player setPos (getPos CopPrison);
		};
	
		//PLAYER HAS SERVED HIS FULL SENTNECE
		if (_time_left <= 0 ) exitWith {
			[_player, "roeprisontime", 0] call player_set_scalar;
			[_player, "roeprison", false] call player_set_bool;
			_message = format["%1-%2 has been set free, after serving %3 minute/s", _player, (name _player), strN(round(_time_original/60))];
			format['server globalChat toString(%1);', toArray(_message)] call broadcast;
			_player setPos (getPos CopPrisonAusgang);
		};
		
		_time_left  = _time_left - 1;
		sleep 1;
	};
};};

player_lookup_uid = {
	private["_uid"];
	_uid = _this select 0;
	
	if (isNil "_uid") exitWith {nil};
	if (typeName _uid != "STRING") exitWith {nil};
	
	private["_player"];
	_player = nil;
	{
		private["_player_variable_name", "_player_variable"];
		_player_variable_name = _x;
		_player_variable =  missionNamespace getVariable _player_variable_name;
		if ([_player_variable] call player_human) then {
			private["_cuid"];
			_cuid = (getPlayerUID _player_variable);
			if (_cuid == _uid) exitWith {
				_player = _player_variable;
			};
		};
		if (not(isNil "_player")) exitWith {};
	} forEach playerstringarray;
	
	_player
};


player_lookup_name = {
	private["_name"];
	_name = _this select 0;
	
	if (isNil "_name") exitWith {nil};
	if (typeName _name != "STRING") exitWith {nil};
	
	private["_player"];
	_player = nil;
	{
		private["_player_variable_name", "_player_variable"];
		_player_variable_name = _x;
		_player_variable =  missionNamespace getVariable _player_variable_name;
	
		if ([_player_variable] call player_exists) then {
			private["_cname"];
			_cname = _player_variable getVariable "name";
			if (_cname == _name) exitWith {
				_player = _player_variable;
			};
		};
		if (not(isNil "_player")) exitWith {};
	} forEach playerstringarray;
	_player
};




player_update_array = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_array;
	if (str(_current_value) == str(_variable_value)) exitWith {};
	[_player, _variable_name, _variable_value] call player_set_array;
};

player_get_array = {
	private["_player", "_variable_name"];
	_player = _this select 0;
	_variable_name = _this select 1;
	

	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};

	private["_variable_value"];
	_variable_value = _player getVariable _variable_name;
	_variable_value = if (isNil "_variable_value") then { [] } else { _variable_value };
	_variable_value = if (typeName _variable_value != "ARRAY") then { [] } else {_variable_value };
	_variable_value
};

player_set_array = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	[_player, _variable_name, _variable_value, true] call player_set_array_checked;
};

player_set_array_checked = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	_check_change = _this select 3;
	
	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};
    if (isNil "_variable_value") exitWith {};
	if (isNil "_check_change") exitWith {};
	
	if (typeName _variable_name != "STRING") exitWith {};
	if (typeName _variable_value != "ARRAY") exitWith {};
	if (typeName _check_change != "BOOL") exitWith {};
	
	private["_current_value"];
	
	if (_check_change) then {
		_current_value = [_player, _variable_name] call player_get_array;	
		if (str(_current_value) == str(_variable_value)) exitWith {};
	};
	
	_player setVariable [_variable_name, _variable_value, true];
	[_player, _variable_name, _variable_value] call stats_player_save;
};


player_update_string = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_string;
	if (str(_current_value) == str(_variable_value)) exitWith {};
	[_player, _variable_name, _variable_value] call player_set_string;
};


player_set_string = {
	private["_player", "_variable_name", "_variable_value"];
	_player = _this select 0;
	_variable_name = _this select 1;
	_variable_value = _this select 2;
	
	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};
    if (isNil "_variable_value") exitWith {};
	
	if (typeName _variable_name != "STRING") exitWith {};
	if (typeName _variable_value != "STRING") exitWith {};
	
	private["_current_value"];
	_current_value = [_player, _variable_name] call player_get_string;
	if (str(_current_value) == str(_variable_value)) exitWith {};
	
	_player setVariable [_variable_name, _variable_value, true];
	[_player, _variable_name, _variable_value] call stats_player_save;
};

player_get_string = {
	private["_player", "_variable_name"];
	_player = _this select 0;
	_variable_name = _this select 1;

	if (isNil "_player") exitWith {};
	if (isNil "_variable_name") exitWith {};

	private["_variable_value"];
	_variable_value = _player getVariable _variable_name;
	_variable_value = if (isNil "_variable_value") then { "" } else { _variable_value };
	_variable_value = if (typeName _variable_value != "STRING") then { "" } else {_variable_value };
	_variable_value
};


player_gear_weapons = 0;
player_gear_magazines = 1;
player_gear_backpack = 2;
player_gear_backpack_weapons = 3;
player_gear_backpack_magazines = 4;

player_get_gear = {
	private["_player"]; 
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {nil};
	
	private["_weapons", "_magazines", "_backpack", "_backpack_weapons", "_backpack_magazines", "_backpack_type"];
	_weapons = weapons _player;
	_magazines = magazines _player;
	_backpack = unitBackpack _player;
	_backpack_type = typeOf _backpack;
	if (_backpack_type == "") then {
		_backpack_type = "none";
		_backpack_weapons =  [];
		_backpack_magazines = [];
	}
	else {
		_backpack_weapons =  getWeaponCargo _backpack;
		_backpack_magazines = getMagazineCargo _backpack;
	};
	
	private["_gear"];
	_gear = [];
	_gear set [player_gear_weapons, _weapons];
	_gear set [player_gear_magazines, _magazines];
	_gear set [player_gear_backpack, _backpack_type];
	_gear set [player_gear_backpack_weapons, _backpack_weapons];
	_gear set [player_gear_backpack_magazines, _backpack_magazines];
	_gear
};


CopStartGear_Mags =
[
    "15Rnd_9x19_M9SD"
   
];

CopStartGear_Weap  = ["ItemGPS"];

player_set_gear = {
	//player groupChat format["player_set_gear %1", _this];
	
	private["_player", "_gear"];
	_player = _this select 0;
	_gear = _this select 1;
	if (not([_player] call player_exists)) exitWith {};
	if (isNil "_gear") exitWith {};
	if (typeName _gear != "ARRAY") exitWith {};
	
	private["_weapons", "_magazines", "_backpack", "_backpack_weapons", "_backpack_magazines"];	
	
	_weapons = _gear select player_gear_weapons;
	_magazines = _gear select player_gear_magazines;
	_backpack = _gear select player_gear_backpack;
	_backpack_weapons = _gear select player_gear_backpack_weapons;
	_backpack_magazines = _gear select player_gear_backpack_magazines;
	
	if (isNil "_weapons") exitWith {};
	if (isNil "_magazines") exitWith {};
	if (isNil "_backpack") exitWith {};
	if (isNil "_backpack_weapons") exitWith {};
	if (isNil "_backpack_magazines") exitWith {};
	
	if (typeName _weapons != "ARRAY") exitWith {};
	if (typename _magazines != "ARRAY") exitWith {};
	if (typeName _backpack != "STRING") exitWith {};
	if (typeName _backpack_weapons != "ARRAY") exitWith {};
	if (typeName _backpack_magazines != "ARRAY") exitWith {}; 
	
	
	if ((count _weapons) == 0 && (count _magazines) == 0 && ([_player] call player_cop)) then {
		_magazines = CopStartGear_Mags;
		_weapons = CopStartGear_Weap;
	};
	
	{_player addMagazine _x} forEach _magazines;
	{_player addWeapon _x} forEach _weapons;

	if (_backpack == "" || _backpack == "none") exitWith {};
	
	_player addBackpack _backpack;
	
	private["_pack"];
	_pack = unitBackpack _player;
		
	clearWeaponCargoGlobal _pack;
	clearMagazineCargoGlobal _pack;
	
	private["_pack_weapons_class", "_pack_weapons_count", "_pack_magazines_class", "_pack_magazines_count"];
	_pack_weapons_class  = _backpack_weapons select 0;
	_pack_weapons_count	= _backpack_weapons select 1;
	_pack_magazines_class = _backpack_magazines select 0;
	_pack_magazines_count= _backpack_magazines select 1;
		
	private["_i"];
	
	_i = 0;
	while { _i < (count _pack_weapons_class) } do {
		private["_weapon_class", "_weapon_count"];
		_weapon_class = _pack_weapons_class select _i;
		_weapon_count = _pack_weapons_count select _i;
		_pack addWeaponCargoGlobal [_weapon_class, _weapon_count];
		_i = _i + 1;
	};
		
	_i = 0;
	while { _i < (count _pack_magazines_class) } do { 
		private["_magazine_class", "_magazine_count"];
		_magazine_class = _pack_magazines_class select _i;
		_magazine_count = _pack_magazines_count select _i;
		_pack addMagazineCargoGlobal [_magazine_class, _magazine_count];
		_i = _i + 1;
	};
};

player_reset_gear = {
	//player groupChat format["player_reset_gear %1", _this];
	
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	removeAllWeapons _player;
	removeBackpack _player;
};


player_load_side_gear = {
	private["_player"];

	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {};

	[_player] call player_reset_gear;
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_weapons", "_magazines", "_backpack", "_backpack_weapons", "_backpack_magazines"];
	
	_weapons = [_player, format["weapons_%1", _side]] call player_get_array;
	_magazines = [_player, format["magazines_%1", _side]] call player_get_array;
	_backpack = [_player, format["backpack_%1", _side]] call player_get_string;
	_backpack_weapons = [_player, format["backpack_weapons_%1", _side]] call player_get_array;
	_backpack_magazines = [_player, format["backpack_magazines_%1", _side]] call player_get_array;
	
	private["_gear"];
	_gear = [];
	_gear set [player_gear_weapons, _weapons];
	_gear set [player_gear_magazines, _magazines];
	_gear set [player_gear_backpack, _backpack];
	_gear set [player_gear_backpack_weapons, _backpack_weapons];
	_gear set [player_gear_backpack_magazines, _backpack_magazines];
	
	[_player, _gear] call player_set_gear;
	
	private["_primary_weapon"];
	_primary_weapon = (primaryweapon player);
	
	if (_primary_weapon != "") then {
		player selectweapon _primary_weapon;
	};
	
	player action ["switchweapon", player, player, 0];
};


side_gear_request_receive = {
	//player groupChat format["side_gear_request_receive %1", _this];
	
	private["_variable", "_request"];
	_variable = _this select 0;
	_request = _this select 1;

	if (isNil "_request") exitWith {};
	if (typeName _request != "ARRAY") exitWith {};
	
	private["_player"]; 
	_player = _request select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_gear"];
	_gear = [_player] call player_get_gear;
	if (isNil "_gear") exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));

	private["_weapons", "_magazines", "_backpack", "_backpack_weapons", "_backpack_magazines"];
	_weapons = _gear select player_gear_weapons;
	_magazines = _gear select player_gear_magazines;
	_backpack = _gear select player_gear_backpack;
	_backpack_weapons = _gear select player_gear_backpack_weapons;
	_backpack_magazines = _gear select player_gear_backpack_magazines;
	
	[_player, format["weapons_%1", _side], _weapons] call player_set_array;
	[_player, format["magazines_%1", _side], _magazines] call player_set_array;
	[_player, format["backpack_%1", _side], _backpack] call player_set_string;
	[_player, format["backpack_weapons_%1", _side], _backpack_weapons] call player_set_array;
	[_player, format["backpack_magazines_%1", _side], _backpack_magazines] call player_set_array;
	
};

player_save_side_gear_setup = {
	if (not(isServer)) exitWith {};
	//player groupChat format["player_save_side_gear_setup %1", _this];
	side_gear_request_buffer =  " ";
	publicVariableServer "side_gear_request_buffer";
	"side_gear_request_buffer" addPublicVariableEventHandler { _this call side_gear_request_receive;};
};


player_save_side_gear = {
	private["_player"]; 
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};

	side_gear_request_buffer = [_player];
	if (isServer) then {
		["", side_gear_request_buffer] call side_gear_request_receive;
	}
	else {
		publicVariable "side_gear_request_buffer";
	};
};

player_save_side_position = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_position_atl", "_direction"];
	_position_atl = getPosATL _player;
	_direction = getDir _player;
	
	//diag_log format["player_save_side_position %1 %2", _position_atl, _direction];
	[_player, format["position_atl_%1", _side], _position_atl] call player_set_array;
	[_player, format["direction_%1", _side], _direction] call player_set_scalar;
};

player_load_side_position = {
	private["_player"];
	//player groupChat format["player_load_side_position %1", _this];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_position_atl", "_direction"];
	_position_atl = [_player, format["position_atl_%1", _side]] call player_get_array;
	_direction = [_player, format["direction_%1", _side]] call player_get_scalar;
	
	
	if (not((count _position_atl) == 3)) exitWith {};
	_player setPosATL _position_atl;
	_player setDir _direction;
};




player_save_side_damage = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_damage"];
	_damage = damage _player;
	//diag_log format["Saving damage %1", _damage];
	[_player, format["damage_%1", _side], _damage] call player_set_scalar;
};

player_load_side_damage = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_damage"];
	_damage = [_player, format["damage_%1", _side]] call player_get_scalar;
	
	if (_damage < 0 ||  _damage > 1) exitWith {};
	
	_player setDamage _damage;
};



player_load_side_vehicle = {
	//player groupChat format["player_load_side_vehicle %1", _this];
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {false};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_vehicle_name"];
	_vehicle_name = [_player, format["vehicle_driven_name_%1", _side]] call player_get_string;
	if (_vehicle_name == "") exitWith {false};
	
	private["_vehicle_class"];
	_vehicle_class = [_player, format["vehicle_driven_class_%1", _side]] call player_get_string;
	if (_vehicle_class == "") exitWith {false};
	
	//player groupChat format["_vehicle_name = %1, _vehicle_class = %2", _vehicle_name, _vehicle_class];
	
	private["_vehicle"];
	_vehicle = [_vehicle_name, _vehicle_class] call vehicle_recreate;
	if (isNil "_vehicle") exitWith {false};
	
	private["_active_driver_uid", "_saved_driver_uid", "_player_uid", "_distance"];
	_player_uid = [_player] call stats_get_uid;
	_saved_driver_uid = [_vehicle, "saved_driver_uid"] call vehicle_get_string;
	_active_driver_uid = [_vehicle, "active_driver_uid"] call vehicle_get_string;
	
	//player groupChat format["_player_uid = %1", _player_uid];
	//player groupChat format["_saved_driver_uid = %1", _saved_driver_uid];
	//player groupChat format["_active_driver_uid = %1", _active_driver_uid];
	
	if (not((_active_driver_uid in ["", _saved_driver_uid]) && (_saved_driver_uid == _player_uid))) exitWith {
		player groupChat "Your vehicle has been stolen, destroyed, or moved while you were away!";
		false
	};
	
	[_player, _vehicle, false] call player_enter_vehicle;
	[_player, _vehicle] call vehicle_add;
	//player groupChat format["Vehicle recreated!"];
	true
};

player_save_side_vehicle = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	
	private["_vehicle", "_driver", "_vehicle_name", "_vehicle_class"];
	_vehicle = (vehicle _player);
	_driver = driver _vehicle;
	_vehicle_name = "";
	_vehicle_class = "";
	
	if (not(_vehicle == _player) && driver(_vehicle) == _player) then {
		_vehicle_name = vehicleVarName _vehicle;
		_vehicle_class = typeOf _vehicle;
	};
	
	[_player, format["vehicle_driven_name_%1", _side], _vehicle_name] call player_set_string;
	[_player, format["vehicle_driven_class_%1", _side], _vehicle_class] call player_set_string;
};

player_save_side_inventory = {
	/*
	private["_str"];
	_str =  format["player_save_side_inventory %1", _this];
	player groupChat _str;
	diag_log _str;
	*/

	private["_player"];
	_player = _this select 0;
	
	private["_inventory_name"];
	_inventory_name = [_player] call player_inventory_name;
	_inventory = [_player] call player_get_inventory;

	//diag_log format["_inventory = %1", _inventory];
	[_player, _inventory_name, _inventory, false] call player_set_array_checked;
};


player_reset_side_inventory = {
	private["_player"];
	_player = _this select 0;
	
	private["_inventory_name"];
	_inventory_name = [_player] call player_inventory_name;
	if (_inventory_name == "") exitWith {};

	private["_empty_inventory"];
	_empty_inventory =
	[
		["keychain", ([1] call encode_number)], 
		["handy", ([1] call encode_number)]
	];
	
	_player setVariable [_inventory_name, _empty_inventory, true];
};

player_inventory_name = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {""};
	private["_player_name"];
	_player_name = vehicleVarName _player;
	private["_side"];
	_side = ([_player] call player_side);
	_side = toLower(str(_side));
	(format["inventory_%1", _side])
};


player_get_inventory = {
	private["_player"];
	_player = _this select 0;
	
	private["_inventory_name"];
	_inventory_name = [_player] call player_inventory_name;
	if (_inventory_name == "") exitWith {[]};
	
	private["_inventory"];
	_inventory = _player getVariable _inventory_name;
	(_inventory)
};

player_set_inventory = {
	private["_player", "_inventory"];
	_player = _this select 0;
	_inventory = _this select 1;
	
	if (isNil "_inventory") exitWith {};
	if (typeName _inventory != "ARRAY") exitWith {};
	
	private["_inventory_name"];
	_inventory_name = [_player] call player_inventory_name;
	if (_inventory_name == "") exitWith {};

	_player setVariable [_inventory_name, _inventory, true];
};


object_storage_name = {
	private["_object"];
	_object = _this select 0;
	if (isNil "_object") exitWith {""};
	if (typeName _object != "OBJECT") exitWith {""};
	
	if (_object isKindOf "Man") exitWith {
		([_object] call player_inventory_name)
	};
	
	([_object] call vehicle_storage_name)
};

player_exit_vehicle = {
	//player groupChat format["player_exit_vehicle %1", _this];
	private["_player", "_vehicle"];
	_player = _this select 0;
	_vehicle = _this select 1;
	_immediate = _this select 2;
	if (not([_player] call player_exists)) exitWith {};
	if (isNil "_vehicle") exitWith {};
	if (isNil "_immediate") exitWith {false};
	if (typeName _immediate != "BOOL") exitWith {false};
	
	_vehicle lock false;
	if (_immediate) then {
		moveOut _player;
	}
	else {
		private["_engine_state"];
		_engine_state =  isEngineOn _vehicle;
		_player action ["Eject", _vehicle];
		_vehicle engineOn _engine_state;
	};
	
	if (not(alive _player)) then {
		_player setPos [-1,-1,-1];
	};
};


player_enter_vehicle = { 
	//player groupChat format["player_enter_vehicle %1", _this];
	private["_player", "_vehicle", "_immediate"];
	_player = _this select 0;
	_vehicle = _this select 1;
	_immediate = _this select 2;
	if (not([_player] call player_exists)) exitWith {false};
	if (isNil "_vehicle") exitWith {false};
	if (isNil "_immediate") exitWith {false};
	if (typeName _immediate != "BOOL") exitWith {false};
	
	_vehicle lock false;
	private["_empty_driver", "_empty_gunner", "_empty_commander", "_empty_cargo"];
	_empty_driver = _vehicle emptyPositions "Driver";
	_empty_gunner = _vehicle emptyPositions "Gunner";
	_empty_commander = _vehicle emptyPositions "Commander";
	_empty_cargo = _vehicle emptyPositions "Cargo";
	

	if (_empty_driver > 0) exitWith {
		if (_immediate) then {
			_player moveInDriver _vehicle;
		}
		else {
			_player action ["getInDriver", _vehicle];
		};
		true
	};
		
	if (_empty_gunner > 0) exitWith {
		if (_immediate) then {
			_player moveInGunner _vehicle;
		}
		else {
			_player action ["getInGunner", _vehicle];
		};
		true
	};
		
	if (_empty_commander > 0) exitWith {
		if (_immediate) then {
			_player moveInCommander _vehicle;
		}
		else {
			_player action ["getInCommmander", _vehicle];
		};
		true
	};
		
	if (_empty_cargo > 0) exitWith { 
		if (_immediate) then {
			_player moveInCargo _vehicle;
		}
		else {
			_player action ["getInCargo", _vehicle];
		};
		true
	};
	
	false
};



player_rejoin_camera = {
	private["_delay"];
	_delay = _this select 0;
	if (isNil "_delay") exitWith {};
	if (typeName _delay != "SCALAR") exitWith {};
	
	private["_end_time"];
	_end_time = time + _delay;
	
	[_end_time] spawn player_rejoin_camera_text;
	[_end_time] spawn  player_rejoin_camera_movement;
};

player_rejoin_camera_text = {
	private["_deadTimeEnd"];
	_deadTimeEnd = _this select 0;
	
	while {time < _deadTimeEnd } do {
		private["_time_left"];
		_time_left = round(_deadTimeEnd - time);
		titletext [format["%1 seconds remaining", _time_left], "plain"];
		sleep 1;
	};
};

player_rejoin_camera_movement = {
	player_rejoin_camera_complete = false;
	private["_deadTimeEnd"];
	//INITIATE THE CAMERA
	_deadTimeEnd = _this select 0;
	_camera = "camera" camCreate [0,0,0];
	_camera cameraEffect ["Internal", "LEFT"];
	_camera camPreparePos [0,0,0];
	_camera camPrepareFOV 1;
	
	
	if (not(sunOrMoon > 0)) then {
		camUseNVG true;
	};
	
	_camera camCommitPrepared 0;
	waitUntil { camCommitted _camera };
	

	private["_deadcam_target_array"];
	_deadcam_target_array =
	[
		[17205.75,99198.17,-49454.65],
		[114238.47,12719.49,3040.26],
		[114238.47,12719.49,3040.28],
		[9396.48,-87407.76,-3495.99],
		[9396.48,-87407.76,-3495.72],
		[-85499.48,17145.94,-3497.86],
		[-81437.91,41177.12,-3500.26],
		[-68592.92,68496.92,-3504.91],
		[63894.18,99059.27,-3504.91],
		[57781.25,102312.13,-3505.24],
		[18155.12,112290.52,-3505.59],
		[114056.91,13559.94,-3506.64],
		[114056.91,13559.94,-3506.63],
		[12082.11,112377.59,-3507.94],
		[12082.11,112377.59,-3508.13],
		[12082.11,112377.59,-3507.88],
		[71475.13,94441.38,-3511.65],
		[79131.48,88521.11,-3512.17],
		[90116.62,77668.10,-3514.78],
		[93979.69,72896.55,-3515.45],
		[23989.44,112118.31,-3515.51],
		[111421.41,-10631.93,-3515.78],
		[111421.41,-10631.93,-3515.45],
		[111421.41,-10631.93,-3515.62],
		[-85207.23,22475.24,-3515.77],
		[-85269.09,22481.34,761.18],
		[-52542.68,-60176.11,-15820.92],
		[66335.50,-71098.57,-15831.98],
		[112733.68,9274.25,-15848.19],
		[112733.68,9274.25,-15848.03],
		[112733.68,9274.25,-15848.01],
		[112733.68,9274.25,-15848.28],
		[15793.38,-87445.16,-1975.57],
		[15793.38,-87445.16,-1975.58],
		[-85045.43,23679.19,-1976.55],
		[-2976.49,110953.34,-1977.04],
		[-2976.49,110953.34,-1976.94],
		[25975.48,-86795.57,-1977.29],
		[25975.48,-86795.57,-1977.28],
		[30152.87,-86219.98,-1977.49],
		[114191.58,8919.13,-1977.75],
		[114186.95,8335.76,-1978.02],
		[13212.45,-87514.59,-1978.28],
		[13212.45,-87514.59,-1978.39],
		[13328.19,-76559.05,-45508.50]
	];

	private["_deadcam_position_array"];
	_deadcam_position_array   =
	[
		[6573.78,2365.67,19.16],
		[6563.33,2409.16,3.60],
		[6598.98,2409.17,3.60],
		[6615.21,2406.75,2.60],
		[6616.97,2469.89,3.60],
		[6619.17,2455.47,4.36],
		[6650.88,2457.08,5.60],
		[6719.63,2400.90,6.92],
		[6712.46,2403.60,7.08],
		[6712.08,2419.00,8.08],
		[6727.18,2457.75,20.08],
		[6724.96,2465.48,15.08],
		[6764.31,2465.91,7.08],
		[6771.92,2463.60,20.08],
		[6771.38,2538.25,21.08],
		[6771.13,2550.88,22.08],
		[6769.29,2568.52,23.08],
		[6793.91,2598.42,24.08],
		[6825.21,2646.20,25.08],
		[6839.44,2658.20,25.08],
		[6869.00,2658.38,25.08],
		[6909.94,2668.50,25.35],
		[6942.29,2667.94,25.33],
		[6846.04,2627.05,20.37],
		[6827.04,2538.54,18.41],
		[6742.96,2468.32,18.69],
		[6769.18,2697.18,15.22],
		[6792.32,2615.79,10.43],
		[6679.88,2556.44,6.43],
		[6560.67,2516.16,6.43],
		[6588.56,2525.49,6.43],
		[6551.50,2521.79,6.43],
		[6606.49,2523.45,1.69],
		[6606.37,2476.85,1.69],
		[6602.42,2474.65,1.69],
		[6578.19,2474.97,1.69],
		[6574.55,2488.17,1.69],
		[6574.79,2497.03,1.69],
		[6573.99,2491.74,5.46],
		[6574.33,2490.64,4.93],
		[6574.66,2458.02,4.93],
		[6597.66,2457.95,4.93],
		[6599.95,2459.04,5.23],
		[6599.66,2459.05,18.31],
		[6575.55,2451.36,19.46]
	];

	private["_deadcam_kameraposition"];
	_deadcam_kameraposition   = round(random (count _deadcam_position_array - 1));
	
	_camera camSetPos (_deadcam_position_array select _deadcam_kameraposition);
	_camera camSetTarget (_deadcam_target_array select _deadcam_kameraposition);
	_camera camSetFOV 0.700;
	_camera camCommit 0;
	waitUntil {camCommitted _camera};

	
	//CYCLE THE CAMERA POSITIONS
	while {true} do {
		_deadcam_kameraposition = _deadcam_kameraposition + 1;
		if (count _deadcam_position_array <= _deadcam_kameraposition) then {
			_deadcam_kameraposition = 0;
		};
		
		private["_position", "_target"];

		_position = _deadcam_position_array select _deadcam_kameraposition;
		_target = _deadcam_target_array   select _deadcam_kameraposition;

		_camera camSetPos _position;
		_camera camSetTarget _target;
		_camera camSetFOV 0.7;
		_camera camCommit 5;
		waitUntil {(camCommitted _camera) or (time > _deadTimeEnd)};
		
		if (time > _deadTimeEnd) exitWith {};
	};

	//DESTROY THE CAMERA
	_camera cameraEffect ["terminate","back"];
	titleCut [" ","Black in"];
	camDestroy _camera;
	camUseNVG false;
	titlefadeout 0;
	0 cutfadeout 0;
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [6];
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 5;
	
	player_rejoin_camera_complete = true;
};


player_dead_camera_movement = {
	private["_player"];
	_player = _this select 0;
	
	if (not([_player] call player_exists)) exitWith {};
	
	private["_pos"];
	
	_pos = (getPosATL _player);
	_camera = "camera" camCreate [(_pos select 0), (_pos select 1), ((_pos select 2) + 3)];
	_camera camPrepareTarget player;
	_camera cameraEffect ["Internal", "LEFT"];
	_camera camPreparePos [(_pos select 0), (_pos select 1), ((_pos select 2) + 40)];
	_camera camPrepareFOV 1;
	
	if (not(sunOrMoon > 0)) then {
		camUseNVG true;
	};
	 
	_camera camCommitPrepared 10;
	waitUntil { camCommitted _camera };
	
	//DESTROY THE CAMERA
	_camera cameraEffect ["terminate","back"];
	titleCut [" ","Black in"];
	camDestroy _camera;
	camUseNVG false;
	titlefadeout 0;
	0 cutfadeout 0;
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [6];
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 5;
};

player_dead_camera_blackout_message = {
	private["_message"];
	private["_extraddeadtime", "_civskilled", "_copskilled", "_deadtimes"];
	
	_extradeadtime = [player, "extradeadtime"] call player_get_scalar;
	_selfkilled = [player, "selfkilled"] call player_get_scalar;
	_deadtimes = [player, "deadtimes"] call player_get_scalar;
	_message = format["You have now died %1 time(s) and suicided %2 time(s) and have to wait extra %3 seconds to respawn.", _deadtimes, _selfkilled, _extradeadtime];

	_message
};

player_dead_camera_blackin_message = {	
	private["_message"];
	_message = "";
	_message
};

player_dead_camera_text = {

	private["_blackOut_message"];
	
	_blackOut_message = call player_dead_camera_blackout_message;
	titleText [_blackOut_message, "BLACK OUT", 10];
	sleep 12;
	
	private["_blackIn_message"];
	_blackIn_message = call player_dead_camera_blackin_message;
	_blackIn_message = if (isNil "_blackIn_message") then { _blackOut_message } else { _blackIn_message};
	titleText [_blackIn_message, "BLACK IN", 10];
	sleep 8;
};

player_minimum_dead_time = {
	//this value should be always set >= the the respawnDelay in description.ext
	30
};

player_maximum_dead_time = {
	180
};

player_dead_wait_time = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};

	private["_minimum_deadtime"];
	_minimum_deadtime = call player_minimum_dead_time;
	_maximum_deadtime = call player_maximum_dead_time;
	
	private["_extradeadtime", "_deadtime"];
	_extradeadtime = [_player, "extradeadtime"] call player_get_scalar;
	_deadtime = _extradeadtime + _minimum_deadtime;
	_deadtime = ((_maximum_deadtime) min (_deadtime));
	
	_deadtime
};


player_dead_camera = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	private["_delay"];
	_delay = [_player] call player_dead_wait_time;
	
	[] spawn player_dead_camera_text;
	[_player] call player_dead_camera_movement;
	
	private["_end_time"];
	
	private["_jailtimeleft", "_min_dead_time"];
	_min_dead_time = call player_minimum_dead_time;
	_jailtimeleft = [_player, "jailtimeleft"] call player_get_scalar;
	if (_jailtimeleft > _min_dead_time) then { 
		_jailtimeleft = _jailtimeleft - _min_dead_time;
		[_player, "jailtimeleft", _jailtimeleft] call player_set_scalar;
		player groupChat format["Your prison sentence has been reduced by %1 second/s", _min_dead_time];
		_delay  = _min_dead_time;
	};
	
	_end_time = time + _delay;
	[_end_time] spawn player_rejoin_camera_text;
	[_end_time] call player_rejoin_camera_movement;
};


player_reset_stats = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	[_player, "deadtimes", 1] call player_update_scalar;
	[_player, "extradeadtime", 30] call player_update_scalar;
};












player_init_arrays = {
	while {true} do {
		private["_complete"];
		_complete = ([player] call player_human) || isServer;
		if (_complete) exitWith {};
	};
	
	private["_player"];
	_player = player;
	
	playerstringarray = 
	[
		"civ1","civ2","civ3","civ4","civ5","civ6","civ7","civ8","civ9","civ10",
		"civ11","civ12","civ13","civ14","civ15","civ16","civ17","civ18","civ19","civ20",
		"civ21","civ22","civ23","civ24","civ25","civ26","civ27","civ28","civ29","civ30",
		"civ31","civ32","civ33","civ34","civ35","civ36","civ37","civ38","civ39","civ40",
		"civ41","civ42","civ43","civ44","civ45","civ46","civ47","civ48","civ49","civ50",
		"civ51","civ52","civ53","civ54","civ55","civ56","civ57","civ58","civ59","civ60",
		"civ61","civ62","civ63","civ64",
		"ins1","ins2","ins3","ins4","ins5","ins6","ins7","ins8",
		"opf1","opf2","opf3","opf4","opf5","opf6","opf7","opf8","opf9","opf10","opf11","opf12","opf13","opf14","opf15","opf16","opf17","opf18","opf19",
		"cop1","cop2","cop3","cop4","cop5","cop6","cop7","cop8","cop9","cop10",
		"cop11","cop12","cop13","cop14","cop15","cop16","cop17","cop18","cop19","cop20"
	];


	role = _player;
	rolestring = str(_player);
	rolenumber = (playerstringarray find rolestring) + 1;

	//player groupChat format["role = %1, rolestring = %2,  rolenumber = %3", role, rolestring, rolenumber];

	iscop = [_player] call player_cop;
	isciv = [_player] call player_civilian;
	isopf = [_player] call player_opfor;
	isins = [_player] call player_insurgent;
	
	_player addMPEventHandler ["MPKilled", { _this call player_handle_mpkilled }];
	_player addMPEventHandler ["MPRespawn", { _this call player_handle_mprespawn }];
};


player_objects_filter = {
	private["_target", "_objects", "_filter_function"];
	
	_target = _this select 0;
	_objects = _this select 1;
	_filter_function = _this select 2;
	
	if (typeName _objects != "ARRAY") exitWith {[]};
	if (isNil "_filter_function") exitWith {[]};
	if (typeName _filter_function != "CODE") exitWith {[]};
	
	private["_result"];
	_result = [];
	{
		private["_cobject", "_evaluation"];
		_cobject = _x;		
		_evaluation = ([_target, _cobject] call _filter_function);
		if (_evaluation) then {
			_result = _result + [_cobject];
		};
	} forEach _objects;
	
	(_result)
};

player_count_carshop = {
	private["_player", "_distance"];
	
	_player = _this select 0;
	_distance = _this select 1;
	
	if (not([_player] call player_human)) exitWith { 0};
	if (isNil "_distance") exitWith {0};
	if (typeName _distance != "SCALAR") exitWith {0};
	
	private["_carshops"];
	
	private["_filter_function"];
	_filter_function = {
		private["_target", "_object", "_player", "_distance"];
		_target = _this select 0;
		_object = _this select 1;
		
		_player = _target select 0;
		_distance = _target select 1;
		((_player distance _object) <= _distance)
	};
	
	private["_filtered"];
	_filtered = [[_player, _distance], carshoparray, _filter_function] call player_objects_filter;
	((count _filtered) > 0)
};

player_count_atm = {
	private["_player", "_distance"];
	
	_player = _this select 0;
	_distance = _this select 1;
	
	if (not([_player] call player_human)) exitWith { 0};
	if (isNil "_distance") exitWith {0};
	if (typeName _distance != "SCALAR") exitWith {0};
	
	private["_filter_function"];
	_filter_function = {
		private["_target", "_object", "_player", "_distance"];
		_target = _this select 0;
		_object = _this select 1;
		
		_player = _target select 0;
		_distance = _target select 1;
		((_player distance _object) <= _distance)
	};
	
	private["_filtered"];
	_filtered = [[_player, _distance], bankflagarray, _filter_function] call player_objects_filter;
	((count _filtered) > 0)
};


player_count_vehicle = {
	private["_player", "_distance", "_locked", "_mobile"];
	
	_player = _this select 0;
	_distance = _this select 1;
	_locked = _this select 2;
	_mobile = _this select 3;
	
	if (not([_player] call player_human)) exitWith {0};
	if (isNil "_distance") exitWith {0};
	if (isNil "_locked") exitWith {0};
	if (isNil "_mobile") exitWith {0};
	if (typeName _distance != "SCALAR") exitWith {0};
	if (typeName _locked != "BOOL") exitWith {0};
	if (typeName _mobile != "BOOL") exitWith {0};
	
	private["_near_vehicles"];
	//_near_vehicles =  nearestObjects  [_player, ["Car", "Motorcycle", "Tank", "Helicopter", "Plane"], _distance];
	
	_near_vehicles = nearestObjects [_player, ["Car","Tank", "Motorcycle", "Helicopter", "Plane"], _distance];
	
	
	private["_filter_function"];
	_filter_function = {
		private["_target", "_object", "_player", "_locked", "_mobile"];
		_target = _this select 0;
		_object = _this select 1;
		
		_player = _target select 0;
		_locked = _target select 1;
		_mobile = _target select 2;
		
		private["_canMove", "_isLocked"];
		_canMove = canMove _object;
		_isLocked = locked _object;
		
		_mobile = if (_mobile) then {_canMove} else {not(_canMove)};
		_locked = if (_locked) then {_isLocked} else { not(_isLocked)};
		(_mobile && _locked)
	};
	
	private["_filtered"];
	_filtered = [[_player, _locked, _mobile], _near_vehicles, _filter_function] call player_objects_filter;
	((count _filtered) > 0)
};


player_side_spawn_marker = {
	private["_side", "_default_respawn"];
	_side = _this select 0;
	_default_respawn = "respawn_civilian";
	if (isNil "_side") exitWith {_default_respawn};
	if (typeName _side != "SIDE") exitWith {_default_respawn};
	
	if (_side == west) exitWith { "respawn_west" };
	if (_side == east) exitWith { "respawn_east" };
	if (_side == resistance) exitWith { "respawn_guerrila" };
	if (_side == civilian) exitWith { "respawn_civilian" };
	
	_default_respawn
};

player_teleport_spawn = {
	private["_player"];
	_player = _this select 0;
	private["_respawn_marker"];
	_respawn_marker = [([_player] call player_side)] call player_side_spawn_marker;
	_player setVelocity [0,0,0];
	_player setPos (getMarkerPos _respawn_marker);
};

player_distance_side_spawn = {
	private["_player", "_side"];
	_player = _this select 0;
	_side = _this select 1;
	if (not([_player] call player_exists)) exitWith {-1};
	if (isNil "_side") exitWith {-1};
	if (typeName _side != "SIDE") exitWith {-1};
	
	private["_respawn_marker"];
	_respawn_marker = [_side] call player_side_spawn_marker;
	(_player distance (getMarkerPos _respawn_marker))
};

player_near_side_spawn = {
	private["_player", "_side", "_distance"];
	_player = _this select 0;
	_side = _this select 1;
	_distance = _this select 2;
	
	if (isNil "_distance") exitWith {false};
	if (typeName _distance != "SCALAR") exitWith {false};
	
	private["_cdistance"];
	_cdistance = [_player, _side] call player_distance_side_spawn;
	if (_cdistance < 0) exitWith {false};
	(_cdistance <= _distance)
};

player_stranded = {
	private["_player"];
	
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {false};
	
	private["_near_atm", "_has_cash", "_has_lockpicks",
			"_near_carhop", "_near_locked_mobile_vehicle", "_has_repair_kit",
			"_near_locked_inmobile_vehicle", "_near_unlocked_mobile_vehicle", 
			"_near_unlocked_inmobile_vehicle", "_near_own_spawn", "_driving_movable_vehicle"];
			
	
	private["_marked_distance", "_unmarked_distance"];
	_marked_distance = 500; //(for stuff that is marked on map, player can look it up and walk, or run to those)
	_unmarked_distance = 50; //(for stuff that is not marked on map, player would have to find it in the near vicinity)
	
	_near_atm = [_player, _marked_distance] call player_count_atm;
	_near_carhop = [_player, _marked_distance] call player_count_carshop;
	_near_locked_mobile_vehicle = [_player, _unmarked_distance, true, true] call player_count_vehicle;
	_near_locked_inmobile_vehicle = [_player, _unmarked_distance, true, false] call player_count_vehicle;
	_near_unlocked_mobile_vehicle = [_player, _unmarked_distance, false, true] call player_count_vehicle;
	_near_unlocked_inmobile_vehicle = [_player, _unmarked_distance, false, false] call player_count_vehicle;
	_has_repair_kit = (([player, "reparaturkit"] call INV_GetItemAmount) > 0);
	_has_lockpicks = (([player, "lockpick"] call INV_GetItemAmount) > 5);
	_has_cash = (([player, "money"] call INV_GetItemAmount) > 1000);
	_near_own_spawn = [_player, ([_player] call player_side), _marked_distance] call player_near_side_spawn;
	private["_vehicle"];
	_vehicle = (vehicle _player);
	_driving_movable_vehicle = ((_vehicle != _player) && canMove _vehicle && (driver(_vehicle) == _player));
	
	

	/*
	player groupChat format["_driving_movable_vehicle = %1", _driving_movable_vehicle];
	player groupChat format["_near_own_spawn = %1", _near_own_spawn];
	player groupChat format["_near_atm = %1", _near_atm];
	player grouPChat format["_near_carhop = %1", _near_carhop];
	player groupChat format["_near_locked_mobile_vehicle = %1", _near_locked_mobile_vehicle];
	player groupChat format["_near_locked_inmobile_vehicle = %1", _near_locked_inmobile_vehicle];
	player groupChat format["_near_unlocked_mobile_vehicle = %1", _near_unlocked_mobile_vehicle];
	player groupChat format["_near_unlocked_inmobile_vehicle = %1", _near_unlocked_inmobile_vehicle];
	player groupChat format["_has_repair_kit = %1", _has_repair_kit];
	player groupChat format["_has_lockpicks = %1", _has_lockpicks];
	player groupChat format["_has_cash = %1", _has_cash];
	*/
	
	(
	not(
		(_driving_movable_vehicle) ||
		(_near_own_spawn) ||
		(_near_atm && _near_carhop) ||
		(_has_cash && _near_carhop) ||
		(_near_unlocked_mobile_vehicle) ||
		(_has_repair_kit && _near_unlocked_inmobile_vehicle) ||
		(_has_lockpicks && _near_locked_mobile_vehicle) ||
		(_has_lockpicks && _has_repair_kit && _near_locked_inmobile_vehicle)
		)
	)
	
};

player_reset_ui = {
	sleep 0.5;
	closeDialog 0;
};

isleep = {
	private["_sleep"];
	_sleep = _this select 0;
	_sleep = serverTime + _sleep;
	waitUntil { _sleep < serverTime };
};

player_continuity = { 
	if (not(isClient)) exitWith {};
	
	while {true} do {
		private["_complete"];
		_complete = ([player] call player_human);
		if (_complete) exitWith {};
	};
	
	private["_player"];
	_player = player;
	[_player] call player_reset_gear;

	[] call C_libraries;
	_player = [] call C_connect_client;
	
	if ([_player] call player_get_dead) then {
		private["_delay"];
		_delay = [_player] call player_dead_wait_time;
		[_delay] call player_rejoin_camera;
	}
	else {
		_player allowDamage false;
		
		[_player] call player_load_side_gear;
		[_player] call player_load_side_damage;
		
		if (not([_player] call player_load_side_vehicle)) then {
			[_player] call player_load_side_position;
		};
		_player allowDamage true;
	};
	
	[_player, false] call player_set_dead;
};

player_despawn = { _this spawn {
	//player groupChat format["player_despawn %1", _this];
	private["_unit", "_delay"];
	_unit = _this select 0;
	_delay = _this select 1;
	
	if (isNil "_unit") exitWith {};
	if (typeName _unit != "OBJECT") exitWith {};
	if (isNull _unit) exitWith {};
	if (isNil "_delay") exitWith {};
	if (typeName _delay != "SCALAR") exitWith {};

	_delay = ((_delay - 5) max (0));
	//diag_log format["player_despawn waiting %1, %2", _unit, _delay];
	[_delay] call isleep;
	
	//diag_log format["player_despawn hiding %1", _unit];
	private["_i"];
	_i = 0;
	while { _i < 5 } do {
		hideBody _unit;
		sleep 1;
		_i = _i + 1;
	};

	//diag_log format["player_despawn deleting %1", _unit];
	_unit setPos [-1,-1,-1];
	
	if (isServer) then {
		sleep 5;
		deleteVehicle _unit;
	};
};};


player_reset_prison = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {};
	
	if (([_player, "restrained"] call player_get_bool) && not(iscop or isopf)) then {
		private["_message"];
		_message = format["%1-%2 aborted while restrained, he has been sent to prison", _player, (name _player)];
		format['server globalChat toString(%1);', toArray(_message)] call broadcast;
		
		[_player, 15] call player_prison_time;
		[_player, 100] call player_prison_bail;
		[_player] call player_prison_convict;
	}
	else { if (([_player] call player_get_arrest) && not(iscop or isopf))then {
		private["_message"];
		_message = format["%1-%2 has been sent to prison to complete his previous sentence", _player, (name _player)];
		format['server globalChat toString(%1);', toArray(_message)] call broadcast;
		[_player] call player_prison_convict;
	}
	else {if ([_player, "roeprison"] call player_get_bool) then {
		[_player] call player_prison_roe;
	};};};
};



player_spawn = { _this spawn {
	private["_player", "_first_time"];
	_player = _this select 0;
	_first_time = _this select 1;
	if (not([_player] call player_exists)) exitWith {};
	if (isNil "_first_time") exitWith {};
	if (typeName _first_time != "BOOL") exitWith {};
	
	waitUntil { alive _player };
	
	if (not(_first_time)) then {
		[_player] call player_reset_gear;
	};
	
	if (_first_time) then {
		[_player] call player_intro_text;
	};
	
	if (not(_first_time) && ([_player] call player_cop)) then {
		[_player] call player_load_side_gear;
	};
	
	[_player] call player_reset_prison;
	call respawn_retribution;
	[_player] call player_init_stats;
	
	//mark the player alive when we are done with the dead camera
	[_player, false] call player_set_dead;
	[_player] call name_tags_3d_controls_setup;
};};

player_wait = {
	private["_flag_name"];
	_flag_name = _this select 0;
	if (isNil "_flag_name") exitWith {};
	if (typeName _flag_name != "STRING") exitWith {};
	private["_flag_variable"];
	_flag_variable = missionNamespace getVariable _flag_name;
	if (isNil "_flag_variable") exitWith {};
	waitUntil { (missionNamespace getVariable _flag_name)};
};

player_intro_text = {_this spawn {
	private["_intro_messages"];
	
	_intro_messages = [
		//"Welcome to Rise Takistan Life: Revolution, an RPG mission. \n\n This is an international server, everyone is welcome.",
		//"Civil war has broken out in Takistan! \n\n Opfor, Blufor, and Indfor can kill each other on sight.",
		//"Do not kill unarmed civilians! \n\n Ne les tuez pas des civils desarmes! \n\n No mate a civiles desarmados!",
		//"Do not teamkill! \n\n Ne tuez pas votre propre equipe! \n\n No mate a su propio equipo!",
		//"Racial slurs are prohibited here. \n\n Foul language and heated arguments are OK. \n\n Racist harassment of other players is NOT.",
		//"Game guide, rules, Teamspeak Info, and changelog on the map tabs.\n\nPlease be helpful to new players and don't grief.\n\nThis is a roleplaying server."
	];

	private["_delay"];
	_delay = 5;
	
	{
		private["_message"];
		_message = _x;
		titleText [_message, "PLAIN", 0];
		sleep _delay;
	} forEach _intro_messages;
	
	3 fademusic 0;
	
};};


player_drop_inventory = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_exists)) exitWith {};
	
	if ([_player] call player_cop) then {
		private["_amount"];	
		_amount = ([player, "money"] call INV_GetItemAmount);
		if (_amount <= 0) exitWith {};
		
		private["_object"];
		_object = "EvMoney" createVehicle (position player);
		_object setVariable ["droparray", [([_amount] call encode_number), "money"], true];
		[_player, "money", -(_amount)] call INV_AddInventoryItem;
	}
	else {
		private["_i"];
		_i = 0;
		
		private["_inventory"];
		_inventory = [_player] call player_get_inventory;
		while { _i < (count _inventory) } do {
			private["_item", "_amount"];
			_item   = ((_inventory select _i) select 0);
			_amount = ([player, _item] call INV_GetItemAmount);

			if (_amount > 0 and (_item call INV_GetItemDropable)) then {
				private["_class", "_object"];
				_class = [_item] call item2class;
				_object = _class createvehicle position player;
				_object setVariable ["droparray", [([_amount] call encode_number), _item], true];
			};
			_i = _i + 1;
		};
		[_player] call player_reset_side_inventory;
	};
};

player_escape_menu_check = { _this spawn {
	if (not(isClient)) exitWith {};
	// Taken from DOMINATION
	// Edited for TLR
	disableSerialization;
	sleep 10;

	while {true} do {
		waitUntil {not(isnull (findDisplay 49))};

		_ctrl = (findDisplay 49) displayCtrl 1010;
		_ctrl ctrlEnable false;
		//escape menu opened
		_enCtrl = [_ctrl] spawn {
			disableSerialization;
			_ctrl = _this select 0;
			_stext = ctrlText _ctrl;
			private["_i"];
			_ctrl buttonSetAction "respawnButtonPressed = true;";
			for "_i" from 30 to 1 step -1 do {
				if (isnull (findDisplay 49)) exitWith {};
				_text = _stext + format ["(%1)",_i]; _ctrl ctrlSetText _text;
				sleep 1;
			};
				
			if (!isnull (findDisplay 49)) then {
				_ctrl ctrlSetText _stext; 
				_ctrl ctrlEnable true;
			};
		};

		waitUntil {isNull (findDisplay 49)};
		//escape menu closed
		if (!scriptDone _enCtrl) then {
			terminate _enCtrl
		};
	};
};};


player_init_civilian_stats = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_civilian)) exitWith {};
	
	_player setVariable ["gasmask", false, true];
	_player setVariable ["stun_armor", "none", true];
	[_player, "stun_light_on", 0] call INV_SetItemAmount;
	[_player, "stun_full_on", 0] call INV_SetItemAmount;
};

player_init_cop_stats = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_cop)) exitWith {};
	
	private["_gasmask_on"];
	_gasmask_on = ([player, "gasmask_on"] call INV_GetItemAmount > 0);
	_player setVariable ["gasmask", _gasmask_on, true];
	
	if ([player, "stun_light_on"] call INV_GetItemAmount > 0) then {
		_player setVariable ["stun_armor", "light", true];
	}
	else { if ([player, "stun_full_on"] call INV_GetItemAmount > 0) then {
		_player setVariable ["stun_armor", "full", true];
	}
	else {
		_player setVariable ["stun_armor", "none", true];
	};};
	stunshots = 0;
};

player_init_stats = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {};
	role = _player;
	INV_hunger = 25;
	shoveldur = 20;
	pickaxedur = 50;
	hammerdur = 100;
	alreadygotaworkplacejob = 0;
	respawnButtonPressed = false;
	demerits = if ("car" call INV_haslicense) then {10} else {demerits};
	[_player, "isstunned", false] call player_set_bool;
	[_player, "restrained", false] call player_set_bool;
	[_player, "extradeadtime", 0] call player_set_scalar;
	
	if (iscop or isopf) then {
		[_player, "sidemarkers", true] call player_set_bool;	
	};
	
	[_player] call player_init_civilian_stats;
	[_player] call player_init_cop_stats;
};




player_handle_mpkilled = { _this spawn {
	//player groupChat format["player_handle_mpkilled %1", _this];
	private["_unit", "_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
	[_unit, 15] spawn player_despawn;
	
	if (str(_unit) != str(player)) exitWith {};
	
	private["_player"];
	_player = player;
	
	[_player] call player_save_side_gear;
	[_player] call player_save_side_inventory;
	
	[_killer, _player] call victim;

	[_player] call player_reset_gear;
	[_player] call player_drop_inventory;
	[_player] call player_reset_ui;
	[_player] call player_reset_stats;
	[_player] call player_dead_camera;
	[_player] call name_tags_3d_controls_setup;
};};



player_handle_mprespawn = {
	//player groupChat format["player_handle_mprespawn %1", _this];
	private["_unit", "_corpse"];
	_unit = _this select 0;
	_corpse = _this select 1;
	
	if (not(str(_unit) == str(player))) exitWith {};
	[_unit, false] call player_spawn;
};

ISSE_IsVictim =
{
	private ["_state", "_victimStats"];
	_state  = animationState _this;
	_victimStats = ["amovpercmstpssurwnondnon", "adthppnemstpsraswpstdnon_2", "adthpercmstpslowwrfldnon_4", "amovpercmwlkssurwnondf_forgoten", "civillying01", "civilsitting", "civilsitting01", "civilsitting02", "civilsitting03"];
	if (_state in _victimStats) then
	{
		true
	}
	else
	{
		false
	};
};

[] call player_escape_menu_check;
[] call player_save_side_gear_setup;
[] call player_init_arrays;

player_functions_defined = true;