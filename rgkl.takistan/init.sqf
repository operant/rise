enableSaving [false, false];


isClient = !isServer || (isServer && !isDedicated);

sleep 0.5;
/*
call compile preprocessfile "Life\Init\triggers.sqf";

    if(!debug)then{["camera"] execVM "introcam.sqf";["text"] execVM "introcam.sqf";};
*/

server globalChat "Initializing awesome.......";
[] execVM "donators.sqf";
_h = [] execVM "Awesome\Functions\encodingfunctions.sqf";
waitUntil{scriptDone _h};

if (isServer) then {
	_h = [] execVM "Awesome\MyStats\persist.sqf";
	waitUntil{scriptDone _h};
};


waitUntil{scriptDone _h};

_h = [] execVM "Awesome\MyStats\functions.sqf";
waitUntil{scriptDone _h};

WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 0];
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];
CIVILIAN setFriend [WEST, 0];
CIVILIAN setFriend [EAST, 0];
CIVILIAN setFriend [RESISTANCE, 0];
/*
_h = [] execVM "Awesome\Functions\time_functions.sqf";
waitUntil{scriptDone _h};
*/

//[] execVM "clean.sqf";

debug = false;

if(!debug)then{["camera"] execVM "introcam.sqf";["text"] execVM "introcam.sqf";};


_h = [] execVM "Awesome\Scripts\optimize_1.sqf";
waitUntil{scriptDone _h};


["init"] execVM "bombs.sqf";
["init"] execVM "bombs_don.sqf";

if (isServer) then {
	call compile preprocessFile "\iniDB\init.sqf";
	execVM "ServerSide\Oracle-Core.sqf";
	//execVM "ServerSide\whitelist_blacklist.sqf";
	["server"] execVM "bombs.sqf";
	["server"] execVM "bombs_don.sqf";
};



_h = [] execVM "Awesome\Functions\interaction.sqf";
waitUntil{scriptDone _h};

call compile preprocessfile "triggers.sqf";

if (isClient) then {
	[] execVM "briefing.sqf";
};


if(isServer) then {
	execVM "targets.sqf";
};

_h = [] execVM "broadcast.sqf";
waitUntil{scriptDone  _h};

_h = []	execVM "customfunctions.sqf";
waitUntil{scriptDone  _h};

_h = []	execVM "strfuncs.sqf";
waitUntil{scriptDone  _h};

_h = []	execVM "1007210.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "4422894.sqf";
waitUntil{scriptDone _h};

_h = []	execVM "miscfunctions.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "Awesome\Functions\quicksort.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "INVvars.sqf";
waituntil{scriptDone  _h};

_h = [] execVM "Awesome\Shops\functions.sqf";

_h = [] execVM "Awesome\Functions\bankfunctions.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "bankexec.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "execlotto.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "initWPmissions.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "gfx.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "noglobal.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "animList.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "variables.sqf";
waitUntil{scriptDone  _h};

_h = [] execVM "Awesome\Functions\money_functions.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "Awesome\Functions\gangfunctions.sqf";
waitUntil{scriptDone _h};

// Starts up Awesome scripts
_h = [] execVM "Awesome\init.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "setPitchBank.sqf";
waitUntil {scriptDone _h};



publicvariable "station1robbed";
publicvariable "station2robbed";
publicvariable "station3robbed";
publicvariable "station4robbed";
publicvariable "station5robbed";
publicvariable "station6robbed";
publicvariable "station7robbed";
publicvariable "station8robbed";
publicvariable "station9robbed";


if(isClient) then {
	//player GlobalChat "Stat Save Initiated";
	[] execVM "RG\cLoad.sqf";
	//server globalChat "Loading - Please Wait";
	[] execVM "Client\watermark.sqf";
	[] execVM "Awesome\Functions\holster.sqf";
	[] execVM "clientloop.sqf";
	[0,0,0,["clientloop"]] execVM "gangs.sqf";
	[0,0,0,["clientloop"]] execVM "squads.sqf";
	[] execVM "respawn.sqf";
	[] execVM "petrolactions.sqf";
	[] execVM "nametags.sqf";
	[] execVM "Awesome\Functions\markers.sqf";
	[] execVM "Awesome\Functions\salary.sqf";
	//[] execVM "motd.sqf";
	[] ExecVM "Awesome\MountedSlots\functions.sqf";
	["client"] execVM "bombs.sqf";
	["client"] execVM "bombs_don.sqf";
	[] execVM "Awesome\Functions\factory_functions.sqf";
	player addEventHandler ["fired", {_this execVM "Awesome\EH\EH_fired.sqf"}];
	player addEventHandler ["handleDamage", {_this execVM "Awesome\EH\EH_handledamage.sqf"}];
	player addEventHandler ["WeaponAssembled", {_this execVM "Awesome\EH\EH_weaponassembled.sqf"}];
	[] execVM "onKeyPress.sqf";
	//server globalChat "Loading - Complete";
};

/*
_h = [] execVM "Scripts\gcrs\gcrsrepelscript.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "Scripts\gcrs\gcrsdeployrope.sqf";
waitUntil{scriptDone _h};

_h = [] execVM "Scripts\gcrs\gcrsdroprope.sqf";
waitUntil{scriptDone _h};
*/

_h = [] execVM "Scripts\whitelist_blacklist.sqf";
waitUntil {scriptDone _h};

//_h = [] execVM "Awesome\Rappel\init.sqf";
//waitUntil {scriptDone _h};


if (isServer) then {
	//[60,180,true] execVM "cly_removedead.sqf";
	[0, 0, 0, ["serverloop"]] execVM "mayorserverloop.sqf";
	[0, 0, 0, ["serverloop"]] execVM "chiefserverloop.sqf";
	[] execVM "gangsserverloop.sqf";
	[] execVM "druguse.sqf";
	[] execVM "drugreplenish.sqf";
	[] execVM "robpool.sqf";
	// [] execVM "Awesome\Scripts\hunting.sqf";
	[] execVM "setObjectPitches.sqf";
	[] execVM "governmentconvoy.sqf";

//=======================rob gas station init and variables================
	[] execVM "stationrobloop.sqf";
	station1money = 5000;
	publicvariable "station1money";
	station2money = 5000;
	publicvariable "station2money";
	station3money = 5000;
	publicvariable "station3money";
	station4money = 5000;
	publicvariable "station4money";
	station5money = 5000;
	publicvariable "station5money";
	station6money = 5000;
	publicvariable "station6money";
	station7money = 5000;
	publicvariable "station7money";
	station8money = 5000;
	publicvariable "station8money";
	station9money = 5000;
	publicvariable "station9money";
};


// Define Variables
/*
gcrsrope1 = "none";
gcrsrope2 = "none";
gcrsrope3 = "none";
gcrsrope4 = "none";
gcrsrope5 = "none";
gcrsrope6 = "none";
gcrsrope7 = "none";
gcrsrope8 = "none";
gcrsrope9 = "none";
gcrsrope10 = "none";
gcrsrope11 = "none";
gcrsrope12 = "none";
gcrsrope13 = "none";
gcrsrope14 = "none";
gcrsrope15 = "none";
gcrsrepelvehicle = "none";
gcrsropedeployed = "false";
gcrsdeployropeactionid = 0;
gcrsdropropeactionid = 0;
gcrsplayerrepelactionid = 0;
gcrsplayerveh = "none";
gcrspilotvehicle = "none";
gcrsrapelvehiclearray = ["MH6J_EP1", "UH1H_TK_GUE_EP1", "UH60M_EP1", "BAF_Merlin_HC3_D", "CH_47F_EP1", "Mi17_UN_CDF_EP1", "Ka60_PMC"];
gcrsrapelheloarray = [];
gcrsplayerveharray = [];

// End GeneralCarver's Rapel Script Init Scripting
*/
//// Start the Drop Cargo Script
execVM "BTK\Cargo Drop\Start.sqf";
/*
// ====================================================================================
// DEFINES
	#ifndef execNow
	#define execNow call compile preprocessfilelinenumbers
	#endif
	#define PP preprocessfilelinenumbers
	#define VAR_DEFAULT(var,val) if (isNil #var) then {var=(val);}
// ====================================================================================
// init persistentDB
		execNow "core\init.sqf";
// ====================================================================================
*/
/*
if (isServer) then
{
_h = execVM "statsave\server\savefunc.sqf";
waitUntil{scriptDone  _h};
_h = execVM "statsave\server\serverevents.sqf";
waitUntil{scriptDone  _h};
};
if(!dedicatedserver) then
{
waitUntil {alive player};
execVM "statsave\saveinit.sqf";
};*/

