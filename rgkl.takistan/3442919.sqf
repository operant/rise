if (!(createDialog "GFX_GrafikEinstellungenDialog")) exitWith {hint "Dialog Error! Return to lobby and join again!";};
if ((count _this) > 0) then {buttonSetAction [10, _this select 0];};