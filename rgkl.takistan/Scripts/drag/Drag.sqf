//Made by Lifeman!
//http://www.youtube.com/user/lifemanlive
//Drag


private["_unit","_id"];
_unit = cursorTarget;
if(isNull _unit) exitWith {}; //Not valid
if(!(_unit isKindOf "Man")) exitWith {}; //Not a 'Man'
if(!isPlayer _unit) exitWith {}; //Not a human player
if(side _unit != civilian) exitWith {}; //Not a civ
_unit attachTo [player, [0,1,0]];
_unit setVariable["transporting",false,true];
_unit setVariable["Escorting",true,true];
_undrag = player addAction ["Release Player", "Scripts\drag\Undrag.sqf"]
player groupChat "Press H to release the civilian!"

