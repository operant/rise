hint "Please read the TLR tabs on map before playing";
server globalchat "[Server Message]Welcome to Rise Gaming Community's Takistan Life Revolution";
custom_motd = nil;
while {true} do {
	{server globalChat format["[MoTD] %1", _x]} forEach [
			"http://www.rise-gaming.com",
			"Donate to see our community grow! We offer perks for those who donate to help us!",
			"TS3: ts3.rise-gaming.com",
			"All Blufor and Opfor are required to be on Teamspeak"
		];
	
	if (not(isNil "custom_motd")) then { if (typeName custom_motd == "STRING") then { if (custom_motd != "") then {
		server globalChat format["[MoTD] %1", custom_motd];
	};};};
	sleep (3 * motdwaittime);
};
