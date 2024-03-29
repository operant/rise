SpeedGun_init = {
	SG_ON = if (isNil "SG_ON") then { true } else {not(SG_ON)};
	private["_state"];
	_state = if (SG_ON) then { "ON" } else { "OFF" };
	server globalChat format["Speed Gun: %1", SG_ON];
	
	private["_vehicle", "_bool", "_target", "_string", "_speed", "_speedS"];
	
	while {SG_ON} do {
		if ((iscop or isopf) && INV_shortcuts) then {
			_vehicle = vehicle player;
			_bool	= (_vehicle != player) && (driver _vehicle == player);
				
			if (_bool) then {	
				_target = cursorTarget;
				_string = "";
				if (_target isKindOf "LandVehicle") then {
					_speed = speed _target;
					_speedS = if(_speed > 250) then {"+250 kmph - Offlimit"} else {format["%1 kmph", _speed]};
					_string = format["SPEED- %1		VEHICLE- %2", _speedS, _target];
				} 
				else {
					_string = "INVALID TARGET";
				};	
				titleText[_string, "plain down", 0.1];				
			}
			else {	
				SG_ON = false;		
			};		
		};	
		sleep 0.1;
	};
};