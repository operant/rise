startmoneh = 500000;
donatormoneh = 550000;
silvermoneh = 600000;
goldmoneh = 750000;
platinummoneh = 1000000;
vipmoneh = 1500000;
adminmoneh = 1000000;

private["_uid"];
_uid = getPlayerUID player;

if (_uid in donators1) then {
    startmoneh = donatormoneh;
}
else { if (_uid in donators2) then {
    startmoneh = silvermoneh;
	INV_CarryingCapacity = 100;
}
else { if (_uid in donators3) then {
    startmoneh = goldmoneh;
	INV_CarryingCapacity = 200;
}
else { if (_uid in donators4) then {
	INV_CarryingCapacity = 300;
    startmoneh = platinummoneh;
}
else { if (_uid in donatorsVIP) then {
    startmoneh = VIPmoneh;
	INV_CarryingCapacity = 500;
};};};};};

if (isAdmin) then {
	startmoneh = adminmoneh;
};
//sleep 1;
//player groupChat "Initializing Loading Player Stats If your stats has not yet loaded after this process please relog.";
//sleep 1;
//hint "Stats Loading 0%";
//player groupChat "Loading";
//Requests info from server in order to download stats
//player groupChat "Loading. .";
//hint "Stats Loading 10%";
//player groupChat "Loading. . .";
//sleep 1;
//hint "Stats Loading 20%";
//hint "Stats Loading";
if (isNil "bankaccount") then {
		[player, startmoneh] call set_bank_valuez;
};

switch (playerSide) do
{
	case west:
	{
		[getPlayerUID player, getPlayerUID player, "moneyAccountWest", "NUMBER"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "WeaponsPlayerWest", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "MagazinesPlayerWest", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "LicensesWest", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "InventoryWest", "ARRAY"] call sendToServer;
    	[getPlayerUID player, getPlayerUID player, "privateStorageWest", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "FactoryWest", "ARRAY"] call sendToServer;
	};
	
	case east:
	{
		[getPlayerUID player, getPlayerUID player, "moneyAccountEast", "NUMBER"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "WeaponsPlayerEast", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "MagazinesPlayerEast", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "LicensesEast", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "InventoryEast", "ARRAY"] call sendToServer;
    	[getPlayerUID player, getPlayerUID player, "privateStorageEast", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "FactoryEast", "ARRAY"] call sendToServer;
	};
	
	case resistance:
	{
		[getPlayerUID player, getPlayerUID player, "moneyAccountRes", "NUMBER"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "WeaponsPlayerRes", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "MagazinesPlayerRes", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "LicensesRes", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "InventoryRes", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "privateStorageRes", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "FactoryRes", "ARRAY"] call sendToServer;
	};
	
	case civilian:
	{
		[getPlayerUID player, getPlayerUID player, "moneyAccountCiv", "NUMBER"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "WeaponsPlayerCiv", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "MagazinesPlayerCiv", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "LicensesCiv", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "InventoryCiv", "ARRAY"] call sendToServer;
    	[getPlayerUID player, getPlayerUID player, "privateStorageCiv", "ARRAY"] call sendToServer;
		[getPlayerUID player, getPlayerUID player, "FactoryCiv", "ARRAY"] call sendToServer;
	};
};
//if(playerSide == west) then
//{

//};
//sleep 1;
//hint "Stats Loading 30%";
//player groupChat "Loading. . . .";
//if(playerSide == east) then
//{

//};
//sleep 1;
//hint "Stats Loading 40%";
//player groupChat "Loading. . . .";
//if(playerSide == resistance) then
//{

//};
//sleep 1;
//hint "Stats Loading 80%";
//player groupChat "Loading. . . . .";
//if(playerSide == civilian) then
//{

//};
call A_actions;
//sleep 1;
//hint "Stats Loading 100%";
//player groupChat "Loading. . . . . .";

//===========================================================================

//sleep 1;
//END
hint "Loading COMPLETE!";
statsLoaded = 1;
//player groupChat "Player Stats Loading Complete If your stats have not yet loaded please relog immediately or risk losing your previous stats";
sleep 20;
isdon = ((_uid in donators1) || (_uid in donators2) || (_uid in donators3) || (_uid in donators4) || (_uid in donatorsVIP));
 if ((isdon) && !("donator" call INV_HasLicense)) then {INV_LicenseOwner = INV_LicenseOwner + ["donator"];
			server globalchat "DONATOR ACCOUNT DETECTED: Donator License Added"};

isvip = (_uid in donatorsVIP);
if ((isvip) && !("viplicense" call INV_HasLicense)) then {INV_LicenseOwner = INV_LicenseOwner + ["viplicense"];
			server globalchat "VIP DONATOR ACCOUNT DETECTED: VIP Donator License Added"};

			
ispmc = ((_uid in pmcwhitelist) or (isStaff));
ishit = (_uid in hitmanlist);
/*
if ((ispmc) or(isStaff) && !("pmc_license_journeyman" call INV_HasLicense) && (playerside == civilian)) then {INV_LicenseOwner = INV_LicenseOwner + ["pmc_license_journeyman"];
			server globalchat "PMC ACCOUNT DETECTED: PMC License Added"};
*/






