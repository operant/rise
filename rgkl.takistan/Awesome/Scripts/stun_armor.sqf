//stun_armor

_action = _this select 0;
_item   = _this select 1;
_amount = _this select 2;

switch _item do {
	case "stun_light": {
		player setvariable ["stun_armor", "light", true];
		player groupchat "You put on light stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_light_on", 1] call INV_AddInventoryItem;
	};

	case "stun_light_ter": {
		player setvariable ["stun_armor", "light", true];
		player groupchat "You put on light stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_light_on", 1] call INV_AddInventoryItem;
	};

	case "stun_light_ill": {
		player setvariable ["stun_armor", "light", true];
		player groupchat "You put on light stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_light_on", 1] call INV_AddInventoryItem;
	};
	
	case "stun_full": {
		player setvariable ["stun_armor", "full", true];
		player groupchat "You put on Full stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_full_on", 1] call INV_AddInventoryItem;
	};
	
	case "stun_light_on":{
		player setvariable ["stun_armor", "", true];
		player groupchat "You took off your light stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_light", 1] call INV_AddInventoryItem;
	};
	case "stun_full_on": {
		player setvariable ["stun_armor", "", true];
		player groupchat "You took off your Full stun Armor";
		[player, _item, -1] call INV_AddInventoryItem;
		[player, "stun_full", 1] call INV_AddInventoryItem;
	};
};