/*
private["_player", "_victim"];
	
	_player = _this select 0;
	_victim = _this select 1;
	
	if (not([_player] call player_human)) exitWith {};
	if (not([_victim] call player_human)) exitWith {};
	if (not(alive _victim)) exitWith {};
	
	private["_inVehicle", "_victim_name"];
	_inVehicle = (vehicle _victim != _victim);
	_victim_name = (name _victim);
	

	if (_inVehicle) exitWith {
		player groupChat format["%1-%2 is in a vehicle!", _victim, _victim_name];
	};
	
	private["_message"];
	if ([_victim, "restrained"] call player_get_bool) then {
		[_victim, "restrained", false] call player_set_bool;
		_message = format["%1-%2 was unziptied by %3", _victim, _victim_name, (name _player)];
		format['server globalChat toString(%1);', toArray(_message)] call broadcast;
	}
	else {
		if (not([_victim] call player_vulnerable)) exitWith {
			player groupChat format["%1-%2 cannot be ziptied, he is not subdued.", _victim, _victim_name];
		};
	if(([player, "ziptie"] call INV_GetItemAmount) < 1 && (([player, "ziptie_don"] call INV_GetItemAmount) < 1 )) exitwith {player groupchat "You need a zip tie in your inventory in order to use this function."};
	(format ["%1 playmove ""%2"";", player, "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"]) call broadcast;	
		[_victim, "restrained", true] call player_set_bool;
		_message = format["%1-%2 was ziptied by %3", _victim, _victim_name, (name _player)];
		format['server globalChat toString(%1);', toArray(_message)] call broadcast;
		
		[player, 'ziptie',-1] call INV_AddInventoryItem;
		[player, 'ziptie_don',-1] call INV_AddInventoryItem;
*/

_civ = cursorTarget;

if(animationstate _civ == "civilsitting03" or animationstate _civ == "civilsitting02" or animationstate _civ == "civilsitting01" or animationstate _civ == "civilsitting") exitwith

{

(format ["%1 switchmove ""%2"";", _civ, "boundCaptive_unaErc"]) call broadcast;
player groupchat "You released the player";

};

if(vehicle _civ != _civ)exitwith{player groupchat "the civ is in a vehicle!"};
if (!(_civ call ISSE_IsVictim)) exitwith {player groupchat localize "STRS_inventory_checknohandszip"};
if(animationstate _civ == "CivilSitting") exitwith {player groupchat "Already ziptied"}; 


if(([player, "ziptie"] call INV_GetItemAmount) < 1 && (([player, "ziptie_don"] call INV_GetItemAmount) < 1 )) exitwith {player groupchat "You need a zip tie in your inventory in order to use this function."};



(format ["%1 switchmove ""%2"";", _civ, "CivilSitting"]) call broadcast;
[player, 'ziptie',-1] call INV_AddInventoryItem;
[player, 'ziptie_don',-1] call INV_AddInventoryItem;
(format['server globalchat "%3 was zip tied by %2";if (rolestring == "%1") then {execVM "Unziptie.sqf";}', _civ, name player, name _civ]) call broadcast;

