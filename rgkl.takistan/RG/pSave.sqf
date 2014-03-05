waitUntil {statsLoaded == 1;};

while {true} do
{
	switch (playerSide) do
	{
		sleep 100;
		player groupChat " [STATS SAVED] ";
		sleep 20;
		
		case west: 
		{
			[getPlayerUID player, getPlayerUID player, "moneyAccountWest", ([player] call get_bank_valuez)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "WeaponsPlayerWest", weapons player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "MagazinesPlayerWest", magazines player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "LicensesWest", INV_LicenseOwner] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "InventoryWest", ([player] call player_get_inventory)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "privateStorageWest", ([player, "private_storage"] call player_get_array)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "FactoryWest", INV_Fabrikowner] call fn_SaveToServer;
		};
		
		case east:
		{
			[getPlayerUID player, getPlayerUID player, "moneyAccountEast", ([player] call get_bank_valuez)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "WeaponsPlayerEast", weapons player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "MagazinesPlayerEast", magazines player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "LicensesEast", INV_LicenseOwner] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "InventoryEast", ([player] call player_get_inventory)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "privateStorageEast", ([player, "private_storage"] call player_get_array)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "FactoryEast", INV_Fabrikowner] call fn_SaveToServer;
		};
		
		case resistance:
		{
			[getPlayerUID player, getPlayerUID player, "moneyAccountRes", ([player] call get_bank_valuez)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "WeaponsPlayerRes", weapons player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "MagazinesPlayerRes", magazines player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "LicensesRes", INV_LicenseOwner] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "InventoryRes", ([player] call player_get_inventory)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "privateStorageRes", ([player, "private_storage"] call player_get_array)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "FactoryRes", INV_Fabrikowner] call fn_SaveToServer;
		};
		
		case civilian:
		{
			[getPlayerUID player, getPlayerUID player, "moneyAccountCiv", ([player] call get_bank_valuez)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "WeaponsPlayerCiv", weapons player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "MagazinesPlayerCiv", magazines player] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "LicensesCiv", INV_LicenseOwner] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "InventoryCiv", ([player] call player_get_inventory)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "privateStorageCiv", ([player, "private_storage"] call player_get_array)] call fn_SaveToServer;
			[getPlayerUID player, getPlayerUID player, "FactoryCiv", INV_Fabrikowner] call fn_SaveToServer;
		};
		
		
	
	};
};
