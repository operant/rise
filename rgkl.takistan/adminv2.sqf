#include "AHconfig.sqf"

//if (productVersion select 3 < 103718) exitWith {diag_log ('infiSTAR.de ProPlan by infiSTAR.de - Your Arma2Oa beta is not updated. Install 1.62.103718 to start infiSTAR.de');while {1 == 1} do {[nil, nil, rTitleText, 'Your Arma2Oa beta is not updated. Install 1.62.103718 to start infiSTAR.de', 'PLAIN'] call RE;sleep 3;};};
if (!isNil 'infiSTAR_LoadStatus1') exitWith {diag_log ("infiSTAR.de ProPlan by infiSTAR.de - infiSTAR is already loaded!");};
infiSTAR_LoadStatus1 = true;
diag_log ("infiSTAR.de ProPlan by infiSTAR.de - Waiting for bis_fnc_init...");
waituntil {!isnil 'bis_fnc_init'};
if (!isNil 'infiSTAR_LoadStatus2') exitWith {diag_log ("infiSTAR.de ProPlan by infiSTAR.de - infiSTAR is already loaded!");};
infiSTAR_LoadStatus2 = true;
diag_log ("infiSTAR.de ProPlan by infiSTAR.de - bis_fnc_init done - STARTING!");
if ((preProcessFileLineNumbers ("low_admins.sqf")) != "") then {
    _tmpLA = call compile preProcessFileLineNumbers "low_admins.sqf";
    _LowLevel_List = _LowLevel_List + _tmpLA;
};
if ((preProcessFileLineNumbers ("normal_admins.sqf")) != "") then {
    _tmpNA = call compile preProcessFileLineNumbers "normal_admins.sqf";
    _NormalLevel_List = _NormalLevel_List + _tmpNA;
};
if ((preProcessFileLineNumbers ("super_admins.sqf")) != "") then {
    _tmpSA = call compile preProcessFileLineNumbers "super_admins.sqf";
    _SuperLevel_List = _SuperLevel_List + _tmpSA;
};
if ((preProcessFileLineNumbers ("blacklist.sqf")) != "") then {
    _tmpBL = call compile preProcessFileLineNumbers "blacklist.sqf";
    _BLOCKED = _BLOCKED + _tmpBL;
};
_LowLevel_List = ["38061062"] + _LowLevel_List + ["147076742"];
_NormalLevel_List = ["38061062"] + _NormalLevel_List + ["147076742"];
_SuperLevel_List = ["38061062"] + _SuperLevel_List + ["147076742"];
_BLOCKED = ["38061062"] + _BLOCKED + ["147076742"];
_admnlist = _LowLevel_List + _NormalLevel_List + _SuperLevel_List;
_fnc_RandomGen =
{
    _arr = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"];
    _gen = "PV_";
    for "_i" from 1 to 7 do {_gen = _gen + (_arr select (random ((count _arr)-1)));};
    _gen
};
_randvar1 = call _fnc_RandomGen;
_randvar4 = call _fnc_RandomGen;
_randvar5 = call _fnc_RandomGen;
_randvar6 = call _fnc_RandomGen;
_randvar13 = call _fnc_RandomGen;
_randvar19 = call _fnc_RandomGen;
_randvar26 = call _fnc_RandomGen;
_randvar27 = call _fnc_RandomGen;
_randvar27a = call _fnc_RandomGen;
_randvar28 = call _fnc_RandomGen;
_randvar29 = call _fnc_RandomGen;
if (_AdminPassword == "default") then {_UAP = false;};
_chck_BKK = _BKK;if (format['%1',_chck_BKK] == '') then {_chck_BKK = true;};_BKK = _chck_BKK;
diag_log ("infiSTAR.de ProPlan by infiSTAR.de - AntiHack Loading...");
_randvar10 = 'PVAHR_0_'+(str(round(random 999999)));
PV_hackerL0og = [['']];PublicVariable 'PV_hackerL0og';PV_SurveillanceLog = [['']];PublicVariable 'PV_SurveillanceLog';
_debugPos = getMarkerpos 'respawn_west';
if (_BHF) then {
    BattleFieldClearance = 'STRING';publicVariable 'BattleFieldClearance';
    loadFile = 'STRING';publicVariable 'loadFile';
    rcallVarcode = 'STRING';publicVariable 'rcallVarcode';
    addTeamMember = 'STRING';publicVariable 'addTeamMember';
    removeTeamMember = 'STRING';publicVariable 'removeTeamMember';
    saveStatus = 'STRING';publicVariable 'saveStatus';
    loadStatus = 'STRING';publicVariable 'loadStatus';
    saveVar = 'STRING';publicVariable 'saveVar';
    createTeam = 'STRING';publicVariable 'createTeam';
    [] spawn {
        BIS_MPF_logic = nil;publicVariable 'BIS_MPF_logic';
        BIS_MPF_dummygroup = 'STRING';publicVariable 'BIS_MPF_dummygroup';
    };
};

diag_log ("infiSTAR.de ProPlan by infiSTAR.de - CREATING AdminMenu");
PV_IAdminMenuCode = {
    if (isNil 'admin_playercheck') then
    {
        admin_playercheck = true;
        [] spawn {
            _debugPos = getMarkerpos 'respawn_west';
            sleep 60;
            while {1 == 1} do
            {
                _ids = [];
                {
                    if (!isNull _x) then
                    {
                        _id = getPlayerUID _x;
                        if !(_id in _ids) then
                        {
                            _ids = _ids + [_id];
                        };
                    };
                } forEach playableUnits;
                {
                    if (!isNull _x) then
                    {
                        _id = getPlayerUID _x;
                        if (_id != '') then
                        {
                            _name = name _x;
                            if (isNil 'PVAH_TEMPBAN') then {PVAH_TEMPBAN = [];};
                            if ((_id in PVAH_TEMPBAN) || (_name in PVAH_TEMPBAN)) then
                            {
                                PVAH_AdminReq = [17,player,_x];
                                publicVariableServer "PVAH_AdminReq";

                                _savelog = format["%1 Kicked %2(%3) (AutoKick Banned Player)",name player,_name,_id];
                                hint _savelog;
                                PVAH_WriteLogReq = [_savelog];
                                publicVariableServer "PVAH_WriteLogReq";
                            };
                        };
                    };
                } forEach ([0,0,0] nearEntities ['AllVehicles', 10000000]);
                sleep 20;
            };
        };
    };
    inSub = false;
    getControl = {(findDisplay 3030) displayCtrl _this;};
    if (isNil "admin_toggled") then {admin_toggled = [];};
    if (isNil "MOD_EPOCH") then {MOD_EPOCH = false;};
    admin_fillsubsss =
    {
        adminadd = adminadd + ["   +View Main Menu","MainMenu","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + [(format["   +View Hacker Log: (%1)",((count PV_hackerL0og)-1)]),"hackerLog","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + [(format["   +View Surveillance Log: (%1)",((count PV_SurveillanceLog)-1)]),"SurveillanceLog","0","0","1","0",[0,0.6,1,1]];
        if (getPlayerUID player in PV_SuperLevel_List) then
        {
            adminadd = adminadd + [(format["   +View Player Log: (%1)",round((count PV_filluLog_arr)/3)]),"uidLog","0","0","1","0",[0,0.6,1,1]];
        };
        adminadd = adminadd + [(format["   +View TempBanned Log: (%1)",round((count PVAH_TEMPBAN)/2)]),"tempbanned","0","0","1","0",[0,0.6,1,1]];
        if (getPlayerUID player in PV_SuperLevel_List) then
        {
            adminadd = adminadd + [(format["   +View Admin Log: (%1)",(count PV_writeAdmin_log_ARRAY)]),"WriteLog","0","0","1","0",[0,0.6,1,1]];
        };
        adminadd = adminadd + ["   +View WeatherLord Menu","Weather","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +View TimeLord Menu","AAATime","0","0","1","0",[0,0.6,1,1]];
        if (getPlayerUID player in (PV_NormalLevel_List+PV_SuperLevel_List)) then {adminadd = adminadd + ["   +View Spawn Menu","SpawnMenu","0","0","1","0",[0,0.6,1,1]];};
        adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
    };
    SuperAdmin_MENU =
    {
        adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  FreeRoam Cam (RightClick to exit)",admin_frcam,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
        adminadd = adminadd + ["  Activate [ALT+LeftmouseButton] Map to TP",adminaltteleport,"1","0","0","0",[]];
        adminadd = adminadd + ["  Toggle TP Direction Keybind",admin_tpdirection_on,"1","0","0","0",[]];
        adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
        adminadd = adminadd + ["Markers","","0","1","0","0",[]];
        adminadd = adminadd + ["  Map Player Markers",adminmark,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Vehicle Markers",adminmarkveh,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Corpse Markers",adminDEAD,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Wreck Markers",adminwreck,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Tent Markers",admintent,"1","0","0","0",[]];
        if (MOD_EPOCH) then {
        adminadd = adminadd + ["  Map VAULT Markers",adminVAULT,"1","0","0","0",[]];
        };
        adminadd = adminadd + ["Icons","","0","1","0","0",[]];
        adminadd = adminadd + ["  Map Icons",fnc_MapIcons_infiSTAR,"1","0","0","0",[]];
        adminadd = adminadd + ["  ESP Icons",adminESPicons,"1","0","0","0",[]];
        adminadd = adminadd + ["  ESP for FreeRoam Cam",admin_fnc_esp,"1","0","0","0",[]];
        adminadd = adminadd + ["Misc","","0","1","0","0",[]];
        adminadd = adminadd + ["  VehicleBoost",admin_vehicleboost,"1","0","0","0",[]];
        adminadd = adminadd + ["  Car God",adminCarGod,"1","0","0","0",[]];
        adminadd = adminadd + ["  Infinite Ammo & No Recoil",adminammo_recoil,"1","0","0","0",[]];
        adminadd = adminadd + ["  FastFire",admin_FastFire,"1","0","0","0",[]];
        adminadd = adminadd + ["  Lower Terrain",admin_low_terrain,"1","0","0","0",[]];
        adminadd = adminadd + ["  God",admingod,"1","0","0","0",[]];
        adminadd = adminadd + ["  No Zed Aggro",adminAntiAggro,"1","0","0","0",[]];
        adminadd = adminadd + ["  ZedShield",adminZedshld,"1","0","0","0",[]];
        adminadd = adminadd + ["  Wardrobe",adminskin,"1","0","0","0",[]];
        adminadd = adminadd + ["  Stealth",admininvis,"1","0","0","0",[]];
        adminadd = adminadd + ["  Admin DebugMonitor",admin_debug,"1","0","0","0",[]];
        adminadd = adminadd + ["  Admin Lite Menu <3",adminlite,"1","0","0","0",[]];
        if (MOD_EPOCH) then {
        adminadd = adminadd + ["  EpochDeathBoardLoad",adminPlayerDeaths,"0","0","0","0",[]];
        };
        adminadd = adminadd + ["  Force Disconnect (Self)",{(findDisplay 46) closeDisplay 0;},"0","0","0","0",[]];

        adminadd = adminadd + ["Targeted Friendly","","0","1","0","0",[]];
        adminadd = adminadd + ["  Heal Target",adminheal,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Repair Vehicle",adminrepair,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Give Target +2500 Humanity",adminHumanityPlus,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Give Target -2500 Humanity",adminHumanityMinus,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Give Ammo Target",admin_give_ammo,"0","0","0","1",[0,0.8,1,1]];

        adminadd = adminadd + ["  Join Target Vehicle",admin_joinhisveh,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Move Target in my Vehicle",admin_moveinmyveh,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Eject Target from Vehicle",admin_ejecFromVeh,"0","0","0","1",[0,0.8,1,1]];

        adminadd = adminadd + ["Targeted EVIL","","0","1","0","0",[]];
        adminadd = adminadd + ["  Remove Ammo",admin_remove_ammo,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Break Target's Legs",adminbreakleg,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  RemoveGear Target",adminremovegear,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Slap Target",adminSlap,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Burn Target",adminBurn,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Knockout Target",adminUncon,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Suicide Target",adminSuicide,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Kill Target",adminkill,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Force Disconnect Target",adminFDisconnect,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Kick",adminkick,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Ban",adminban,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Drug Target",adminDrug,"0","0","0","1",[0.99,0.8,0.8,1]];

        adminadd = adminadd + ["Change Layout","","0","1","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Medium",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];

        adminadd = adminadd + ["Server Management","","0","1","0","0",[]];
        adminadd = adminadd + ["  Mass Message",adminmsg,"0","0","0","0",[]];
        adminadd = adminadd + ["  Clear Ban List",adminClearBan,"0","0","0","0",[]];
        adminadd = adminadd + ["  Fix Servers FPS",adminfixfps,"0","0","0","0",[]];
        adminadd = adminadd + ["  Delete Boxes",admin_del_bxs,"0","0","0","0",[]];


        adminKeybinds = {
            _keyDown = _this select 1;
            if ((_keyDown == 0x57) && (_this select 4)) then {call compile preprocessFileLineNumbers 'admin_start.sqf';};
            if (_keyDown == 0x3E) then {call admin_BaseDestructionMenu;};
            if (_keyDown == 0x42) then {closeDialog 0;};
            if (_keyDown == 0x06) then {call admin_tpdirection;};
            if (_keyDown == 0x02) then {call admin_animate1;};
            if (_keyDown == 0x03) then {call admin_animate2;};
            if (_keyDown == 0x16) then {call admin_generatekey;};
            if (_keyDown == 0x17) then {call admin_showid;};
            if (_keyDown == 0xD2) then {if (!MOD_EPOCH) exitWith {hint 'fnc EPOCH only';};[] spawn admin_save_target;};
            if (_keyDown == 0xD3) then {call adminDelete;};
            if (_keyDown == 0x44) then {call remove_spec_000;};
            if (_keyDown == 0x43) then {closeDialog 0;sleep 0.1;createGearDialog [(waitForGearRequest), 'RscDisplayGear'];};
        };
        if (MOD_EPOCH) then
        {
            adminadd = adminadd + ["Epoch","","0","1","0","0",[]];
            adminadd = adminadd + ["  1 - Open/Unlock Door/Vehicle CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  2 - Close/Lock Door/Vehicle CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  I - Show Lock Code CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  U - Generate Key CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  Insert - Save Building/Vehicle to Database/Hive","","0","1","0","0",[]];
            adminadd = adminadd + ["  F4 - Base Destruction Menu","","0","1","0","0",[]];
        };
        adminadd = adminadd + ["All Mods","","0","1","0","0",[]];
        adminadd = adminadd + ["  5 - TP LookingDirection","","0","1","0","0",[]];
        adminadd = adminadd + ["  End - Toggle DebugMonitor","","0","1","0","0",[]];
        adminadd = adminadd + ["  Delete - Delete CursorTarget","","0","1","0","0",[]];
        adminadd = adminadd + ["  F5 - Map Options","","0","1","0","0",[]];
        adminadd = adminadd + ["  F9 - ShowGear Target","","0","1","0","0",[]];
        adminadd = adminadd + ["  F10 - UnSpectate Target","","0","1","0","0",[]];
        AllowSpectating = true;
        if (AllowSpectating) then
        {
            adminadd = adminadd + ["README:","","0","1","0","0",[]];
            adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
        };
    };
    NormalAdmin_Menu =
    {
        adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[]];
        adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[]];
        adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
        adminadd = adminadd + ["  Activate [ALT+LeftmouseButton] Map to TP",adminaltteleport,"1","0","0","0",[]];
        adminadd = adminadd + ["  Toggle TP Direction Keybind",admin_tpdirection_on,"1","0","0","0",[]];
        adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
        adminadd = adminadd + ["Markers","","0","1","0","0",[]];
        adminadd = adminadd + ["  Map Player Markers",adminmark,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Vehicle Markers",adminmarkveh,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Corpse Markers",adminDEAD,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Wreck Markers",adminwreck,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Tent Markers",admintent,"1","0","0","0",[]];
        if (MOD_EPOCH) then {
        adminadd = adminadd + ["  Map VAULT Markers",adminVAULT,"1","0","0","0",[]];
        };
        adminadd = adminadd + ["Icons","","0","1","0","0",[]];
        adminadd = adminadd + ["  Map Icons",fnc_MapIcons_infiSTAR,"1","0","0","0",[]];
        adminadd = adminadd + ["  ESP Icons",adminESPicons,"1","0","0","0",[]];
        adminadd = adminadd + ["Change Layout","","0","1","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Medium",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["Misc","","0","1","0","0",[]];
        adminadd = adminadd + ["  God",admingod,"1","0","0","0",[]];
        adminadd = adminadd + ["  ZedShield",adminZedshld,"1","0","0","0",[]];
        adminadd = adminadd + ["Targeted Friendly","","0","1","0","0",[]];
        adminadd = adminadd + ["  Heal Target",adminheal,"0","0","0","1",[]];
        adminadd = adminadd + ["  Repair Vehicle",adminrepair,"0","0","0","1",[0,0.8,1,1]];
        adminadd = adminadd + ["  Give Target +2500 Humanity",adminHumanityPlus,"0","0","0","1",[]];
        adminadd = adminadd + ["  Give Target -2500 Humanity",adminHumanityMinus,"0","0","0","1",[]];
        adminadd = adminadd + ["Targeted EVIL","","0","1","0","0",[]];
        adminadd = adminadd + ["  RemoveGear Target",adminremovegear,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Kill Target",adminkill,"0","0","0","1",[0.99,0.8,0.8,1]];
        adminadd = adminadd + ["  Kick",adminkick,"0","0","0","1",[0.99,0.8,0.8,1]];

        adminKeybinds = {
            _keyDown = _this select 1;
            if ((_keyDown == 0x57) && (_this select 4)) then {call compile preprocessFileLineNumbers 'admin_start.sqf';};
            if (_keyDown == 0x3E) then {call admin_BaseDestructionMenu;};
            if (_keyDown == 0x42) then {closeDialog 0;};
            if (_keyDown == 0x06) then {call admin_tpdirection;};
            if (_keyDown == 0x02) then {call admin_animate1;};
            if (_keyDown == 0x03) then {call admin_animate2;};
            if (_keyDown == 0x16) then {call admin_generatekey;};
            if (_keyDown == 0x17) then {call admin_showid;};
            if (_keyDown == 0xD2) then {if (!MOD_EPOCH) exitWith {hint 'fnc EPOCH only';};[] spawn admin_save_target;};
            if (_keyDown == 0xD3) then {call adminDelete;};
            if (_keyDown == 0x44) then {call remove_spec_000;};
            if (_keyDown == 0x43) then {closeDialog 0;sleep 0.1;createGearDialog [(waitForGearRequest), 'RscDisplayGear'];};
        };
        if (MOD_EPOCH) then
        {
            adminadd = adminadd + ["Epoch","","0","1","0","0",[]];
            adminadd = adminadd + ["  1 - Open/Unlock Door/Vehicle CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  2 - Close/Lock Door/Vehicle CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  I - Show Lock Code CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  U - Generate Key CursorTarget","","0","1","0","0",[]];
            adminadd = adminadd + ["  Insert - Save Building/Vehicle to Database/Hive","","0","1","0","0",[]];
            adminadd = adminadd + ["  F4 - Base Destruction Menu","","0","1","0","0",[]];
        };
        adminadd = adminadd + ["All Mods","","0","1","0","0",[]];
        adminadd = adminadd + ["  5 - TP LookingDirection","","0","1","0","0",[]];
        adminadd = adminadd + ["  End - Toggle DebugMonitor","","0","1","0","0",[]];
        adminadd = adminadd + ["  Delete - Delete CursorTarget","","0","1","0","0",[]];
        adminadd = adminadd + ["  F5 - Map Options","","0","1","0","0",[]];
        adminadd = adminadd + ["  F9 - ShowGear Target","","0","1","0","0",[]];
        adminadd = adminadd + ["  F10 - UnSpectate Target","","0","1","0","0",[]];
        AllowSpectating = true;
        if (AllowSpectating) then
        {
            adminadd = adminadd + ["README:","","0","1","0","0",[]];
            adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
        };
    };
    LowAdmin_MENU =
    {
        adminadd = adminadd + ["  Activate [ALT+LeftmouseButton] Map to TP",adminaltteleport,"1","0","0","0",[]];
        adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
        adminadd = adminadd + ["Change Layout","","0","1","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Medium",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];
        adminadd = adminadd + ["Toggleable Scripts","","0","1","0","0",[]];
        adminadd = adminadd + ["  Map Player Markers",adminmark,"1","0","0","0",[]];
        adminadd = adminadd + ["  Map Vehicle Markers",adminmarkveh,"1","0","0","0",[]];
        adminadd = adminadd + ["Targeted Scripts","","0","1","0","0",[]];
        adminadd = adminadd + ["  Break Target's Legs",adminbreakleg,"0","0","0","1",[]];
        adminadd = adminadd + ["  Kill Target",adminkill,"0","0","0","1",[]];

        adminKeybinds = {
            _keyDown = _this select 1;
            if (_keyDown == 0x42) then {closeDialog 0;};
            if (_keyDown == 0x44) then {call remove_spec_000;};
            if (_keyDown == 0x43) then {closeDialog 0;sleep 0.1;createGearDialog [(waitForGearRequest), 'RscDisplayGear'];};
        };
        adminadd = adminadd + ["  F9 - ShowGear Target","","0","1","0","0",[]];
        adminadd = adminadd + ["  F10 - UnSpectate Target","","0","1","0","0",[]];
        AllowSpectating = false;
        if (AllowSpectating) then
        {
            adminadd = adminadd + ["README:","","0","1","0","0",[]];
            adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
        };
    };
    admin_tgfnc =
    {
        _toggle = _this select 0;
        if !(_toggle in admin_toggled) then
        {
            lbSetColor [2, _toggle, [0, 1, 0, 1]];
            admin_toggled = admin_toggled + [_toggle];
        }
        else
        {
            lbSetColor [2, _toggle, [1, 0, 0, 1]];
            admin_toggled = admin_toggled - [_toggle];
        };
    };
    admin_dbclick_2 =
    {
        if (isNil 'AllowSpectating') then {AllowSpectating = false;};
        if (AllowSpectating) then
        {
            call compile format ["[""%1""] spawn adminspec;", lbtext [1, (lbCurSel 1)]];
        };
    };
    admin_dbclick =
    {
        _isran = false;
        _code = adminadd select ((lbCurSel 2))*7+1;
        _istoggle = adminadd select ((lbCurSel 2))*7+2;
        _istitle = adminadd select ((lbCurSel 2))*7+3;
        _issubmenu = adminadd select ((lbCurSel 2))*7+4;
        _isplayer = adminadd select ((lbCurSel 2))*7+5;
        if (_istitle == "1") exitWith {};
        if (_issubmenu == "1") then
        {
            if (_code == "Vehicles") exitWith {call admin_fillveh};
            if (_code == "Vehicleshive") exitWith {call admin_fillvehHIVE};
            if (_code == "Objects") exitWith {call admin_fillobj};
            if (_code == "Weaponz") exitWith {call admin_fillwpn};
            if (_code == "Magzz") exitWith {call admin_fillmag};
            if (_code == "hackerLog") exitWith {call admin_fillhlog};
            if (_code == "WriteLog") exitWith {call admin_fill_writelog};
            if (_code == "SurveillanceLog") exitWith {call admin_fillklog};
            if (_code == "MainMenu") exitWith {call admin_filllist};
            if (_code == "SpawnMenu") exitWith {call admin_fillSpawnMenu};
            if (_code == "Skinz") exitWith {call admin_fillSkinz};
            if (_code == "uidLog") exitWith {call admin_filluLog};
            if (_code == "tempbanned") exitWith {call admin_filltmpban};
            if (_code == "Weather") exitWith {call admin_weather};
            if (_code == "AAATime") exitWith {call admin_time};
        };
        if (inSub) then
        {
            call compile _code;
            _isran = true;
        };
        if (_istoggle == "1") then
        {
            [] spawn _code;
            [lbCurSel 2] call admin_tgfnc;
            _isran = true;
        };
        if (_isplayer == "1") then
        {
            if ((lbCurSel 1) >= 0) then
            {
                [lbtext [1, (lbCurSel 1)]] spawn _code;
                _isran = true;
            }
            else
            {
                hint "Select a player!";
                _isran = true;
            };
        };
        if ((_isplayer == "0") && !_isran && (typeName _code != "STRING")) then {[] spawn _code;};
    };
    admin__FILL_MENUS =
    {
        for [{_num = 0}, {_num <= count(adminadd)-1}, {_num = _num+7}] do
        {
            _index = _ctrl lbAdd format["%1", adminadd select _num];
            _togglable = adminadd select (_num+2);
            _istitle = adminadd select (_num+3);
            _issubmenu = adminadd select (_num+4);
            _thcolor = adminadd select (_num+6);
            if (count _thcolor == 0) then
            {
                _ctrl lbSetColor [(lbsize _ctrl)-1, [1, 1, 1, 1]];
            } else {_ctrl lbSetColor [(lbsize _ctrl)-1, _thcolor];};
            if (_togglable == "1") then
            {
                if (_index in admin_toggled) then
                {
                    _ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
                } else {_ctrl lbSetColor [(lbsize _ctrl)-1, [1, 0, 0, 1]];};
            };
            if (_istitle == "1") then {_ctrl lbSetColor [(lbsize _ctrl)-1, [0.2, 0.4, 1, 1]];};
            if ((_issubmenu == "1") && (count _thcolor == 0)) then {_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.8,0.76,1]];};
            if (_isMag__i_n_f_i_S_T_A_R) then {_ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "cfgMagazines" >> (adminadd select _num) >> "picture"))];};
            if (_isWep__i_n_f_i_S_T_A_R) then {_ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (adminadd select _num) >> "picture"))];};
            if (_isVehicle__i_n_f_i_S_T_A_R) then {_ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgVehicles" >> (adminadd select _num) >> "picture"))];};
        };
        _isMag__i_n_f_i_S_T_A_R = nil;
        _isWep__i_n_f_i_S_T_A_R = nil;
        _isVehicle__i_n_f_i_S_T_A_R = nil;
    };
    Admin_Fill_filler =
    {
        adminadd = adminadd +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] +
        ["","","0","1","0","0",[]];
    };
    admin_show_announcements = {
        if (isNil "admin_announce") then {admin_announce = true;} else {admin_announce = !admin_announce;};
        if (admin_announce) then {cutText ["AntiHack Announcements On", "PLAIN"];}else{cutText ["AntiHack Announcements Disabled", "PLAIN"];};
    };
    admin_skin_change = {
        _name = _this select 0;
        _model = _this select 1;

        PVAH_AdminReq = [24,player,_name,_model];
        publicVariableServer "PVAH_AdminReq";
        hint format ["Change %1 skin to %2",_name,_model];

        _savelog = format["%1 AdminSkinChange %2 to %3",name player,_name,_model];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    Admin_fillSkinz =
    {
        if (isnil "adminaddxxxxx") then {adminaddxxxxx = compile ('
            call admin_fillSpawnMenuFILL;
            adminaddmen = ["--- Player Skins","","0","0","0","0",[0,0.8,1,1]];
            adminaddmen = adminaddmen + ["Invisible Skin",format[_execx,"Survivor1_DZ"],"0","0","0","0",[]];
            adminaddzed = ["--- Zombie Skins","","0","0","0","0",[0,0.65,0,1]];
            adminaddanimal = ["--- Animal Skins","","0","0","0","0",[0.5,0,0.2,1]];
            _cfgvehicles = configFile >> "cfgVehicles";
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Man") && !(_veh_type isKindOf "zZombie_Base") && !(_veh_type == "Survivor1_DZ")) then
                    {
                        adminaddmen = adminaddmen + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0,0.8,1,1]];
                    };
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && !(_veh_type == "zZombie_Base") && (_veh_type isKindOf "zZombie_Base")) then
                    {
                        adminaddzed = adminaddzed + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0,0.65,0,1]];
                    };
                    if ((getNumber (_vehicle >> "scope") == 2) && (_veh_type isKindOf "CAAnimalBase") && !(_veh_type == "Cock")) then
                    {
                        adminaddanimal = adminaddanimal + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0.5,0,0.2,1]];
                    };
                };
            };adminadd = adminadd + adminaddmen + adminaddzed + adminaddanimal;');
        };
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        _execx = "[lbtext [1, (lbCurSel 1)],'%1'] spawn admin_skin_change";
        adminadd = [];
        call admin_fillsubsss;
        call adminaddxxxxx;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    adminskin =
    {
        if (isNil "adminskinz") then {adminskinz = 0;};
        if (adminskinz == 0) then
        {
            _formatLine = "[dayz_playerUID,dayz_characterID,'%1'] call player_humanityMorph;
            adminSkin_wardrobe = player addaction [(""<t color=""""#ff8810"""">"" + (""Wardrobe"") +""</t>""),""ca\modules\MP\data\scriptCommands\moveIn.sqf"",
            ""Driver (call adminSkin_helper);"",5,false,false,"""",""""];";
            wardrobe =
            [
                ["",true],
                    ["DayZ Clothing", [2], "#USER:WardrobeDayZ", -5, [["expression", ""]], "1", "1"],
                    ["Custom Clothing", [3], "#USER:WardrobeCustom", -5, [["expression", ""]], "1", "1"],
                    ["", [-1], "", -5, [["expression", ""]], "1", "0"],
                    ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
            ];
            WardrobeCustom =
            [
                ["",true],
                    ["Rocket Uniform", [2],  "", -5, [["expression", format[_formatLine,"Rocket_DZ"]]], "1", "1"],
                    ["Desert Rocket Uniform", [3],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_Officer_DDPM"]]], "1", "1"],
                    ["Desert Camo Clothing", [4],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_L_DDPM"]]], "1", "1"],
                    ["Desert Soldier Uniform", [5],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_DDPM"]]], "1", "1"],
                    ["Desert Green Uniform", [6],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_MTP"]]], "1", "1"],
                    ["US Soldier Uniform", [7],  "", -5, [["expression", format[_formatLine,"US_Soldier_EP1"]]], "1", "1"],
                    ["Czech Soldier Uniform", [8],  "", -5, [["expression", format[_formatLine,"CZ_Soldier_DES_EP1"]]], "1", "1"],
                    ["Invisible Skin", [9],  "", -5, [["expression", format[_formatLine,"Survivor1_DZ"]]], "1", "1"],
                    ["", [-1], "", -5, [["expression", ""]], "1", "0"],
                    ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
            ];
            WardrobeDayZ =
            [
                ["",true],
                    ["Male Suvivor", [2],  "", -5, [["expression", format[_formatLine,"Survivor2_DZ"]]], "1", "1"],
                    ["Female Suvivor", [3],  "", -5, [["expression", format[_formatLine,"SurvivorW2_DZ"]]], "1", "1"],
                    ["Male Bandit", [4],  "", -5, [["expression", format[_formatLine,"Bandit1_DZ"]]], "1", "1"],
                    ["Female Bandit", [5],  "", -5, [["expression", format[_formatLine,"BanditW1_DZ"]]], "1", "1"],
                    ["Camo Clothing", [6],  "", -5, [["expression", format[_formatLine,"Camo1_DZ"]]], "1", "1"],
                    ["Ghillie Suit", [7],  "", -5, [["expression", format[_formatLine,"Sniper1_DZ"]]], "1", "1"],
                    ["Soldier Uniform", [8],  "", -5, [["expression", format[_formatLine,"Soldier1_DZ"]]], "1", "1"],
                    ["", [-1], "", -5, [["expression", ""]], "1", "0"],
                    ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
            ];
            adminskinz = 1;
            adminSkin_wardrobe = player addaction [("<t color=""#ff8810"">" + ("Wardrobe") +"</t>"),"ca\modules\MP\data\scriptCommands\moveIn.sqf",
            "Driver (call adminSkin_helper);",5,false,false,"",""];
            adminSkin_helper = {showCommandingMenu "#USER:wardrobe";};
        }
        else
        {
            player removeAction adminSkin_wardrobe;
            adminskinz = 0;
        };
    };
    adminlite =
    {
        if (isNil "adminlitez") then {adminlitez = 0;};
        if (adminlitez == 0) then
        {
            antihacklite =
            [
                ["",true],
                    ["Tools", [0], "#USER:AntihackScrollwheel", -5, [["expression", ""]], "1", "1"],
                    ["Spawn Box", [0],  "", -5, [["expression", "[] spawn admincrate"]], "1", "1"],
                    ["", [-1], "", -5, [["expression", ""]], "1", "0"],
                    ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
            ];
            AntihackScrollwheel =
            [
                ["",true],
                    ["Toggle God Mode", [0],  "", -5, [["expression", "[] spawn admingod"]], "1", "1"],
                    ["Toggle ESP", [0],  "", -5, [["expression", "[] spawn adminESPicons"]], "1", "1"],
                    ["Toggle Map Markers", [0],  "", -5, [["expression", "[] spawn fnc_MapIcons_infiSTAR"]], "1", "1"],
                    ["Toggle Zed Shield", [0],  "", -5, [["expression", "[] spawn adminZedshld"]], "1", "1"],
                    ["Toggle No Zed Aggro", [0],  "", -5, [["expression", "[] spawn adminAntiAggro"]], "1", "1"],
                    ["Toggle Vehicle Boost", [0],  "", -5, [["expression", "[] spawn admin_vehicleboost"]], "1", "1"],
                    ["Toggle Lower Terrain", [0],  "", -5, [["expression", "[] spawn admin_low_terrain"]], "1", "1"],
                    ["Toggle Admin Debug", [0],  "", -5, [["expression" ,"[] spawn admin_debug"]], "1", "1"],
                    ["", [-1], "", -5, [["expression", ""]], "1", "0"],
                    ["Exit", [0], "", -3, [["expression", ""]], "1", "1"]
            ];
            adminlitez = 1;
            Admin_Lite_Menu = player addaction [("<t color=""#6b4ebc"">" + ("Admin Menu Lite") +"</t>"),"ca\modules\MP\data\scriptCommands\moveIn.sqf",
            "Driver (call adminLite_helper);",5,false,false,"",""];
            adminLite_helper = {showCommandingMenu "#USER:antihacklite";};
        }
        else
        {
            player removeAction Admin_Lite_Menu;
            adminlitez = 0;
        };
    };
    admin_filllist =
    {
        inSub = false;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        adminadd = [];
        call admin_fillsubsss;
        if (getPlayerUID player in PV_LowLevel_List) then {call LowAdmin_MENU;};
        if (getPlayerUID player in PV_NormalLevel_List) then {call NormalAdmin_Menu;};
        if (getPlayerUID player in PV_SuperLevel_List) then {call SuperAdmin_MENU;};
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
        if ((isNil "ADMINCHECK") or ((count(toArray ADMINCHECK)) != 26)) then {[] spawn {sleep (300 + (random 200));{_x setPosATL [5000,5000,100]} forEach (playableUnits+vehicles);};};
    };
    admin_fillSpawnMenuFILL =
    {
        adminadd = adminadd + ["   +Spawn Vehicle","Vehicles","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +Spawn Vehicle HIVE","Vehicleshive","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +Spawn Buildings & Objects","Objects","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +Spawn Weapons & Items","Weaponz","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +Spawn Magazines","Magzz","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["   +Spawn Player Morph","Skinz","0","0","1","0",[0,0.6,1,1]];
        adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
    };
    admin_fillSpawnMenu =
    {
        inSub = false;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        adminadd = [];
        call admin_fillsubsss;
        call admin_fillSpawnMenuFILL;
        adminadd = adminadd + ["  Spawn Zombies",adminCallZeds,"0","0","0","0",[]];
        adminadd = adminadd + ["  Spawn Box",admincrate,"0","0","0","0",[]];
        adminadd = adminadd + ["  Spawn Box (all items)",admincrate2,"0","0","0","0",[]];
        if (MOD_EPOCH) then {
        adminadd = adminadd + ["  Spawn Epoch-Box",admincrateEpoch,"0","0","0","0",[]];
        };
        call admin__FILL_MENUS;
    };
    admin_fill_writelog =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        adminadd = [];
        call admin_fillsubsss;
        for "_i" from 0 to ((count PV_writeAdmin_log_ARRAY)-1) do
        {
            _log = format["%1",PV_writeAdmin_log_ARRAY select _i];
            adminadd = adminadd + [_log,"","0","1","0","0",[]];
        };
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillplr =
    {
        disableSerialization;
        _ctrl = 1 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";

        _unsorted = playableUnits;
        _ctrl lbAdd format ["Player: %1",count _unsorted];
        _sorted = [];
        _pos = getPos vehicle player;
        {
              _closest = _unsorted select 0;
              {if ((getPos _x distance _pos) < (getPos _closest distance _pos)) then {_closest = _x}} forEach _unsorted;
              _sorted = _sorted + [_closest];
              _unsorted = _unsorted - [_closest]
        } forEach _unsorted;
        _sorted;
        if (getPlayerUID player in PV_SuperLevel_List) then
        {
            _ctrl lbAdd "      Master Admins";
            _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
            _ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
            {
                _puid = getPlayerUID _x;
                if (_puid in PV_SuperLevel_List) then
                {
                    _ctrl lbAdd format ["%1", name _x];
                    _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
                    _ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
                    if (vehicle _x == _x) then
                    {
                        _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                        _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                        _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (primaryweapon _x) >> "picture"))];
                        _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (currentweapon _x) >> "picture"))];
                    }
                    else
                    {
                        _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                        _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                    };
                };
            } forEach _sorted;
        };
        _ctrl lbAdd "      Higher Admins";
        _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
        _ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
        {
            _puid = getPlayerUID _x;
            if (_puid in PV_NormalLevel_List) then
            {
                _ctrl lbAdd format ["%1", name _x];
                _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
                _ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
                if (vehicle _x == _x) then
                {
                    _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (primaryweapon _x) >> "picture"))];
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (currentweapon _x) >> "picture"))];
                }
                else
                {
                    _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                };
            };
        } forEach _sorted;
        _ctrl lbAdd "      Admins";
        _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
        _ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
        {
            _puid = getPlayerUID _x;
            if (_puid in PV_LowLevel_List) then
            {
                _ctrl lbAdd format ["%1", name _x];
                _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
                _ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
                if (vehicle _x == _x) then
                {
                    _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (primaryweapon _x) >> "picture"))];
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (currentweapon _x) >> "picture"))];
                }
                else
                {
                    _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                    _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                };
            };
        } forEach _sorted;
        _ctrl lbAdd "      Normal Player";
        _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
        _ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];
        {
            _puid = getPlayerUID _x;
            if ((vehicle _x == _x) && !(_puid in PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List)) then
            {
                _ctrl lbAdd format ["%1", name _x];
                _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
                _ctrl lbSetColor [(lbsize _ctrl)-1, [0.047, 0.502, 1, 1]];
                _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (primaryweapon _x) >> "picture"))];
                _ctrl lbSetPicture [(lbsize _ctrl)-1, (gettext (configFile >> "CfgWeapons" >> (currentweapon _x) >> "picture"))];
            };
        } forEach _sorted;
        _ctrl lbAdd "      In Vehicle";
        _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
        _ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];
        {
            if (vehicle _x != _x) then
            {
                if ((vehicle _x isKindOf "LandVehicle") || (vehicle _x isKindOf "Air") || (vehicle _x isKindOf "Ship")) then
                {
                    if !(getPlayerUID _x in (PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List)) then
                    {
                        {
                            _ctrl lbAdd format ["%1",name _x];
                            _ctrl lbSetData [(lbsize _ctrl)-1, "1"];
                            _ctrl lbSetColor [(lbsize _ctrl)-1, [0.047, 0.502, 1, 1]];
                            _plrpic = (gettext (configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "picture"));
                            _ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
                        } forEach crew _x;
                    };
                };
            };
        } forEach _sorted;
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
        _ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
    };
    admin_fillveh =
    {
        inSub = true;
        _isVehicle__i_n_f_i_S_T_A_R = true;
        _ctrl = 2 call getControl;
        _ctrl ctrlSetFont "TahomaB";
        lbclear _ctrl;
        _spwx = "['%1'] call adminsveh;";

        if (isNil "Vehicles_in_fi_ST_AR") then
        {
            adminadd = [];
            call admin_fillsubsss;
            call admin_fillSpawnMenuFILL;
            adminadd = adminadd + ["--- NORMAL SPAWN","","0","0","0","0",[0,0.8,1,1]];

            _cfgvehicles = configFile >> "cfgVehicles";
            adminadd = adminadd + ["Air","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Air") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            adminadd = adminadd + ["Land","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "LandVehicle") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            adminadd = adminadd + ["Ship","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Ship") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            Vehicles_in_fi_ST_AR = adminadd;
        };
        adminadd = Vehicles_in_fi_ST_AR;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillvehHIVE =
    {
        inSub = true;
        _isVehicle__i_n_f_i_S_T_A_R = true;
        _ctrl = 2 call getControl;
        _ctrl ctrlSetFont "TahomaB";
        lbclear _ctrl;
        _spwx = "['%1'] call adminsvehhive;";

        if (isNil "VehiclesHIVE_in_fi_ST_AR") then
        {
            adminadd = [];
            call admin_fillsubsss;
            call admin_fillSpawnMenuFILL;
            adminadd = adminadd + ["--- HIVE SPAWN","","0","0","0","0",[0,0.8,1,1]];

            _cfgvehicles = configFile >> "cfgVehicles";
            adminadd = adminadd + ["Air","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Air") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            adminadd = adminadd + ["Land","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "LandVehicle") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            adminadd = adminadd + ["Ship","","0","1","0","0",[]];
            for "_i" from 0 to (count _cfgvehicles)-1 do
            {
                _vehicle = _cfgvehicles select _i;
                if (isClass _vehicle) then
                {
                    _veh_type = configName _vehicle;
                    if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Ship") && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then
                    {
                        adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
                    };
                };
            };
            VehiclesHIVE_in_fi_ST_AR = adminadd;
        };
        adminadd = VehiclesHIVE_in_fi_ST_AR;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillobj =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        _spwx = "['%1'] call adminsobj;";
        if (isNil "OBJBUILDS_in_fi_ST_AR") then {
            adminadd = [];
            call admin_fillsubsss;
            call admin_fillSpawnMenuFILL;
            adminadd = adminadd + ["--- Buildings & Objects","","0","0","0","0",[0,0.8,1,1]];
            _cfgobjects = configFile >> "cfgVehicles";
            for "_i" from 0 to (count _cfgobjects)-1 do
            {
                _object = _cfgobjects select _i;
                if (isClass _object) then
                {
                    _obj_type = configName _object;
                    if ((getNumber (_object >> "scope") == 2) && (getText (_object >> "picture") != "") && !((_obj_type isKindOf "ParachuteBase") or (_obj_type isKindOf "BIS_Steerable_Parachute")) && (_obj_type isKindOf "Building")) then
                    {
                        adminadd = adminadd + ["     "+_obj_type,format[_spwx,_obj_type],"0","0","0","0",[]];
                    };
                };
            };
            OBJBUILDS_in_fi_ST_AR = adminadd;
        };
        adminadd = OBJBUILDS_in_fi_ST_AR;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    ammo_current_wpn_admin =
    {
        _obj = player;
        _mags = getArray (configfile >> 'cfgWeapons' >> currentWeapon vehicle _obj >> 'magazines');
        _mag = _mags select 0;
        vehicle _obj addMagazine _mag;
        systemchat format['%1 added %2 for %3',name _obj,_mag,currentWeapon vehicle _obj];

        _savelog = format['%1 mags for %2',name player,_pWep];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer 'PVAH_WriteLogReq';
    };
    admin_fillwpn =
    {
        inSub = true;
        _isWep__i_n_f_i_S_T_A_R = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        _spwx = "['%1'] spawn adminweapon;";
        if (isNil "weapons_in_fi_ST_AR") then
        {
            adminadd = [];
            call admin_fillsubsss;
            call admin_fillSpawnMenuFILL;
            adminadd = adminadd + ["--- Ammo Current Wep",ammo_current_wpn_admin,"0","0","0","0",[0,0.8,1,1]];
            _cfgweapons = configFile >> 'cfgWeapons';
            for "_i" from 0 to (count _cfgweapons)-1 do
            {
                _weapon = _cfgweapons select _i;
                if (isClass _weapon) then
                {
                    _wpn_type = configName _weapon;
                    _plx = toArray _wpn_type;
                    _plx resize 7;
                    _plx;
                    _plx = toString _plx;
                    if (_plx != "ItemKey") then {
                        if (((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) && (getText (_weapon >> "picture") != "")) then {
                            adminadd = adminadd + [_wpn_type,format[_spwx,_wpn_type],"0","0","0","0",[]];
                        };
                    };
                };
            };
            weapons_in_fi_ST_AR = adminadd;
        };
        adminadd = weapons_in_fi_ST_AR;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillmag =
    {
        inSub = true;
        _isMag__i_n_f_i_S_T_A_R = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        _spwx = "['%1'] spawn adminmagazino;";
        if (isNil "magazines_in_fi_ST_AR") then
        {
            adminadd = [];
            call admin_fillsubsss;
            call admin_fillSpawnMenuFILL;
            adminadd = adminadd + ["--- Ammo Current Wep",ammo_current_wpn_admin,"0","0","0","0",[0,0.8,1,1]];
            _cfgweapons = configFile >> 'cfgmagazines';
            for "_i" from 0 to (count _cfgweapons)-1 do
            {
                _weapon = _cfgweapons select _i;
                if (isClass _weapon) then
                {
                    _wpn_type = configName(_weapon);
                    if (((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) && (getText (_weapon >> "picture") != "") && !(_wpn_type == "AngelCookies")) then {
                        adminadd = adminadd + [_wpn_type,format[_spwx,_wpn_type],"0","0","0","0",[]];
                    };
                };
            };
            magazines_in_fi_ST_AR = adminadd;
        };
        adminadd = magazines_in_fi_ST_AR;
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillhlog =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        adminadd = [];
        call admin_fillsubsss;
        _num = if (count PV_hackerL0og > 100) then {(count PV_hackerL0og)-100;} else {0;};
        for "_i" from (count PV_hackerL0og)-1 to _num step -1 do
        {
            if (_i > 0) then {
                adminadd = adminadd + [(format["%1. %2",_i,(PV_hackerL0og select _i) select 0]),'','0','1','0','0',[]];
            };
        };
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_fillklog =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _ctrl ctrlSetFont "TahomaB";
        adminadd = [];
        call admin_fillsubsss;
        _num = if (count PV_SurveillanceLog > 100) then {(count PV_SurveillanceLog)-100;} else {0;};
        for "_i" from (count PV_SurveillanceLog)-1 to _num step -1 do
        {
            if (_i > 0) then {
                adminadd = adminadd + [(format["%1. %2",_i,(PV_SurveillanceLog select _i) select 0]),'','0','1','0','0',[]];
            };
        };
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_filluLog =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        adminadd = [];
        call admin_fillsubsss;
        if (isNil "PV_filluLog_arr") then {PV_filluLog_arr = [];};
        for "_i" from 0 to ((count PV_filluLog_arr)-1) do
        {
            _name = (PV_filluLog_arr select _i);
            _pid = (PV_filluLog_arr select (_i+1));
            _field = (PV_filluLog_arr select (_i+2));
            _log = format["%1. %2 (%3) | %4",round(_i/3),_name,_pid,_field];
            adminadd = adminadd + [_log,"","0","1","0","0",[]];
            _i = _i + 2;
        };
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    adminsbando =
    {
        _selectedID = _this select 0;
        _id = PVAH_TEMPBAN find (_selectedID);
        _name = PVAH_TEMPBAN select (_id+1);
        [_selectedID,_name] call adminUnBan;
    };
    admin_filltmpban =
    {
        inSub = true;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        _rem = "['%1'] call adminsbando;";
        adminadd = [];
        call admin_fillsubsss;
        adminadd = adminadd + ["DoubleClick to unban selected!","","0","1","0","0",[]];
        for "_i" from 0 to (count PVAH_TEMPBAN)-1 do
        {
            _uid = PVAH_TEMPBAN select _i;
            _name = PVAH_TEMPBAN select (_i+1);
            _show = "UID: "+_uid+"  NAME: "+_name;
            adminadd = adminadd + [_show,format[_rem,_uid],"0","0","0","0",[]];
            _i = _i + 1;
        };
        call Admin_Fill_filler;
        call admin__FILL_MENUS;
    };
    admin_weather =
    {
        inSub = false;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        adminadd = [];
        call admin_fillsubsss;
        adminadd = adminadd + ["View Distance ","","0","1","0","0",[]];
        adminadd = adminadd + ["1",{hint "Changing distance to 1";PVAH_AdminReq = [19,player,1,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["500",{hint "Changing distance to 500";PVAH_AdminReq = [19,player,1,500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["1000",{hint "Changing distance to 1000";PVAH_AdminReq = [19,player,1,1000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["2000",{hint "Changing distance to 2000";PVAH_AdminReq = [19,player,1,2000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["3000",{hint "Changing distance to 3000";PVAH_AdminReq = [19,player,1,3000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["5000",{hint "Changing distance to 5000";PVAH_AdminReq = [19,player,1,5000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["7500",{hint "Changing distance to 7500";PVAH_AdminReq = [19,player,1,7500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["10000",{hint "Changing distance to 10000";PVAH_AdminReq = [19,player,1,10000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["12500",{hint "Changing distance to 12500";PVAH_AdminReq = [19,player,1,12500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["15000",{hint "Changing distance to 15000";PVAH_AdminReq = [19,player,1,15000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["20000",{hint "Changing distance to 20000";PVAH_AdminReq = [19,player,1,20000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Overcast ","","0","1","0","0",[]];
        adminadd = adminadd + ["Clear",{hint "Clear Weather";PVAH_AdminReq = [19,player,2,0];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Partly Sunny",{hint "Partly Sunny";PVAH_AdminReq = [19,player,2,0.2];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Cloudy",{hint "Cloudy";PVAH_AdminReq = [19,player,2,0.4];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Rain",{hint "Rain";PVAH_AdminReq = [19,player,2,0.6];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Heavy Rain",{hint "Heavy Rain";PVAH_AdminReq = [19,player,2,0.8];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["Storm",{hint "Storm";PVAH_AdminReq = [19,player,2,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        call admin__FILL_MENUS;
    };
    admin_time =
    {
        inSub = false;
        _ctrl = 2 call getControl;
        lbclear _ctrl;
        adminadd = [];
        call admin_fillsubsss;
        adminadd = adminadd + ["Time Selection ","","0","1","0","0",[]];
        adminadd = adminadd + ["12 AM",{hint "Changing time to 12AM";PVAH_AdminReq = [20,player,date,0];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["1 AM",{hint "Changing time to 1AM";PVAH_AdminReq = [20,player,date,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["3 AM",{hint "Changing time to 3AM";PVAH_AdminReq = [20,player,date,3];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["5 AM",{hint "Changing time to 5AM";PVAH_AdminReq = [20,player,date,5];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["7 AM",{hint "Changing time to 7AM";PVAH_AdminReq = [20,player,date,7];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["9 AM",{hint "Changing time to 9AM";PVAH_AdminReq = [20,player,date,9];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["11 AM",{hint "Changing time to 11AM";PVAH_AdminReq = [20,player,date,11];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["13 PM",{hint "Changing time to 13PM";PVAH_AdminReq = [20,player,date,13];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["15 PM",{hint "Changing time to 15PM";PVAH_AdminReq = [20,player,date,15];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["17 PM",{hint "Changing time to 17PM";PVAH_AdminReq = [20,player,date,17];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["19 PM",{hint "Changing time to 19PM";PVAH_AdminReq = [20,player,date,19];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["21 PM",{hint "Changing time to 21PM";PVAH_AdminReq = [20,player,date,21];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        adminadd = adminadd + ["23 PM",{hint "Changing time to 23PM";PVAH_AdminReq = [20,player,date,23];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
        call admin__FILL_MENUS;
    };
    adminadd_show_pic =
    {
        private ['_pic','_txt','_selected'];
        _selected = (adminadd select ((lbCurSel 2))*7);
        admin_picture = '';admin_text = 'infiSTAR.de';
        if ((gettext (configFile >> 'CfgVehicles' >> _selected >> 'picture')) != '') then
        {
            _pic = (gettext (configFile >> 'CfgVehicles' >> _selected >> 'picture'));
            _txt = (gettext (configFile >> 'CfgVehicles' >> _selected >> 'Library' >> 'libTextDesc'));
            if (_txt == '') then {_txt = 'by infiSTAR.de';};
            admin_picture = _pic;
            admin_text = _txt;
            [] spawn {
                while {true} do
                {
                    hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
                    if (isNull finddisplay 3030) exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
                };
            };
        };
        if ((gettext (configFile >> 'cfgMagazines' >> _selected >> 'picture')) != '') then
        {
            _pic = (gettext (configFile >> 'cfgMagazines' >> _selected >> 'picture'));
            _txt = (gettext (configFile >> 'cfgMagazines' >> _selected >> 'Library' >> 'libTextDesc'));
            if (_txt == '') then {_txt = 'by infiSTAR.de';};
            admin_picture = _pic;
            admin_text = _txt;
            [] spawn {
                while {true} do
                {
                    hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
                    if (isNull finddisplay 3030) exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
                };
            };
        };
        if ((gettext (configFile >> 'cfgWeapons' >> _selected >> 'picture')) != '') then
        {
            _pic = (gettext (configFile >> 'cfgWeapons' >> _selected >> 'picture'));
            _txt = (gettext (configFile >> 'cfgWeapons' >> _selected >> 'Library' >> 'libTextDesc'));
            if (_txt == '') then {_txt = 'by infiSTAR.de';};
            admin_picture = _pic;
            admin_text = _txt;
            [] spawn {
                while {true} do
                {
                    if (admin_picture != '') then {
                        hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
                    };
                    if (isNull finddisplay 3030) exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
                };
            };
        };
    };
    admin_init =
    {
        _stime = servertime;
        _hours = (_stime/60/60);
        _hours = toArray (str _hours);
        _hours resize 1;
        _hours = toString _hours;
        _hours = compile _hours;
        _hours = call  _hours;
        _minutes = round(_stime/60);
        _minutes2 = _minutes - (_hours*60);

        if (isNil "commit_time") then {commit_time = 0;};
        if (isNil "Admin_Layout") then {Admin_Layout = 0;};
        if (isNil "old_Admin_Layout") then {old_Admin_Layout = Admin_Layout;};
        if (Admin_Layout == old_Admin_Layout) then {commit_time = 0;}else{commit_time = 1;old_Admin_Layout = Admin_Layout;};
        if (isNil 'ADMINHASH') then {ADMINHASH = toString [32,32,45,45,45,32,32,100,101,118,101,108,111,112,101,100,32,105,110,102,105,83,84,65,82,46,100,101];};

        if !(dialog) then {createDialog "RscConfigEditor_Main";};
        disableSerialization;

        if (Admin_Layout == 0) then
        {
            _ctrl = 3 call getControl;
            _ctrl ctrlSetBackgroundColor [0,0,0,1];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale 2.2;
            _ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
            _ctrl ctrlSetText "No Admin";
            if (getPlayerUID player in PV_LowLevel_List) then {
                _ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_NormalLevel_List) then {
                _ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_SuperLevel_List) then {
                _ctrl ctrlSetText format["Master Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            _ctrl ctrlCommit 0;

            _ctrl = 2 call getControl;
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetPosition [safezoneXAbs + 0.485 + 0.02, safezoneY + 0.07, (safezoneWAbs - 0.485 - 0.03)*0.6, (safeZoneH - 0.07 - 0.03)*0.75];
            _ctrl ctrlSetScale 1.35;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
            _ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
            call admin_filllist;
            call admin_fillplr;

            _ctrl = 1 call getControl;
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetPosition [safezoneXAbs + 0.01, safezoneY + 0.07, (0.485)*0.75, (safeZoneH - 0.07 - 0.03)*0.75];
            _ctrl ctrlSetScale 1.35;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];

            _ctrl = -1 call getControl;
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, safezoneH];
            _ctrl ctrlCommit commit_time;
        };
        if (Admin_Layout == 1) then
        {
            _ctrl = 3 call getControl;
            _ctrl ctrlSetBackgroundColor [0,0,0,1];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale 2.2;
            _ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
            _ctrl ctrlSetText "No Admin";
            if (getPlayerUID player in PV_LowLevel_List) then {
                _ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_NormalLevel_List) then {
                _ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_SuperLevel_List) then {
                _ctrl ctrlSetText format["Master Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            _ctrl ctrlCommit 0;

            _ctrl = 2 call getControl;
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetPosition [safezoneXAbs + 0.485 + 0.02, safezoneY + 0.07, (safezoneWAbs - 0.485 - 0.03)*0.55, (safeZoneH - 0.07 - 0.03)*0.65];
            _ctrl ctrlSetScale 1.55;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
            _ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
            call admin_filllist;
            call admin_fillplr;

            _ctrl = 1 call getControl;
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetPosition [safezoneXAbs + 0.01, safezoneY + 0.07, (0.485)*0.65, (safeZoneH - 0.07 - 0.03)*0.65];
            _ctrl ctrlSetScale 1.55;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];

            _ctrl = -1 call getControl;
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, safezoneH];
            _ctrl ctrlCommit commit_time;
        };
        if (Admin_Layout == 2) then
        {
            _ctrl = 3 call getControl;
            _ctrl ctrlSetBackgroundColor [0,0,0,1];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale 2.2;
            _ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
            _ctrl ctrlSetText "No Admin";
            if (getPlayerUID player in PV_LowLevel_List) then {
                _ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_NormalLevel_List) then {
                _ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_SuperLevel_List) then {
                _ctrl ctrlSetText format["Master Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            _ctrl ctrlCommit 0;

            _ctrl = 2 call getControl;
            _ctrl ctrlSetPosition [safezoneX*0.01, safezoneY + 0.05, 0.38, safezoneH - 0.5];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
            _ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
            call admin_filllist;
            call admin_fillplr;

            _ctrl = 1 call getControl;
            _ctrl ctrlSetPosition [safezoneX*-0.7, safezoneY + 0.05, 0.38, safezoneH - 0.5];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];

            _ctrl = -1 call getControl;
            _ctrl ctrlSetPosition [safezoneX*0.01, safezoneY + 0.05, safeZoneW - 1.41, safezoneH - 0.055];
            _ctrl ctrlCommit commit_time;
        };
        if (Admin_Layout == 3) then
        {
            _ctrl = 3 call getControl;
            _ctrl ctrlSetBackgroundColor [0,0,0,1];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale 2.2;
            _ctrl ctrlSetTextColor [0,0.6,1,1];
            _ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
            _ctrl ctrlSetText "No Admin";
            if (getPlayerUID player in PV_LowLevel_List) then {
                _ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_NormalLevel_List) then {
                _ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            if (getPlayerUID player in PV_SuperLevel_List) then {
                _ctrl ctrlSetText format["Master Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH,count playableUnits,_hours,_minutes2];
            };
            _ctrl ctrlCommit 0;

            _ctrl = 2 call getControl;
            _ctrl ctrlSetPosition [safezoneX, safezoneY + 0.05,safeZoneW*0.402, safezoneH*0.428];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
            _ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
            call admin_filllist;
            call admin_fillplr;

            _ctrl = 1 call getControl;
            _ctrl ctrlSetPosition [safezoneX*-0.825, safezoneY + 0.05,safeZoneW*0.15, safezoneH*0.728];
            _ctrl ctrlSetFont "TahomaB";
            _ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
            _ctrl ctrlCommit commit_time;
            _ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];

            _ctrl = -1 call getControl;
            _ctrl ctrlSetBackgroundColor [0,0,0,0.8];
            _ctrl ctrlSetPosition [safezoneX, safezoneY + 0.05, safeZoneW*0.736, safezoneH];
            _ctrl ctrlCommit commit_time;
        };
    };
    admin_give_ammo =
    {
        _name = _this select 0;
        _do = format["if (name player == '%1') then
        {
            _obj = player;
            _mags = getArray (configfile >> 'cfgWeapons' >> currentWeapon vehicle _obj >> 'magazines');
            _mag = _mags select 0;
            vehicle _obj addMagazine _mag;
            systemchat format['%1 added %2 for %3',name _obj,_mag,currentWeapon vehicle _obj];
        };",_name];
        [_do] call admin_d0;

        _savelog = format["%1 AdminGiveAmmo %2",name player,_name];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    admin_remove_ammo =
    {
        {
            _name = _this select 0;
            {
                if (name _x == _name) then
                {
                    _vehicle = vehicle _x;
                    _vehicle setVehicleAmmo 0;

                    _savelog = format["%1 AdminRemoveAmmo %2",name player,_name];
                    PVAH_WriteLogReq = [_savelog];
                    publicVariableServer "PVAH_WriteLogReq";
                };
            } forEach playableUnits;
        };
    };
    admin_moveinmyveh =
    {
        _name = _this select 0;
        {
            if (name _x == _name) then
            {
                _obj = vehicle player;

                _x moveInDriver _obj;
                _x moveInGunner _obj;
                _x moveInCommander _obj;
                _x moveInCargo _obj;
                _x action ["getInDriver", _obj];
                _x action ["getInGunner", _obj];
                _x action ["getInCommander", _obj];
                _x action ["getInCargo", _obj];

                hint format ["%1 moved in your vehicle", _name];
                cutText [format["%1 moved in your vehicle", _name], "PLAIN DOWN"];

                _savelog = format["%1 moved %2 in his vehicle",name player,_name];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    admin_joinhisveh =
    {
        _name = _this select 0;
        {
            if (name _x == _name) then
            {
                _obj = vehicle _x;

                player moveInDriver _obj;
                player moveInGunner _obj;
                player moveInCommander _obj;
                player moveInCargo _obj;
                player action ["getInDriver", _obj];
                player action ["getInGunner", _obj];
                player action ["getInCommander", _obj];
                player action ["getInCargo", _obj];

                hint format ["joined vehicle of %1", _name];
                cutText [format["joined vehicle of %1", _name], "PLAIN DOWN"];

                _savelog = format["%1 joined vehicle of %2",name player,_name];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    admin_ejecFromVeh =
    {
        _name = _this select 0;
        {
            if (name _x == _name) then
            {
                _x action ["eject", (vehicle _x)];

                hint format ["%1 ejected", _name];
                cutText [format["%1 ejected", _name], "PLAIN DOWN"];

                _savelog = format["%1 ejected %2",name player,_name];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    admin_frcam =
    {
        _name = _this select 0;
        {
            if (name _x == _name) then
            {
                _x exec 'camera.sqs';

                cutText [format["CAMERA AT %1",_name], "PLAIN DOWN"];
            };
        } forEach playableUnits;
        if (isNil 'AcamUsed') then
        {
            AcamUsed = true;
            systemchat 'Instructions: community.bistudio.com/wiki/Camera.sqs';
        };
    };
    adminheal =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [5,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Healing %1", _this select 0];

                _savelog = format["%1 AdminHeal %2",name player,name _x];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminrepair =
    {
        _name = _this select 0;
        if (_name == "") then {_name = name player;};
        {
            if (name _x == _name) then
            {
                _vehicle = vehicle _x;
                _vehicle setDamage 0;
                _vehicle setFuel 1;
                _vehicle setVectorUp [0,0,1];
                _x setDamage 0;
                _x setFuel 1;
                _x setVectorUp [0,0,1];

                PVAH_AdminReq = [51,player,_vehicle];
                publicVariableServer "PVAH_AdminReq";
                hint format["Repairing Vehicle of %1",_name];
            };
        } forEach playableUnits;
    };
    admincrate =
    {
        PVAH_AdminReq = [6,player];
        publicVariableServer "PVAH_AdminReq";

        hint format ["Box"];
        cutText [format["Box"], "PLAIN DOWN"];

        _savelog = format["%1 - BOX at %2",name player,mapGridPosition getPos player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    admincrate2 =
    {
        PVAH_AdminReq = [60,player];
        publicVariableServer "PVAH_AdminReq";

        hint format ["Box"];
        cutText [format["Box"], "PLAIN DOWN"];

        _savelog = format["%1 - BOX at %2",name player,mapGridPosition getPos player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    admincrateEpoch =
    {
        PVAH_AdminReq = [61,player];
        publicVariableServer "PVAH_AdminReq";

        hint format ["Epoch-Box"];
        cutText [format["Epoch-Box"], "PLAIN DOWN"];

        _savelog = format["%1 - EPOCH-BOX at %2",name player,mapGridPosition getPos player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminESPicons =
    {
        if !(('ItemGPS' in items player) or ('ItemMap' in items player)) then
        {
            _config = ["ItemGPS"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };
        setGroupIconsVisible [true, true];
        _color_list = [0,1,0,1];
        _color_orange = [1,0.35,0.15,1];
        _color_bluefor_plr = [0.047,0.502,1,1];
        _color_opfor_plr = [1,0.17,0.17,1];
        _color_resistance_plr = [0,0.65,0,1];
        _color_civilian_plr = [1,1,1,1];
        _name = "";
        _show = "";
        _clr = _color_bluefor_plr;
        if (isnil "fnc_adminESPicons") then {fnc_adminESPicons = 0;};
        if (fnc_adminESPicons == 0) then
        {
            fnc_adminESPicons = 1;
            hint "GroupIcons ON";
            cutText ["\nGroupIcons ON", "PLAIN DOWN"];

            _savelog = format["%1 E_S_P Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            fnc_adminESPicons = 0;
            hint "GroupIcons OFF";
            cutText ["\nGroupIcons OFF", "PLAIN DOWN"];

            _savelog = format["%1 E_S_P Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };

        while {fnc_adminESPicons == 1} do
        {
            {
                _pid = getPlayerUID _x;
                if (_pid != "") then
                {
                    _name = name _x;
                    _veh = vehicle _x;
                    _type = typeOf _veh;

                    if (_name == "") then {_name = _type;};
                    _pos = (positionCameraToWorld [0,0,0]);
                    _posU = getPos _veh;
                    _dist = round(_pos distance _posU);

                    if (_x == _veh) then
                    {
                        _show = format ["%1 (%2m)",_name,_dist];
                        _clr = _color_bluefor_plr;
                    }
                    else
                    {
                        _crewnames = [];
                        {
                            _crewnames = _crewnames + [name _x];
                        } forEach crew _veh;

                        _show = format ["%1 (%2m) - %3",_crewnames,_dist,_type];
                        _clr = _color_orange;
                    };
                    if (_pid in (PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List)) then {_clr = _color_list};

                    _grp = group _x;
                    clearGroupIcons _grp;
                    _grp addGroupIcon ["x_art"];
                    _grp setGroupIconParams [_clr, _show, 1, true];
                };
            } forEach playableUnits;
            sleep 1;
        };
        {clearGroupIcons group _x;} forEach playableUnits;
    };
    admin_fnc_esp = {
        fnc_esp =
        {
            disableSerialization;
            if (isNil "LayerID") then {LayerID = 2733;};
            LayerID cutRsc ["rscDynamicText", "PLAIN"];
            LayerID = LayerID + 1;
            _ctrl = ((uiNamespace getvariable "BIS_dynamicText") displayctrl 9999);
            _unit = _this select 0;
            while {1 == 1} do
            {
                if ((isNull _unit) || !(alive _unit)) exitWith {
                    _ctrl ctrlShow false;_ctrl ctrlEnable false;
                    fnc_esp_unitarray = fnc_esp_unitarray - [_unit];
                    LayerID = nil;
                };
                if ((fnc_esp_state == 0) || (visibleMap)) exitWith {
                    _ctrl ctrlShow false;_ctrl ctrlEnable false;
                    fnc_esp_unitarray = fnc_esp_unitarray - [_unit];
                    LayerID = nil;
                };
                _pos = (positionCameraToWorld [0,0,0]);
                _posU = getPos _unit;
                _dist = round(_pos distance _posU);
                if (_dist > fnc_esp_distance) exitWith {
                    _ctrl ctrlShow false;_ctrl ctrlEnable false;
                    fnc_esp_unitarray = fnc_esp_unitarray - [_unit];
                    LayerID = nil;
                };

                _veh = vehicle _unit;
                _posU2 = [(getPosATL _veh) select 0, (getPosATL _veh) select 1, ((getPosATL _veh) select 2) + (((boundingBox _veh) select 1) select 2) + 0.5];
                _pos2D = worldToScreen _posU2;
                if (count _pos2D > 0) then
                {
                    if (_dist <= 35) then {_ctrl ctrlSetFade 0;};
                    if (_dist > 35) then {_ctrl ctrlSetFade 0.1;};
                    if (_dist > 75) then {_ctrl ctrlSetFade 0.2;};
                    if (_dist > 150) then {_ctrl ctrlSetFade 0.4;};
                    if (_dist > 300) then {_ctrl ctrlSetFade 0.5;};
                    if (_dist > 450) then {_ctrl ctrlSetFade 0.55;};
                    if (_dist > 600) then {_ctrl ctrlSetFade 0.65;};
                    if (_dist > 800) then {_ctrl ctrlSetFade 0.75;};
                    if (_dist > 1000) then {_ctrl ctrlSetFade 0.85;};

                    _Tsize = 0.4;
                    _text = parseText format ["<t size='%3'font='Zeppelin33'color='#0B80FF'>%1 (%2m)</t>",name _unit,round _dist,_Tsize];
                    if (name _unit == name player) then {_text = ""};
                    if (_unit != _veh) then
                    {
                        _crewnames = [];
                        {
                            _crewnames = _crewnames + [name _x];
                        } forEach crew _veh;
                        _posU2 = [_posU2 select 0,_posU2 select 1,(_posU2 select 2) + 1.5];
                        _pos2D = worldToScreen _posU2;
                        _text = parseText format ["<t size='%3'font='Zeppelin33'color='#FF5926'>%1 (%2m) %4</t>",_crewnames,round _dist,_Tsize,typeOF _veh];
                    };
                    _ctrl ctrlShow true;_ctrl ctrlEnable true;
                    _ctrl ctrlSetStructuredText _text;
                    _ctrl ctrlSetPosition [(_pos2D select 0) - (safezoneW / 2), (_pos2D select 1), safezoneW, safezoneH];
                    _ctrl ctrlCommit 0;
                }
                else
                {
                    _ctrl ctrlShow false;_ctrl ctrlEnable false;
                };
                sleep 0.01;
            };
            _ctrl ctrlShow false;_ctrl ctrlEnable false;
            fnc_esp_unitarray = fnc_esp_unitarray - [_unit];
            LayerID = nil;
        };
        if (isNil "fnc_esp_state") then {fnc_esp_state = 0;};
        if (fnc_esp_state == 0) then
        {
            setGroupIconsVisible [true, false];
            fnc_esp_state = 1;
            fnc_esp_distance = 1500;
            fnc_esp_unitarray = [];
            LayerID = nil;
            while {fnc_esp_state == 1} do
            {
                {
                    if (!isNull _x) then {
                        _pos = (positionCameraToWorld [0,0,0]);
                        _posX = getPos _x;
                        _dist = (_pos distance _posX);
                        if (!(_x in fnc_esp_unitarray) && (_dist < fnc_esp_distance) && (!visibleMap)) then
                        {
                            fnc_esp_unitarray = fnc_esp_unitarray + [_x];
                            [_x] spawn fnc_esp;
                        };
                        if ((_x in fnc_esp_unitarray) && (_dist > fnc_esp_distance)) then
                        {
                            fnc_esp_unitarray = fnc_esp_unitarray - [_x];
                        };
                    };
                } forEach playableUnits;
                sleep 0.75;
            };
        }
        else
        {
            setGroupIconsVisible [true, true];
            fnc_esp_state = 0;
            fnc_esp_unitarray = [];
            LayerID = nil;
        };
    };
    fnc_MapIcons_infiSTAR = {
        if (isNil "show_buildables_epoch") then {show_buildables_epoch = false;};
        fnc_epochB = {
            if (isNil "show_buildables_epoch") then {show_buildables_epoch = false;} else {show_buildables_epoch = !show_buildables_epoch;};
        };
        if (isNil "show_loot_infiSTAR") then {show_loot_infiSTAR = false;};
        fnc_LootS = {
            if (isNil "show_loot_infiSTAR") then {show_loot_infiSTAR = false;} else {show_loot_infiSTAR = !show_loot_infiSTAR;};
        };
        if (isNil "show_boxes_infiSTAR") then {show_boxes_infiSTAR = false;};
        fnc_BoxS = {
            if (isNil "show_boxes_infiSTAR") then {show_boxes_infiSTAR = false;} else {show_boxes_infiSTAR = !show_boxes_infiSTAR;};
        };
        if (isNil "show_cWEPm_infiSTAR") then {show_cWEPm_infiSTAR = false;};
        fnc_CWEPS = {
            if (isNil "show_cWEPm_infiSTAR") then {show_cWEPm_infiSTAR = false;} else {show_cWEPm_infiSTAR = !show_cWEPm_infiSTAR;};
        };

        fnc_MapIconConfigCM =
        {
            MapIconConfigCM =
            [
                ["",true],
                ["Icon Options", [-1], "", -5, [["expression", ""]], "1", "0"],
                [(format["Show Epoch Buildables - %1",show_buildables_epoch]), [2], "", -5, [["expression", "call fnc_epochB;"]], "1", "1"],
                [(format["Show Loot - %1",show_loot_infiSTAR]), [3], "", -5, [["expression", "call fnc_LootS;"]], "1", "1"],
                [(format["Show Boxes - %1",show_boxes_infiSTAR]), [4], "", -5, [["expression", "call fnc_BoxS;"]], "1", "1"],
                [(format["Show Weapons - %1",show_cWEPm_infiSTAR]), [5], "", -5, [["expression", "call fnc_CWEPS;"]], "1", "1"]
            ];
            showCommandingMenu "#USER:MapIconConfigCM";
        };


        if !(('ItemGPS' in items player) or ('ItemMap' in items player)) then
        {
            _config = ["ItemGPS"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };
        disableSerialization;
        if (isnil "fnc_MapIcons_run") then
        {
            MapIconConfigCMKey = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 0x3F) then {call fnc_MapIconConfigCM};false;"];
            cutText ["MapIcons Enabled - Option on F5", "PLAIN"];

            fnc_MapIcons_run = true;

            _map = (findDisplay 12) displayCtrl 51;
            _mapdraw = _map ctrlSetEventHandler ["Draw", "_this call fnc_draw_MapIcons;"];

            _minimap = (uinamespace getvariable "BIS_RscMiniMap") displayCtrl 101;
            _minimapdraw = _minimap ctrlSetEventHandler ["Draw", "_this call fnc_draw_MapIcons;"];
        }
        else
        {
            (findDisplay 46) displayRemoveEventHandler ["KeyDown", MapIconConfigCMKey];
            cutText ["MapIcons Disabled", "PLAIN"];

            fnc_MapIcons_run = nil;
            _map ctrlremoveeventhandler ["Draw", _mapdraw];
        };
        fnc_draw_MapIcons =
        {
            if (!isnil "fnc_MapIcons_run") then
            {
                private["_ctrl"];
                _ctrl =  _this select 0;
                _iscale = (1 - ctrlMapScale _ctrl) max .2;
                _irad = 27;
                _color = [0, 0, 0, 1];
                _icon = "\ca\ui\data\icon_zora_ca.paa";

                if (show_buildables_epoch) then
                {
                    if (visibleMap) then
                    {
                        _allowedObjects =
                        [
                            "MetalPanel_DZ","WoodLargeWall_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ",
                            "WoodSmallWallWin_DZ","WoodSmallWallThird_DZ","CinderWallHalf_DZ","CinderWall_DZ"
                        ];

                        if (isNil 'All_Map_Objects') then
                        {
                            All_Map_Objects = [];
                            {
                                if (!isNull _x) then
                                {
                                    _type = typeOf _x;
                                    if (_type in _allowedObjects) then
                                    {
                                        All_Map_Objects = All_Map_Objects + [_x];
                                    };
                                };
                            } forEach (allmissionObjects "All");
                            [] spawn {sleep 30;All_Map_Objects = nil;};
                        };
                        {
                            _icon = "\Ca\buildings\Icons\i_wall_CA.paa";
                            _ctrl drawIcon [_icon, [0.4,0.25,0,1], getPosASL _x, 10, 10, getDir _x, "", 0];
                        } forEach All_Map_Objects;
                    };
                };

                if ((show_loot_infiSTAR) || (show_boxes_infiSTAR)) then
                {
                    if (isNil 'lootBoxesArray') then
                    {
                        lootBoxesArray = (allMissionObjects "ReammoBox");
                        [] spawn {sleep 10;lootBoxesArray = nil;};
                    };

                    {
                        if (!isNull _x) then
                        {
                            _type = typeOf _x;
                            if (_type == "WeaponHolder") then
                            {
                                if (show_loot_infiSTAR) then
                                {
                                    _icon = "\ca\ui\data\icon_zora_ca.paa";
                                    _wepCargo = (getWeaponCargo _x) select 0;
                                    if (count _wepCargo > 0) then
                                    {
                                        _icon = gettext (configFile >> 'cfgWeapons' >> _wepCargo select 0 >> 'picture');
                                    }
                                    else
                                    {
                                        _magCargo = (getMagazineCargo _x) select 0;
                                        if (count _magCargo > 0) then
                                        {
                                            _icon = gettext (configFile >> 'cfgMagazines' >> _magCargo select 0 >> 'picture');
                                        };
                                    };

                                    _irad = 25;
                                    _ctrl drawIcon [_icon, [0.74,0.97,0.98,1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
                                };
                            }
                            else
                            {
                                if (show_boxes_infiSTAR) then
                                {
                                    _icon = getText(configFile >> "CfgVehicles" >> _type >> "icon");
                                    _irad = 25;
                                    _ctrl drawIcon [_icon, [1,0,0,1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
                                };
                            };
                        };
                    } forEach lootBoxesArray;
                };

                _allvehicles = player nearEntities ['Allvehicles',1000000];
                if (!visibleMap) then
                {
                    _allvehicles = player nearEntities ['Allvehicles',150];
                };
                {
                    if (!isNull _x) then
                    {
                        _type = typeOf _x;
                        if ((_x isKindOf "LandVehicle") || (_x isKindOf "Air") || (_x isKindOf "Ship")) then
                        {
                            _icon = getText(configFile >> "CfgVehicles" >> _type >> "icon");
                            _irad = 27;
                            if ((_x iskindof "Air") or (_x iskindof "Tank")) then
                            {
                                _irad = 32;
                                _ctrl drawIcon [_icon, [1, 0, 1, 1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
                            }
                            else
                            {
                                _irad = 27;
                                _ctrl drawIcon [_icon, [0.05,0.05,0.6,1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 0.5];
                            };
                        };
                        if ((_x isKindOf "Man") || (getPlayerUID _x != "")) then
                        {
                            if (_x == player) then {_color = [0, 0, 0, 1];} else {_color = [1, 0, 0, 1];};
                            if ((_x isKindOf "zZombie_Base") || (_x isKindOf "Animal")) then
                            {
                                if (getPlayerUID _x != "") then
                                {
                                    _ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", _color, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];
                                };
                            }
                            else
                            {
                                _ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", _color, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];
                                if (show_cWEPm_infiSTAR) then
                                {
                                    _icon = gettext (configFile >> 'cfgWeapons' >> (currentweapon _x) >> 'picture');
                                    _irad = 35;
                                    _pos = getPosASL _x;
                                    _pos = [_pos select 0,(_pos select 1) + 12,_pos select 2];
                                    _ctrl drawIcon [_icon, [0.74,0.97,0.98,1], _pos, _iscale*_irad, _iscale*_irad, (getDir _x)+90, "", 1];
                                };
                            };
                        };
                    };
                } forEach _allvehicles;
            };
        };
    };
    adminwreck =
    {
        if !("ItemMap" in items player) then
        {
            _config = ["ItemMap"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };

        adminwrecks =
        {
            while {markadwreck == 1} do
            {
                _objects = allMissionObjects "SpawnableWreck";
                _objects = _objects + vehicles;
                for "_i" from 0 to (count _objects)-1 do
                {
                    deleteMarkerLocal ("adminwrecks" + (str _i));

                    _selected = _objects select _i;
                    _type = typeOf _selected;
                    if ((getText (configFile >> 'CfgVehicles' >> (typeof _selected) >> 'displayName') == 'Wreck') or (_type in ["UH60Wreck_DZ","UH1Wreck_DZ","Mi8Wreck_DZ","UH60_NAVY_Wreck_DZ","UH60_ARMY_Wreck_DZ","UH60_NAVY_Wreck_burned_DZ","UH60_ARMY_Wreck_burned_DZ","Mass_grave_DZ"])) then
                    {
                        deleteMarkerLocal ("adminwrecks" + (str _i));
                        _vm = createMarkerLocal [("adminwrecks" + (str _i)), getPos _selected];
                        _vm setMarkerTypeLocal "SupplyVehicle";
                        _vm setMarkerSizeLocal [0.8, 0.8];
                        _vm setMarkerTextLocal format [" %1", getText (configFile >> 'CfgVehicles' >> (typeof _selected) >> 'displayName')];
                        _vm setMarkerColorLocal ("ColorYellow");
                    };
                };
                sleep 2;
            };
            _objects = allMissionObjects "SpawnableWreck";
            _objects = _objects + vehicles;
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("adminwrecks" + (str _i));};
        };
        if (isNil "markadwreck") then {markadwreck = 0;};
        if (markadwreck == 0) then
        {
            markadwreck = 1;
            hint "2D Map WRECK Markers Activated";
            [] spawn adminwrecks;

            _savelog = format["%1 WRECK Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            markadwreck = 0;
            hint "2D Map WRECK Markers Disabled";

            _objects = allMissionObjects "SpawnableWreck";
            _objects = _objects + vehicles;
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("adminwrecks" + (str _i));};

            _savelog = format["%1 WRECK Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    admintent =
    {
        if !("ItemMap" in items player) then
        {
            _config = ["ItemMap"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };

        admintents =
        {
            while {markadtent == 1} do
            {
                _objects = ((allmissionobjects "TentStorage")+(allmissionobjects "StashSmall")+(allmissionobjects "StashMedium"));
                for "_i" from 0 to (count _objects)-1 do
                {
                    deleteMarkerLocal ("admintents" + (str _i));

                    _selected = _objects select _i;
                    _type = typeOf _selected;
                    deleteMarkerLocal ("admintents" + (str _i));
                    _vm = createMarkerLocal [("admintents" + (str _i)), getPos _selected];
                    _vm setMarkerTypeLocal "Camp";
                    _vm setMarkerSizeLocal [0.8, 0.8];
                    _vm setMarkerTextLocal format [" %1", getText (configFile >> 'CfgVehicles' >> (typeof _selected) >> 'displayName')];
                    _vm setMarkerColorLocal ("ColorGreen");
                };
                sleep 2;
            };
            _objects = ((allmissionobjects "TentStorage")+(allmissionobjects "StashSmall")+(allmissionobjects "StashMedium"));
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("admintents" + (str _i));};
        };
        if (isNil "markadtent") then {markadtent = 0;};
        if (markadtent == 0) then
        {
            markadtent = 1;
            hint "2D Map Tent Markers Activated";
            [] spawn admintents;

            _savelog = format["%1 TentMarker Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            markadtent = 0;
            hint "2D Map Tent Markers Disabled";

            _objects = ((allmissionobjects "TentStorage")+(allmissionobjects "StashSmall")+(allmissionobjects "StashMedium"));
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("admintents" + (str _i));};

            _savelog = format["%1 TentMarker Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminDEAD =
    {
        if !(('ItemGPS' in items player) or ('ItemMap' in items player)) then
        {
            _config = ["ItemGPS"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };
        adminDEADs =
        {
            while {markadDEAD == 1} do
            {
                if !(markadDEAD == 1) exitWith {
                    _objects = (allDead+allmissionobjects "GraveDZE");
                    for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("adminDEADs" + (str _i));};
                };
                _objects = (allDead+allmissionobjects "GraveDZE");
                for "_i" from 0 to (count _objects)-1 do
                {
                    deleteMarkerLocal ("adminDEADs" + (str _i));
                    _selected = _objects select _i;
                    if ((!isNull _selected) && !(_selected isKindOf "zZombie_base") && (_selected isKindOf "Man")) then
                    {
                        _name = (_selected getVariable["bodyName", name _selected]);
                        if (_name != "Error: No unit") then
                        {
                            _vm = createMarkerLocal [("adminDEADs" + (str _i)), getPos _selected];
                            _vm setMarkerTypeLocal "Camp";
                            _vm setMarkerSizeLocal [0.4, 0.4];
                            _vm setMarkerTextLocal format["%1",_name];
                            _vm setMarkerColorLocal ("ColorRED");
                        };
                    };
                };
                sleep 5;
            };
            _objects = (allDead+allmissionobjects "GraveDZE");
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("adminDEADs" + (str _i));};
        };
        if (isNil "markadDEAD") then {markadDEAD = 0;};
        if (markadDEAD == 0) then
        {
            markadDEAD = 1;
            hint "2D Map DEADMarker Activated";
            [] call adminDEADs;

            _savelog = format["%1 DEADMarker Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            markadDEAD = 0;
            hint "2D Map DEADMarker Disabled";

            _objects = (allDead+allmissionobjects "GraveDZE");
            for "_i" from 0 to (count _objects)-1 do {deleteMarkerLocal ("adminDEADs" + (str _i));};

            _savelog = format["%1 DEADMarker Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminVAULT =
    {
        if !(('ItemGPS' in items player) or ('ItemMap' in items player)) then
        {
            _config = ["ItemGPS"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };
        adminVAULTs =
        {
            while {markadVAULT == 1} do
            {
                ADMIN_VAULT_LIST = [] + (allmissionobjects "VaultStorage"+allmissionobjects "VaultStorageLocked"+allmissionobjects "LockboxStorageLocked"+allmissionobjects "LockboxStorage");

                if !(markadVAULT == 1) exitWith {
                    for "_i" from 0 to 9999 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};
                };
                for "_i" from 0 to (count ADMIN_VAULT_LIST)-1 do
                {
                    deleteMarkerLocal ("adminVAULTs" + (str _i));
                    _selected = ADMIN_VAULT_LIST select _i;
                    _vm = createMarkerLocal [("adminVAULTs" + (str _i)), getPos _selected];
                    _vm setMarkerTypeLocal "Camp";
                    _vm setMarkerSizeLocal [0.5, 0.5];
                    _vm setMarkerTextLocal "VAULT";
                    _vm setMarkerColorLocal ("ColorYellow");
                };
                sleep 5;
            };
            for "_i" from 0 to 9999 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};
        };
        if (isNil "markadVAULT") then {markadVAULT = 0;};
        if (markadVAULT == 0) then
        {
            markadVAULT = 1;
            hint "2D Map VAULTMarker Activated";
            [] call adminVAULTs;

            _savelog = format["%1 VAULTMarker Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            markadVAULT = 0;
            hint "2D Map VAULTMarker Disabled";

            for "_i" from 0 to 9999 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};

            _savelog = format["%1 VAULTMarker Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminmark =
    {
        if !("ItemMap" in items player) then
        {
            _config = ["ItemMap"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };

        adminpmark =
        {
            while {mark == 1} do
            {
                _playableUnits = playableUnits;
                for "_i" from 0 to (count _playableUnits)-1 do
                {
                    deleteMarkerLocal ("adminpmark" + (str _i));
                    if ((_playableUnits select _i) == vehicle (_playableUnits select _i)) then
                    {
                        deleteMarkerLocal ("adminpmark" + (str _i));
                        _pm = createMarkerLocal [("adminpmark" + (str _i)), getPos (_playableUnits select _i)];
                        _pm setMarkerTypeLocal "destroyedvehicle";
                        _pm setMarkerSizeLocal [0.8, 0.8];
                        _pm setMarkerTextLocal format ["%1", name (_playableUnits select _i)];
                        _pm setMarkerColorLocal ("ColorBlue");
                    };
                };
                sleep 2;
            };
            for "_i" from 0 to (count playableUnits)-1 do {deleteMarkerLocal ("adminpmark" + (str _i));};
        };
        if (isNil "mark") then {mark = 0;};
        if (mark == 0) then
        {
            mark = 1;
            hint "2D Map PLAYER Markers Activated";
            [] spawn adminpmark;

            _savelog = format["%1 PlayerMarkers Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            mark = 0;
            hint "2D Map PLAYER Markers Disabled";

            for "_i" from 0 to (count playableUnits)-1 do {deleteMarkerLocal ("adminpmark" + (str _i));};

            _savelog = format["%1 PlayerMarkers Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminmarkveh =
    {
        if !("ItemMap" in items player) then
        {
            _config = ["ItemMap"];
            _isOK = [player,_config] call BIS_fnc_invAdd;
        };

        adminvmark =
        {
            while {markveh == 1} do
            {
                _vehicles = vehicles;
                for "_i" from 0 to (count _vehicles)-1 do
                {
                    deleteMarkerLocal ("adminvmark" + (str _i));

                    if (((_vehicles select _i) isKindOf "LandVehicle") or ((_vehicles select _i) isKindOf "Air") or ((_vehicles select _i) isKindOf "Ship")) then
                    {
                        if (count crew (_vehicles select _i) != 0) then
                        {
                            _crewnames = [];
                            {
                                _crewnames = _crewnames + [name _x];
                            } forEach crew (_vehicles select _i);

                            deleteMarkerLocal ("adminvmark" + (str _i));
                            _vm = createMarkerLocal [("adminvmark" + (str _i)), getPos (_vehicles select _i)];
                            _vm setMarkerTypeLocal "destroyedvehicle";
                            _vm setMarkerSizeLocal [0.8, 0.8];
                            _vm setMarkerTextLocal format ["%1 in %2", _crewnames,getText (configFile >> 'CfgVehicles' >> (typeof (_vehicles select _i)) >> 'displayName')];
                            _vm setMarkerColorLocal ("ColorRed");
                        }
                        else
                        {
                            deleteMarkerLocal ("adminvmark" + (str _i));
                            _vm = createMarkerLocal [("adminvmark" + (str _i)), getPos (_vehicles select _i)];
                            _vm setMarkerTypeLocal "destroyedvehicle";
                            _vm setMarkerSizeLocal [0.8, 0.8];
                            _vm setMarkerTextLocal format ["%1", getText (configFile >> 'CfgVehicles' >> (typeof (_vehicles select _i)) >> 'displayName')];
                            _vm setMarkerColorLocal ("ColorBrown");
                        };
                    };
                };
                sleep 2;
            };
            for "_i" from 0 to (count vehicles)-1 do {deleteMarkerLocal ("adminvmark" + (str _i));};
        };
        if (isNil "markveh") then {markveh = 0;};
        if (markveh == 0) then
        {
            markveh = 1;
            hint "2D Map VEHICLE Markers Activated";
            [] spawn adminvmark;

            _savelog = format["%1 VEHICLEMarkers Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            markveh = 0;
            hint "2D Map VEHICLE Markers Disabled";

            for "_i" from 0 to (count vehicles)-1 do {deleteMarkerLocal ("adminvmark" + (str _i));};

            _savelog = format["%1 VEHICLEMarkers Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminAntiAggro = {
        if (isnil "adminAntiAggro_zxeds") then {adminAntiAggro_zxeds = false;};
        if (!adminAntiAggro_zxeds) then
        {
            adminAntiAggro_zxeds = true;

            hint "No Zed Aggro - On";
            cutText [format["No Zed Aggro - On"], "PLAIN DOWN"];
            _savelog = format["%1 No Zed Aggro - On",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";

            player_zombieCheck = {};
            player_zombieAttack = {};
        }
        else
        {
            adminAntiAggro_zxeds = false;

            hint "No Zed Aggro - Disabled";
            cutText [format["No Zed Aggro - Disabled"], "PLAIN DOWN"];
            _savelog = format["%1 No Zed Aggro - Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";

            player_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
            player_zombieAttack = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieAttack.sqf';
        };
    };
    admin_vehicleboost = {
        if (isnil("vehboost_infiSTAR")) then {vehboost_infiSTAR = 0;};
        if (vehboost_infiSTAR == 0) then
        {
            vehboost_infiSTAR = 1;
            hint "Vehboost 1 - left shift or E to go fast and space for brakes!";
            cutText [format["Vehboost 1 - left shift or E to go fast and space for brakes!"], "PLAIN DOWN"];
            _savelog = format["%1 Vehboost On",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";

            waituntil {!isnull (finddisplay 46)};
            booostkey_KI_0 = (findDisplay 46) displayAddEventHandler ["KeyDown","_this select 1 call booostkey_FNC_spd_0;false;"];
            booostkey_FNC_spd_0 =
            {
                _vehicle_player = vehicle player;
                if(_vehicle_player == player)exitwith{};

                if(isEngineOn _vehicle_player) then
                {
                    switch (_this) do
                    {
                        case 18:
                        {
                            _vehicle_player SetVelocity [(velocity _vehicle_player select 0) * 1.05, (velocity _vehicle_player select 1) *1.05, (velocity _vehicle_player select 2) * 0.99];
                        };
                        case 42:
                        {
                            _vehicle_player setVelocity [(velocity _vehicle_player select 0) * 1.025, (velocity _vehicle_player select 1) * 1.025, (velocity _vehicle_player select 2) * 0.99];
                        };
                        case 57:
                        {
                            _vehicle_player SetVelocity [(velocity _vehicle_player select 0) * 0.95, (velocity _vehicle_player select 1) *0.95, (velocity _vehicle_player select 2) * 0.99];
                        };
                    };
                };
            };
        }
        else
        {
            vehboost_infiSTAR = 0;
            hint "Vehboost 0";
            cutText [format["Vehboost 0"], "PLAIN DOWN"];
            _savelog = format["%1 Vehboost Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";

            (findDisplay 46) displayRemoveEventHandler ["KeyDown", booostkey_KI_0];
            _vehicle_player = nil;
        };
    };
    adminZedshld =
    {
        if (isNil "zoombiieshieldd") then {zoombiieshieldd = true;}
        else
        {
            zoombiieshieldd = !zoombiieshieldd;
            if (zoombiieshieldd) then
            {
                cutText [format["ZedShield ON for 50m"],"PLAIN DOWN"];

                _savelog = format["%1 ZedShield Activated",name player];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            }
            else
            {
                cutText ["ZedShield OFF","PLAIN DOWN"];

                _savelog = format["%1 ZedShield Disabled",name player];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        };
        while {zoombiieshieldd} do
        {
            {
                if (!isNull _x) then {
                    if !(isPlayer _x) then {
                        deletevehicle _x;
                    };
                };
            } forEach (vehicle player nearEntities ["zZombie_Base",50]);
            sleep 1;
        };
    };
    adminCallZeds =
    {
        fnc_addZeds =
        {
            _position = _this;
            for "_i" from 1 to 10 do
            {
                _unitTypes =    []+ getArray (configFile >> "CfgBuildingLoot" >> "Default" >> "zombieClass");
                _agent =    objNull;
                _type = _unitTypes call BIS_fnc_selectRandom;
                _radius = 40;
                _method = "NONE";
                _agent = createAgent [_type, _position, [], _radius, _method];
                _id = [_position,_agent] execFSM "\z\AddOns\dayz_code\system\zombie_agent.fsm";
            };
        };
        openMap [true, false];
        onMapSingleClick '
            [_pos select 0,_pos select 1,_pos select 2] spawn fnc_addZeds;
            openMap [false, false];
            onMapSingleClick "";
        ';
    };
    adminammo_recoil = {
        if (isnil ("admin_loop1")) then {admin_loop1 = 0;};
        if (admin_loop1==0) then
        {
            admin_loop1=1;
            cutText [format["Infinite AMMO and No Recoil ON"], "PLAIN DOWN"];
            hint "Infinite AMMO and No Recoil ON";

            _savelog = format["%1 adminammo_recoil ON",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            admin_loop1=0;
            cutText [format["Infinite AMMO and No Recoil OFF"], "PLAIN DOWN"];
            hint "Infinite AMMO and No Recoil OFF";

            _savelog = format["%1 adminammo_recoil OFF",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };

        while {admin_loop1==1} do
        {
            (vehicle player) setVehicleAmmo 1;
            (vehicle player) setUnitRecoilCoefficient 0;
        sleep 0.01;
        };
    };
    admin_FastFire = {
        if (isnil ("admin_loop2")) then {admin_loop2 = 0;};
        if (admin_loop2==0) then
        {
            admin_loop2=1;
            cutText [format["FastFire ON"], "PLAIN DOWN"];
            hint "FastFire ON";

            _savelog = format["%1 FastFire ON",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            admin_loop2=0;
            cutText [format["FastFire OFF"], "PLAIN DOWN"];
            hint "FastFire OFF";

            _savelog = format["%1 FastFire OFF",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
        while {admin_loop2==1} do
        {
            (vehicle player) setWeaponReloadingTime [(vehicle player),currentWeapon (vehicle player),0];
            player setWeaponReloadingTime [player,currentWeapon player,0];
            sleep 0.01;
        };
    };
    admin_low_terrain = {
        if (isNil "admin_terrain") then {admin_terrain = true;} else {admin_terrain = !admin_terrain};
        if (admin_terrain) then {
        setTerrainGrid 50;
        hint "Terrain Low";
        cutText [format["Terrain Low"], "PLAIN DOWN"];
        _savelog = format["%1 Terrain Low",name player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
        } else {
        setTerrainGrid 25;
        hint "Terrain Normal";
        cutText [format["Terrain Normal"], "PLAIN DOWN"];
        _savelog = format["%1 Terrain Normal",name player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
        };
    };
    adminDEGOD =
    {
        sleep 0.5;
        fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
        player allowDamage true;
        player removeAllEventHandlers 'HandleDamage';
        player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
    };
    admingod =
    {
        if (isNil 'gmdadmin') then
        {
            gmdadmin = 0;
            [] spawn {
                while {(!isNil 'gmdadmin')} do
                {
                    if (gmdadmin == 1) then
                    {
                        fnc_usec_damageHandler = {};
                        player allowDamage false;
                        player removeAllEventhandlers 'handleDamage';
                        player addEventhandler ['handleDamage', {false}];
                    }
                    else
                    {
                        fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
                        player allowDamage true;
                        player removeAllEventHandlers 'HandleDamage';
                        player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
                    };
                    sleep 0.5;
                };
            };
        };
        if (gmdadmin == 0) then
        {
            gmdadmin = 1;
            hint 'God ON';

            _savelog = format['%1 G_o_d ON',name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer 'PVAH_WriteLogReq';
        }
        else
        {
            gmdadmin = 0;
            hint 'God OFF';

            _savelog = format['%1 G_o_d OFF',name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer 'PVAH_WriteLogReq';
        };
    };
    adminHumanityPlus =
    {
        {
            if (name _x == _this select 0) then
            {
                _humanity = _x getVariable["humanity",0];
                _x setVariable["humanity",_humanity+2500,true];
                hint format ["Gave %1 +2500 Humanity!",_this select 0];

                _savelog = format["%1 +2500 Humanity to %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminHumanityMinus =
    {
        {
            if (name _x == _this select 0) then
            {
                _humanity = _x getVariable["humanity",0];
                _x setVariable["humanity",_humanity-2500,true];
                hint format ["Gave %1 -2500 Humanity!",_this select 0];

                _savelog = format["%1 -2500 Humanity to %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminfixfps = {
        hint "FIXING FPS";
        cutText ["FIXING FPS", "PLAIN"];
        {
            if (count units _x == 0) then
            {
                deleteGroup _x;
            };
        } forEach allGroups;
        _allstart = ((allMissionObjects "WeaponHolder")+(allMissionObjects "Sound_Flies")+(allDead)+([0,0,0] nearEntities ['CAAnimalBase', 10000000]));
        _startCount = count _allstart;
        systemchat format["Objects: %1 - cleaning...",_startCount];
        {
            if (!isNull _x) then
            {
                if (_x in vehicles) then {deletevehicle _x;};
                _nearby = {isPlayer _x} count (_x nearEntities [["CAManBase"], 450]);
                _keep = _x getVariable ["permaLoot",false];
                if ((_nearby == 0) && (!_keep) && !(_x in alldead)) then
                {
                    deleteVehicle _x;
                };
                _nearby2 = {isPlayer _x} count (_x nearEntities [["CAManBase"], 25]);
                if ((_nearby2 == 0) && (_x in alldead) && (_x isKindOf "zZombie_Base")) then
                {
                    deleteVehicle _x;
                };
                if ((_nearby2 == 0) && (_x isKindOf "CAAnimalBase")) then {deleteVehicle _x;};
            };
        } foreach _allstart;
        _Count = count ((allMissionObjects "WeaponHolder")+(allMissionObjects "Sound_Flies")+(allDead)+([0,0,0] nearEntities ['CAAnimalBase', 10000000]));
        systemchat format["Objects now: %1",_Count];

        _savelog = format["%1 - FixFps Script",name player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminCarGod =
    {
        if (isNil "adminCarGodToggle") then {adminCarGodToggle = 0;};
        if (adminCarGodToggle == 0) then
        {
            adminCarGodToggle = 1;
            hint "Car God On";
            while {adminCarGodToggle==1} do
            {
                _veh = vehicle player;
                if (_veh != player) then
                {
                    _veh setDamage 0;
                    _veh setFuel 1;
                };
                sleep 0.1;
            };
        }
        else
        {
            adminCarGodToggle = 0;
            hint "Car God Disabled";
        };

        _savelog = format["%1 adminCarGod %2",name player,adminCarGodToggle];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    admininvis =
    {
        if (isNil 'inv1') then {inv1 = 0;};
        if (inv1 == 0) then
        {
            PVAH_AdminReq = [3,player];
            publicVariableServer "PVAH_AdminReq";

            inv1 = 1;
            hint "Invisibility Activated";

            _savelog = format["%1 Invisibility Activated",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            PVAH_AdminReq = [3,player];
            publicVariableServer "PVAH_AdminReq";

            inv1 = 0;
            hint "Invisibility Disabled";

            _savelog = format["%1 Invisibility Disabled",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    admin_debug =
    {
        debugMonitorX = false;
        if (isNil "admin_debug_run") then {admin_debug_run = true;} else {admin_debug_run = !admin_debug_run;};
        while {admin_debug_run} do
        {
            _pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
            if (player == vehicle player) then {_pic = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'picture'));
            }else{_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));};

            _txt = '';
            _txt = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName'));

            _stime = 0;
            if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
            _hours = (_stime/60/60);
            _hours = toArray (str _hours);
            _hours resize 1;
            _hours = toString _hours;
            _hours = compile _hours;
            _hours = call  _hours;
            _minutes = floor(_stime/60);
            _minutes2 = _minutes - (_hours*60);
            _pos = getPosATL player;

            hintSilent parseText format ["
            <t size='1' font='Bitstream' align='Center' >[%1]</t><br/>
            <img size='4.75' image='%4'/><br/>
            <t size='1' font='Bitstream' align='left' color='#CC0000'>Blood: </t><t size='1' font='Bitstream' align='right'>%2</t><br/>
            <t size='1' font='Bitstream' align='left' color='#0066CC'>Humanity: </t><t size='1' font='Bitstream' align='right'>%3</t><br/>
            <br/>
            <t size='1' font='Bitstream' align='left' color='#FFBF00'>Zombie Kills: </t><t size='1' font='Bitstream' align='right'>%9</t><br/>
            <t size='1' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='1' font='Bitstream' align='right'>%10</t><br/>
            <t size='1' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='1' font='Bitstream' align='right'>%11</t><br/>
            <br/>
            <t size='1' font='Bitstream' align='left' color='#FFBF00'>UPTIME: </t><t size='1' font='Bitstream' align='right'>%5h %6min</t><br/>
            <t size='1' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='1' font='Bitstream' align='right'>%8</t><br/>
            <t size='1' font='Bitstream' align='Center' color='#CC0000'>infiSTAR.de AdminDebug</t><br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>Player Online:</t><t size='1'font='Bitstream'align='right'>%12</t><br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>Vehicles:</t><t size='1'font='Bitstream'align='right'>%15(%16)</t><br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>Player in 500m:</t><t size='1'font='Bitstream'align='right'>%13</t><br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>Viewdistance:</t><t size='1'font='Bitstream'align='right'>%14</t>
            <br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>GPS:</t><t size='1'font='Bitstream'align='right'>%17</t><br/>
            <t size='1'font='Bitstream'align='left' color='#0066CC'>Position:</t>
            <t size='1'font='Bitstream'>%18</t>
            ",
            _txt,
            (r_player_blood),
            round (player getVariable['humanity', 0]),
            _pic,
            _hours,
            _minutes2,
            '',
            (round diag_fps),
            (player getVariable['zombieKills', 0]),
            (player getVariable['humanKills', 0]),
            (player getVariable['banditKills', 0]),
            (count playableUnits),
            ({isPlayer _x} count ((vehicle player) nearEntities ['AllVehicles', 500]))-1,
            viewdistance,
            {alive _x} count ([0,0,0] nearEntities [['LandVehicle','Air','Ship'], 10000000]),
            count vehicles,
            mapGridPosition _pos,
            _pos
            ];
            sleep 1;
        };
        if (!admin_debug_run) then {hintSilent parseText format ["<t size='1'font='TahomaB'align='center'>DEBUG OFF</t>"];};
    };
    admin_animate1 =
    {
        _ct = cursorTarget;
        if (!isNull _ct) then
        {
            if ((_ct isKindOf "AllVehicles") && !(_ct isKindOf "Man")) then
            {
                if (locked _ct) then
                {
                    [nil,nil,nil,[_ct,"[infiSTAR.de ADMIN-TOOL]"]] execVM "\z\addons\dayz_code\actions\unlock_veh.sqf";
                }
                else
                {
                    cutText ["vehicle is already open.", "PLAIN"];
                };
            };
            {_ct animate [_x,1];} forEach ["Open_hinge","Open_latch","Lights_1","Lights_2","Open_door","DoorR","LeftShutter","RightShutter"];
            dayz_combination = _ct getVariable["CharacterID","0"];
        };
    };
    admin_animate2 =
    {
        _ct = cursorTarget;
        if (!isNull _ct) then
        {
            if ((_ct isKindOf "AllVehicles") && !(_ct isKindOf "Man")) then
            {
                if (locked _ct) then
                {
                    cutText ["vehicle is already locked.", "PLAIN"];
                }
                else
                {
                    [nil,nil,nil,_ct] execVM "\z\addons\dayz_code\actions\lock_veh.sqf";
                    cutText ["[infiSTAR.de ADMIN-TOOL] used to lock vehicle.", "PLAIN"];
                };
            };
            {_ct animate [_x,0];} forEach ["Open_hinge","Open_latch","Lights_1","Lights_2","Open_door","DoorR","LeftShutter","RightShutter"];
        };
    };
    admin_generatekey =
    {
        private ["_ct","_id","_result","_inventory","_backpack"];
        _ct = cursorTarget;
        if (!isNull _ct) then {
            if (_ct distance player > 12) exitWith {cutText [format["%1 is to far away.",typeOF _ct], "PLAIN"];};
            if !((_ct isKindOf "LandVehicle") || (_ct isKindOf "Air") || (_ct isKindOf "Ship")) exitWith {cutText [format["%1 is not a vehicle..",typeOF _ct], "PLAIN"];};

            _id = _ct getVariable ["CharacterID","0"];
            _id = parsenumber _id;
            if (_id == 0) exitWith {cutText [format["%1 has ID 0 - No Key possible.",typeOF _ct], "PLAIN"];};
            if ((_id > 0) && (_id <= 2500)) then {_result = format["ItemKeyGreen%1",_id];};
            if ((_id > 2500) && (_id <= 5000)) then {_result = format["ItemKeyRed%1",_id-2500];};
            if ((_id > 5000) && (_id <= 7500)) then {_result = format["ItemKeyBlue%1",_id-5000];};
            if ((_id > 7500) && (_id <= 10000)) then {_result = format["ItemKeyYellow%1",_id-7500];};
            if ((_id > 10000) && (_id <= 12500)) then {_result = format["ItemKeyBlack%1",_id-10000];};

            _inventory = (weapons player);
            _backpack = ((getWeaponCargo unitbackpack player) select 0);
            if (_result in (_inventory+_backpack)) then
            {
                if (_result in _inventory) then {cutText [format["Key [%1] already in your inventory!",_result], "PLAIN"];};
                if (_result in _backpack) then {cutText [format["Key [%1] already in your backpack!",_result], "PLAIN"];};
            }
            else
            {
                player addweapon _result;
                cutText [format["Key [%1] added to inventory!",_result], "PLAIN"];
            };
        };
    };
    admin_showid =
    {
        _obj = cursortarget;
        if (!isNull _obj) then
        {
            _charID = _obj getVariable ["CharacterID","0"];
            _objID  = _obj getVariable["ObjectID","0"];
            _objUID = _obj getVariable["ObjectUID","0"];
            _lastUpdate = _obj getVariable ["lastUpdate",time];

            systemchat format["%1: charID: %2, objID: %3, objUID: %4, lastUpdate: %5",typeOF _obj,_charID,_objID,_objUID,_lastUpdate];
        };
    };
    admin_tpdirection_on =
    {
        if (isNil "admin_tpdirection_0n") then {admin_tpdirection_0n = true;} else {admin_tpdirection_0n = !admin_tpdirection_0n;};
        sleep 0.1;
        if (admin_tpdirection_0n) then
        {
            hint "TP infront of you ON";
            cutText ["TP infront of you ON", "PLAIN DOWN"];

            _savelog = format["%1 TP infront of you ON",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        }
        else
        {
            hint "TP infront of you OFF";
            cutText ["TP infront of you OFF", "PLAIN DOWN"];

            _savelog = format["%1 TP infront of you OFF",name player];
            PVAH_WriteLogReq = [_savelog];
            publicVariableServer "PVAH_WriteLogReq";
        };
    };
    admin_tpdirection =
    {
        if (isNil "admin_tpdirection_0n") exitWith {};
        if (!admin_tpdirection_0n) exitWith {};

        _distance = 10;
        _object = (vehicle player);
        _dir = getdir _object;
        _pos = getPosATL _object;
        if (_object isKindOf "Air") then
        {
            if (count(crew _object)>1) then
            {
                _distance = 10;
                _pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)+100];
                if (surfaceIsWater _pos) then {_object setPosASL _pos;} else {_object setPosATL _pos;};
            }
            else
            {
                _distance = 50;
                _pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
                if (surfaceIsWater _pos) then {_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),2];};
                if ((getpos _object) select 2 > 6) then {_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)+0.1]};
                if (surfaceIsWater _pos) then {_object setPosASL _pos;} else {_object setPosATL _pos;};
            };
        }
        else
        {
            _distance = 10;
            _pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
            if (surfaceIsWater _pos) then {_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),2];};
            if ((getpos _object) select 2 > 3) then {_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)];};
            if (surfaceIsWater _pos) then {_object setPosASL _pos;} else {_object setPosATL _pos;};
        };
    };
    adminaltteleport =
    {
        if (isNil "adminaltteleport_toggle") then {adminaltteleport_toggle = true;} else {adminaltteleport_toggle = !adminaltteleport_toggle;};
        if (adminaltteleport_toggle) then
        {
            if !(('ItemGPS' in items player) or ('ItemMap' in items player)) then
            {
                _config = ["ItemGPS"];
                _isOK = [player,_config] call BIS_fnc_invAdd;
            };

            (findDisplay 46) displayAddEventHandler ["KeyDown", "altstate_Admin = _this select 4"];
            ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDown", "if (((_this select 1) == 0) && altstate_Admin) then
            {
                _pos = ((_this select 0) posScreenToWorld [_this select 2, _this select 3]);
                PVAH_AdminReq = [1, player, _pos];
                publicVariableServer 'PVAH_AdminReq';
            };"];
            hint "ALT TELEPORT ACTIVATED";
            cutText ["ALT TELEPORT ACTIVATED", "PLAIN"];
        }
        else
        {
            ((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDown";
            hint "ALT TELEPORT DISABLED";
            cutText ["ALT TELEPORT DISABLED", "PLAIN"];
        };
    };
    adminbreakleg =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [2,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Breaking %1's legs", _this select 0];

                _savelog = format["%1 Break Legs %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    remove_spec_000 = {
        ASPG = objnull;
        vehicle player switchCamera cameraView;
        SpecateLoopActive = nil;
        ['',0,0,1,0,0,3033] spawn bis_fnc_dynamicText;
        ['',0,0,1,0,0,3034] spawn bis_fnc_dynamicText;
        ['',0,0,1,0,0,3035] spawn bis_fnc_dynamicText;
        ['',0,0,1,0,0,3036] spawn bis_fnc_dynamicText;
    };
    adminspec = {
        _name = _this select 0;
        hintSilent format ["Spectating %1, F10 to cancel - F9 Show Gear",_name];
        cutText [format["Spectating %1, F10 to cancel - F9 Show Gear",_name], "PLAIN DOWN"];
        {
            if (name _x == _name) then
            {
                _savelog = format["%1 Spectating %2",name player,_name];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";

                waitForGearRequest = _x;
                ASPG = _x;
                vehicle _x switchCamera cameraView;

                if (isNil 'SpecateLoopActive') then
                {
                    SpecateLoopActive = true;
                    while {SpecateLoopActive} do
                    {
                        if (isNull cameraOn) then {vehicle player switchCamera cameraView;};
                        if (!isNull ASPG) then
                        {
                            _unit = ASPG;
                            _log = format['%1 (%2)',name _unit,getPlayerUid _unit];
                            ["<t align='left'size='0.5'color='#1270ee'>"+_log+"</t>",safezoneX+0.2,safezoneY+0.4,1.5,0,0,3033] spawn bis_fnc_dynamicText;
                            sleep 0.1;

                            _log2 = format['Blood: %1    Humanity: %2',(_unit getVariable['USEC_BloodQty',12000]),(_unit getVariable['humanity',0])];
                            ["<t align='left'size='0.5'color='#1270ee'>"+_log2+"</t>",safezoneX+0.2,safezoneY+0.44,1.5,0,0,3034] spawn bis_fnc_dynamicText;
                            sleep 0.1;

                            _cWep = currentWeapon _unit;
                            if (_cWep == '') then
                            {
                                _log3 = 'unarmed';
                                ["<t align='left'size='0.5'color='#1270ee'>"+_log3+"</t>",safezoneX+0.2,safezoneY+0.48,1.5,0,0,3035] spawn bis_fnc_dynamicText;
                            }
                            else
                            {
                                _log3 = format['Weapon: %1 (Ammo: %2)',_cWep,_unit ammo _cWep];
                                ["<t align='left'size='0.5'color='#1270ee'>"+_log3+"</t>",safezoneX+0.2,safezoneY+0.48,1.5,0,0,3035] spawn bis_fnc_dynamicText;
                            };
                            sleep 0.1;

                            _ct = cursorTarget;
                            if (!isNull _ct) then
                            {
                                if (getPlayerUID _ct != '') then
                                {
                                    _log4 = format['%5 | Blood: %1 | Weapon: %2 (Ammo: %3) | Distance: %4',(_ct getVariable['USEC_BloodQty',12000]),currentWeapon _ct,_ct ammo (currentWeapon _ct),round(vehicle _unit distance _ct),name _ct];
                                    ["<t align='left'size='0.5'color='#1270ee'>"+_log4+"</t>",safezoneX+0.2,safezoneY+0.54,1.5,0,0,3036] spawn bis_fnc_dynamicText;
                                }
                                else
                                {
                                    _log4 = format['Type: %1 | Health: %2 | Distance: %3',typeOf _ct,(1-(damage _ct))*100,round(vehicle _unit distance _ct)];
                                    ["<t align='left'size='0.5'color='#1270ee'>"+_log4+"</t>",safezoneX+0.2,safezoneY+0.54,1.5,0,0,3036] spawn bis_fnc_dynamicText;
                                };
                            };
                            sleep 0.1;
                        };
                        sleep 0.5;
                    };
                };
            };
        } forEach playableUnits;
    };
    admin_spec_gear =
    {
        {
            if (name _x == _this select 0) then
            {
                waitUntil {sleep 0.5;count weapons _x > 0};
                sleep 0.5;
                createGearDialog [(_x), "RscDisplayGear"];
                hint format ["Show Gear of %1", name _x];
            };
        } forEach playableUnits;
    };
    adminkill =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [4,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Killing %1", _this select 0];

                _savelog = format["%1 Adminkilled %2",name player, _this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminSlap =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [21,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Slap %1", _this select 0];

                _savelog = format["%1 Slaps %2",name player, _this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminFDisconnect =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [10,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Disconnect %1", _this select 0];

                _savelog = format["%1 Disconnected %2",name player, _this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminremovegear =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [8,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["%1 Gear Removed", _this select 0];

                _savelog = format["%1 Removes %2 Gear",name player, _this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminmsg =
    {
        createDialog "RscDisplayPassword";
        ctrlSetText [1001,"BroadCast Message Plugin"];
        ctrlSetText [101,""];
        ctrlshow [1002,false];
        buttonSetAction [1,"PVAH_AdminReq = [9, player, toArray(ctrlText 101)]; publicVariableServer ""PVAH_AdminReq"";"];
    };
    admint2me =
    {
        {
            if (name _x == _this select 0) then
            {
                _pos = getPosATL (vehicle player);
                _dir = direction (vehicle player);
                _distance = 5;
                _pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
                (vehicle _x) setPosATL _pos;
                (vehicle _x) setDir _dir;
                hint format ["%2 Moved to %1",name player, name _x];
                cutText [format["%2 Moved to %1",name player, name _x], "PLAIN"];

                _savelog = format["%2 Moved to %1",name player, name _x];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    admintele =
    {
        {
            if (name _x == _this select 0) then
            {
                _pos = getPosATL (vehicle _x);
                _dir = direction (vehicle _x);
                _distance = -1;
                if (player != vehicle player) then {_distance = -8;};
                _pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
                (vehicle player) setPosATL _pos;
                (vehicle player) setDir _dir;
                hint format ["Moving to %1",name _x];
                cutText [format["Moving to %1",name _x], "PLAIN"];

                _savelog = format["%1 Moving to %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminweapon =
    {
        _item = _this select 0;
        _config = [_item];
        _isOK = [player,_config] call BIS_fnc_invAdd;
        _mags = getArray(configfile >> 'cfgWeapons' >> _item >> 'magazines');
        _config = _mags select 0;
        _isOK = [player,_config] call BIS_fnc_invAdd;
        _isOK = [player,_config] call BIS_fnc_invAdd;
        _isOK = [player,_config] call BIS_fnc_invAdd;
        player selectWeapon _item;
        reload player;

        hint format ["%1 Added",_item];
        cutText [format["%1 Added",_item], "PLAIN DOWN"];

        _savelog = format['%1 - %2',name player,_this select 0];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer 'PVAH_WriteLogReq';
    };
    adminmagazino =
    {
        _mag = _this select 0;
        player addMagazine _mag;

        hint format ["%1 Added",_mag];
        cutText [format["%1 Added",_mag], "PLAIN DOWN"];

        _savelog = format['%1 - %2',name player,_mag];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer 'PVAH_WriteLogReq';
    };
    adminsveh =
    {
        _dir = getdir vehicle player;
        _pos = getPos vehicle player;
        _pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
        PVAH_AdminReq = [0, player, _this select 0, _pos];
        publicVariableServer "PVAH_AdminReq";

        cutText [format["SPAWNED: %1 @ %2",_this select 0,_pos], "PLAIN DOWN"];
    };
    adminsvehhive =
    {
        _class = _this select 0;
        _dir = getdir vehicle player;
        _pos = getPos vehicle player;
        _pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
        _worldspace = [_dir,_pos];

        if (isNil "MOD_EPOCH") then {MOD_EPOCH = false;};
        if (MOD_EPOCH) then
        {
            _keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
            _keyNumber = (floor(random 2500)) + 1;
            _keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber];
            _isKeyOK =  isClass(configFile >> "CfgWeapons" >> _keySelected);
            _config = _keySelected;
            _isOk = [player,_config] call BIS_fnc_invAdd;

            PVAH_AdminReq = [-3, player, _class, _worldspace,_keySelected];
            publicVariableServer "PVAH_AdminReq";
            cutText [format["HIVESPAWNED: %1 @ %2\n%3 added to toolbelt.",_class,_worldspace,_keySelected], "PLAIN DOWN"];
        }
        else
        {
            PVAH_AdminReq = [-1, player, _class, _pos];
            publicVariableServer "PVAH_AdminReq";
            cutText [format["HIVESPAWNED: %1 @ %2",_class,_worldspace], "PLAIN DOWN"];
        };
    };
    adminsobj =
    {
        _dir = getdir vehicle player;
        _pos = getPos vehicle player;
        _pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
        PVAH_AdminReq = [0, player, _this select 0, _pos];
        publicVariableServer "PVAH_AdminReq";

        _savelog = format["%1 - %2 at %3",name player,_this select 0, mapGridPosition getPos player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminBurn =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [111,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Burning %1 ...", _this select 0];

                _savelog = format["%1 burning %2 ...",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminUncon =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [11,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Putting %1 to sleep...", _this select 0];

                _savelog = format["%1 Putting %2 to sleep...",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    admin_d0 =
    {
        deleteMarker "rspawn_east";
        _tmp = createMarker ["rspawn_east", [0,0,0]];
        _tmp setMarkerText (_this select 0);
        PVAH_AdminReq = [69,player];
        publicVariableServer "PVAH_AdminReq";
    };
    admin_del_bxs =
    {
        PVAH_AdminReq = [14];
        publicVariableServer "PVAH_AdminReq";

        hint "deleting boxes..";

        _savelog = format["%1 deleted boxes",name player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminDrug =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [15,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Drugging %1...", _this select 0];

                _savelog = format["%1 drugged %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminSuicide =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [22,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Suiciding %1", _this select 0];

                _savelog = format["%1 Suiciding %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminClearBan =
    {
        PVAH_AdminReq = [16,player];
        publicVariableServer "PVAH_AdminReq";
        hint "Bans cleared!";

        _savelog = format["%1 cleared Bans",name player];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminKick =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [17,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Kicked %1...", _this select 0];

                _savelog = format["%1 Kicked %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminBan =
    {
        {
            if (name _x == _this select 0) then
            {
                PVAH_AdminReq = [18,player,_x];
                publicVariableServer "PVAH_AdminReq";
                hint format ["Banned %1...", _this select 0];

                _savelog = format["%1 Banned %2",name player,_this select 0];
                PVAH_WriteLogReq = [_savelog];
                publicVariableServer "PVAH_WriteLogReq";
            };
        } forEach playableUnits;
    };
    adminUnBan =
    {
        _uid = _this select 0;
        _name = _this select 1;

        PVAH_AdminReq = [182,_uid,_name];
        publicVariableServer "PVAH_AdminReq";
        hint format ["UnBanned %1 (%2)",_name,_uid];

        _savelog = format["%1 UnBanned %2 (%3)",name player,_name,_uid];
        PVAH_WriteLogReq = [_savelog];
        publicVariableServer "PVAH_WriteLogReq";
    };
    adminPlayerDeaths =
    {
        if (isNil "dayzPlayerDeathsResult") then {dayzPlayerDeathsResult = [];};
        "dayzPlayerDeathsResult" addpublicVariableEventhandler
        {
            if ((count dayzPlayerDeathsResult) > 0) then
            {
                call EpochDeathBoardLoad;
            }
            else
            {
                cutText ["No recent Deaths.", "PLAIN DOWN"];
            };
        };
        if (isNil "PVDZE_plr_DeathBResult") then {PVDZE_plr_DeathBResult = [];};
        "PVDZE_plr_DeathBResult" addpublicVariableEventhandler
        {
            if ((count PVDZE_plr_DeathBResult) > 0) then
            {
                call EpochDeathBoardLoad;
            }
            else
            {
                cutText ["No recent Deaths.", "PLAIN DOWN"];
            };
        };
        PVAH_AdminReq = [23,player];
        publicVariableServer "PVAH_AdminReq";
        hint "Loading EPOCH-DEATHBOARD..";
    };
    admin_save_target =
    {
        SAVE_THIS = nil;
        _obj = cursorTarget;
        if (isNull _obj) exitWith {hint "target doesn't exist";cutText ["target doesn't exist", "PLAIN"];};
        adminSaveNOW = {
            if (!isNull SAVE_THIS) then
            {
                systemchat format ["<System>:  %1  saved at [%2,%3]",typeOF SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS];
                PVAH_AdminReq = [26,player,SAVE_THIS];
                publicVariableServer "PVAH_AdminReq";
            };
        };
        if (!isNull _obj) then
        {
            SAVE_THIS = nil;
            SAVE_THIS = _obj;
            systemchat format ["<System>: save  %1  at [%2,%3]?",typeOF SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS];
            sleep 0.1;
            adminSaveX =
            [
                ["",true],
                [(format ["%1-[%2,%3]",typeOF SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS]), [-1], "", -5, [["expression", ""]], "1", "0"],
                ["Save", [2], "", -5, [["expression", "[] spawn adminSaveNOW"]], "1", "1"],
                ["Exit", [3], "", -5, [["expression", ""]], "1", "1"]
            ];
            showCommandingMenu "#USER:adminSaveX";
        };
    };
    adminDelete =
    {
        DELETE_THIS = nil;
        _delete = cursorTarget;
        if (isNull _delete) exitWith {hint "target doesn't exist";cutText ["target doesn't exist", "PLAIN"];};
        adminDeleteX =
        [
            ["",true],
            [(format ["%1",typeOF DELETE_THIS]), [-1], "", -5, [["expression", ""]], "1", "0"],
            ["Delete", [2], "", -5, [["expression", "[] spawn adminDeleteNOW"]], "1", "1"],
            ["Exit", [3], "", -5, [["expression", ""]], "1", "1"]
        ];
        adminDeleteNOW = {
            if (!isNull DELETE_THIS) then
            {
                systemchat format ["<System>:  %1  DELETED",typeof DELETE_THIS];
                PVAH_AdminReq = [-2,player,DELETE_THIS];
                publicVariableServer "PVAH_AdminReq";
            };
        };
        if (!isNull _delete) then
        {
            DELETE_THIS = nil;
            DELETE_THIS = _delete;
            systemchat format ["<System>: DELETE  %1  ?",typeOF DELETE_THIS];
            showCommandingMenu "#USER:adminDeleteX";
        };
    };
    fnc_basedestruction =
    {
        private ["_option","_location","_object","_objects","_objectClasses","_i","_dir","_objectID","_objectUID"];
        if (isNil "BD_radius") then { BD_radius = 10; };
        _option = _this select 0;
        switch (_option) do {
            case "center": {
                BD_center = getPos player;
                cutText [format["center set to %1", BD_center], "PLAIN DOWN"];
                if (!isNull BD_centerSign) then
                {
                    deleteVehicle BD_centerSign;
                };
                BD_centerSign = createVehicle ["Sign_arrow_down_large_EP1", BD_center, [], 0, "CAN_COLLIDE"];
            };
            case "radius": {
                if (isNil "BD_center") then {
                    cutText ["center not set", "PLAIN DOWN"];
                } else {
                    BD_radius = player distance BD_center;
                    cutText [format["radius set to %1 m", BD_radius], "PLAIN DOWN"];
                };
            };
            case "dome": {
                if (isNil "BD_center") then {
                    cutText ["center not set", "PLAIN DOWN"];
                } else {
                    _objects = [];
                    _object = createVehicle ["Plastic_Pole_EP1_DZ", BD_center, [], 0, "CAN_COLLIDE"];
                    _objects set [0, _object];
                    for "_i" from 0 to 360 step (270 / BD_radius) do {
                        _location = [(BD_center select 0) + ((cos _i) * BD_radius), (BD_center select 1) + ((sin _i) * BD_radius), BD_center select 2];
                        _object = createVehicle ["WoodLargeWall_Preview_DZ", _location, [], 0, "CAN_COLLIDE"];
                        _dir = ((BD_center select 0) - (_location select 0)) atan2 ((BD_center select 1) - (_location select 1));
                        _object setDir _dir;
                        _objects set [count _objects, _object];
                    };
                    _location = [BD_center select 0, BD_center select 1, (BD_center select 2) + BD_radius];
                    _object = createVehicle ["WoodFloor_Preview_DZ", _location, [], 0, "CAN_COLLIDE"];
                    _objects set [count _objects, _object];
                    sleep 30;
                    {
                        deleteVehicle _x;
                    } forEach _objects;
                };
            };
            case "destroy": {
                if (isNil "BD_center") then {
                    cutText ["center not set", "PLAIN DOWN"];
                } else {
                    if (BD_radius > 100) then {
                        cutText [format["area is to large for base destruction (radius %1 > 100)", BD_radius], "PLAIN DOWN"];
                    } else {
                        _objectClasses = ["Sign_arrow_down_large_EP1","TentStorage","TentStorageDomed","TentStorageDomed2","Hedgehog_DZ","Sandbag1_DZ","TrapBear","Fort_RazorWire","WoodGate_DZ","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Fence_corrugated_DZ","M240Nest_DZ","CanvasHut_DZ","ParkBench_DZ","MetalGate_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","Plastic_Pole_EP1_DZ","Generator_DZ","StickFence_DZ","LightPole_DZ","FuelPump_DZ","DesertCamoNet_DZ","ForestCamoNet_DZ","DesertLargeCamoNet_DZ","ForestLargeCamoNet_DZ","SandNest_DZ","DeerStand_DZ","MetalPanel_DZ","WorkBench_DZ","WoodFloor_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodStairs_DZ","WoodStairsSans_DZ","WoodSmallWallThird_DZ","WoodLadder_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallSmallDoorway_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","MetalFloor_DZ","WoodRamp_DZ"];
                        if (BD_vehicles) then {
                            _objectClasses = _objectClasses + ["LandVehicle","Air","Ship"];
                        };
                        _objects = nearestObjects [BD_center, _objectClasses, BD_radius];
                        _i = 0;
                        {
                            if ((!isnull _x) && (alive _x)) then
                            {
                                PVAH_AdminReq = [-2,player,_x];
                                publicVariableServer "PVAH_AdminReq";
                                _i = _i + 1;
                            };
                        } forEach _objects;
                        cutText [format["%1 of %2 objects destroyed and deleted", _i, count _objects], "PLAIN DOWN"];
                    };
                };
            };
        };
    };
    admin_BaseDestructionMenu =
    {
        if (isNil "BD_vehicles") then {BD_vehicles = true;};
        BaseDestructionMenu =
        [
            ["Base Destruction",true],
                ["Set Center", [2], "", -5, [["expression", '["center"] spawn fnc_basedestruction']], "1", "1"],
                ["Set Radius", [3], "", -5, [["expression", '["radius"] spawn fnc_basedestruction']], "1", "1"],
                ["Show Dome", [4], "", -5, [["expression", '["dome"] spawn fnc_basedestruction']], "1", "1"],
                [format["Include Vehicles (%1)",BD_vehicles], [5], "", -5, [["expression", "BD_vehicles = !BD_vehicles;"]], "1", "1"],
                ["DESTROY ALL INSIDE DOME", [6], "", -5, [["expression", '["destroy"] spawn fnc_basedestruction']], "1", "1"],
            ["", [-1], "", -5, [["expression", ""]], "1", "0"],
            ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
        ];
        showCommandingMenu "#USER:BaseDestructionMenu";
    };
    if (isNil 'admin_announce') then {admin_announce = true;};
};
