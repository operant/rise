//===========================================================================
_loadFromDBClient =
"
	_array = _this;
	_uid = _array select 0;
	if((getplayerUID player) != _uid) exitWith {};
	_varName = _array select 1;
	_varValue = _array select 2;
	if(isNil '_varValue') exitWith {};

	
	if(playerSide == west) then
	{
		if(_varName == 'moneyAccountWest') then {[player, _varValue] call set_bank_valuez;};
		if(_varName == 'WeaponsplayerWest') then {{player addWeapon _x} forEach _varValue;};	
		if(_varName == 'MagazinesplayerWest') then {{player addMagazine _x} forEach _varValue;};	
		if(_varName == 'LicensesWest') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryWest') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'privateStorageWest') then {[player,'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryWest') then {INV_Fabrikowner = _varValue;};
	};
	if(playerSide == east) then
	{
		if(_varName == 'moneyAccountEast') then {[player, _varValue] call set_bank_valuez;};
		if(_varName == 'LicensesEast') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryEast') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'WeaponsplayerEast') then {{player addWeapon _x} forEach _varValue;};	
		if(_varName == 'MagazinesplayerEast') then {{player addMagazine _x} forEach _varValue;};
		if(_varName == 'privateStorageEast') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryEast') then {INV_Fabrikowner = _varValue;};
	};
	if(playerSide == resistance) then
	{
		if(_varName == 'moneyAccountRes') then {[player, _varValue] call set_bank_valuez;};
		if(_varName == 'WeaponsplayerRes') then {{player addWeapon _x} forEach _varValue;};	
		if(_varName == 'MagazinesplayerRes') then {{player addMagazine _x} forEach _varValue;};	
		if(_varName == 'LicensesRes') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryRes') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'privateStorageRes') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryRes') then {INV_Fabrikowner = _varValue;};
	};
	if(playerSide == civilian) then
	{
		if(_varName == 'moneyAccountCiv') then {[player, _varValue] call set_bank_valuez;};
		if(_varName == 'WeaponsplayerCiv') then {{player addWeapon _x} forEach _varValue;};	
		if(_varName == 'MagazinesplayerCiv') then {{player addMagazine _x} forEach _varValue;};	
		if(_varName == 'LicensesCiv') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryCiv') then {[player, _varValue] call player_set_inventory;};
	    if(_varName == 'privateStorageCiv') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryCiv') then {INV_Fabrikowner = _varValue;};
	};
";

loadFromDBClient = compile _loadFromDBClient;
//===========================================================================
_sendToServer =
"
	accountToServerLoad = _this;
	publicVariableServer 'accountToServerLoad';
";

sendToServer = compile _sendToServer;
//===========================================================================
"accountToClient" addPublicVariableEventHandler 
{
	(_this select 1) spawn loadFromDBClient;
};
//===========================================================================

statFunctionsLoaded = 1;
