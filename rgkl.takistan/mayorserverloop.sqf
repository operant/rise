private["_action", "_money"];
_this = _this select 3;
_action  = _this select 0;
_money =  [player, 'money'] call INV_GetItemAmount;

president_elections_term = 30; //number of minutes between elections
server setVariable ["next_president_election", -1, true];

if (_action == "serverloop") then {
	private["_currentMayor", "_iteration_delay", "_iterations"];
	
	_currentMayor = -1;
	_iterations = president_elections_term;

	while {true} do {
		private["_i"];
		for [{_i=0}, {_i < _iterations}, {_i=_i+1}] do {
			sleep 59.9;
			_time_left = president_elections_term - _i;
			server setVariable ["next_president_election", _time_left, true];
			
			private["_k"];
			for [{_k=0}, {_k < count(WahlArray)}, {_k=_k+1}] do {
				private["_player_variable_name", "_player_variable"];
				_player_variable_name = (playerstringarray select _k);
				_player_variable = missionNamespace getVariable _player_variable_name;
				
				if (not([_player_variable] call player_exists)) then {
					WahlArray SET [_k, [] ];
				};
			};
		};
	
		private["_MaxStimmen", "_MaxPos"];
		_MaxStimmen = 1;
		_MaxPos = -1;

		for [{_i=0}, {_i < count(WahlArray)}, {_i=_i+1}] do {
			private["_player_variable_name", "_player_variable"];
			_player_variable_name = (playerstringarray select _i);
			_player_variable = missionNamespace getVariable _player_variable_name;
			
			if ( ((count (WahlArray select _i)) > _MaxStimmen) and ([_player_variable] call player_exists)) then {
				_MaxStimmen = (count (WahlArray select _i));
				_MaxPos = _i;
			};
		};

		if (_MaxPos == -1) then	{
			"hint localize ""STRS_regierung_nomajor"";" call broadcast;
			_currentMayor = -1;
		} 
		else { if (_currentMayor == _MaxPos) then {
			"hint localize ""STRS_regierung_majorstays"";" call broadcast;
		} 
		else {
			_currentMayor = _MaxPos;
			_MayorString  = (playerstringarray select _currentMayor);
			format["hint format[localize ""STRS_mayor_new"", ""%3"", %2]; if ((rolenumber-1) == %1) then {isMayor = true;} else {isMayor = false;};", _MaxPos, _MaxStimmen, _MayorString] call broadcast;
		};};

		MayorNumber = _currentMayor;
		PUBLICVARIABLE "MayorNumber";
	};
};
