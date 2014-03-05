
RadioTrigger_1 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_1 setTriggerArea       [0, 0, 0, false];
RadioTrigger_1 setTriggerActivation ["ALPHA", "NOT PRESENT", true];
RadioTrigger_1 setTriggerStatements ["this", "[""Einstellungen""] call A_SCRIPT_SETTINGS;", ""];
1 setRadioMsg "Settings";


RadioTrigger_1 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_1 setTriggerArea       [0, 0, 0, false];
RadioTrigger_1 setTriggerActivation ["ALPHA", "NOT PRESENT", true];
RadioTrigger_1 setTriggerStatements ["this", "[RadioTextMsg_1, RadioTextArt_1] call SayDirectSpeach;", ""];
1 setRadioMsg "Say Text 1";
RadioTrigger_2 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_2 setTriggerArea       [0, 0, 0, false];
RadioTrigger_2 setTriggerActivation ["BRAVO", "NOT PRESENT", true];
RadioTrigger_2 setTriggerStatements ["this", "[RadioTextMsg_2, RadioTextArt_2] call SayDirectSpeach;", ""];
2 setRadioMsg "Say Text 2";
RadioTrigger_3 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_3 setTriggerArea       [0, 0, 0, false];
RadioTrigger_3 setTriggerActivation ["CHARLIE", "NOT PRESENT", true];
RadioTrigger_3 setTriggerStatements ["this", "[RadioTextMsg_3, RadioTextArt_3] call SayDirectSpeach;", ""];
3 setRadioMsg "Say Text 3";
RadioTrigger_4 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_4 setTriggerArea       [0, 0, 0, false];
RadioTrigger_4 setTriggerActivation ["DELTA", "NOT PRESENT", true];
RadioTrigger_4 setTriggerStatements ["this", "[RadioTextMsg_4, RadioTextArt_4] call SayDirectSpeach;", ""];
4 setRadioMsg "Say Text 4";

RadioTrigger_5 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_5 setTriggerArea       [0, 0, 0, false];
RadioTrigger_5 setTriggerActivation ["ECHO", "NOT PRESENT", true];
RadioTrigger_5 setTriggerStatements ["this", "[""Einstellungen""] call A_SCRIPT_SETTINGS;", ""];
5 setRadioMsg "Settings";

RadioTrigger_0 = createTrigger ["EmptyDetector", position player ];
RadioTrigger_0 setTriggerText "Fix head bug";
RadioTrigger_0 setTriggerActivation ["JULIET", "PRESENT", true];
RadioTrigger_0 setTriggerStatements ["this", "fixme = [] execVM ""headbug.sqf""",""];

if(debug)then
{
_trgobj = createTrigger ["EmptyDetector", position player ];
_trgobj setTriggerText "teleport";
_trgobj setTriggerActivation ["BRAVO", "PRESENT", true];
_trgobj setTriggerStatements ["this", 'hint "Click on map to select teleport destination"; onMapSingleClick "vehicle player setpos _pos; player setPos _pos; (units group player select 1) setpos _pos; onMapSingleClick """"; hint ""Teleported!"" " ',""];
};



