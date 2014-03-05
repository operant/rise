// Contains whitelist/blacklist arrays!

//hint "test";




private["_uid"];
_uid = getPlayerUID player;

// ADMIN
A_LIST_DONATORS = [];

// Remember the Array format! No comma on last item in array!

// Developers

A_LIST_DEVS     =
[
    "137166086", // Montel
	"78757318" // Ignace
];

// Directors and Deputy Directors

A_LIST_DERPS	=
[
	"110245190", // Jim
	"102345478", //Valgarr
	"38357638", //Patrick
	"60447366" // Sp3ctr3

];

// Senior Admins

A_LIST_SNADMINS	=
[
	"150444422" //Shooting Star"
];

// Remember the Array format! No comma on last item in array!

// Admins

A_LIST_ADMINS	=
[
	"114292102", //Spoon
	"14404166", //Jambo
	"95145862" // Mercz
];

// Remember the Array format! No comma on last item in array!

// Moderators

A_LIST_MODS	=
[
   "76912326", // Jager
   "142546054", // Miker
   "122007366", // Unit
   "151917702", // Remixd
   "152357382", // Alex
   "149966854", // edward
   "26470086", // cis
   "79433286" // Mickey
];

isDeveloper = (getPlayerUID player) in A_LIST_DEVS;
isAdminDev = (getPlayerUID player) in A_LIST_DERPS;
isSnAdmin = (getPlayerUID player) in A_LIST_SNADMINS;

isAdmin = (getPlayerUID player) in A_LIST_ADMINS;
isMod = (getPlayerUID player) in A_LIST_MODS;
isStaff = (isAdminDev || isSnAdmin || isAdmin || isMod || isDeveloper);


// Remember the Array format! No comma on last item in array!

// Whitelisting
pmcwhitelist = [
"92792966",
"169683142",
"92792966",
"124336710",
"40129222",
"25658566",
"139324038",
"152582150",
"136083654", // matthew
"67635078", // Sgt Roose
"151917702",
"102135238", // ProRho
"114730502", //Bigmac
"51953798", // Dehatitated
"42724742",// N1ghtm6r3poo
"137166086", // MontelWilliams
"11778816", // Sharpy
"38049862", // Cranky Chicken
"96797574", // Joseph
"75463622", // FGcharlie
"169683142", // Kaleb
"116256966", // louisdrocks
"108565038", // Woofygoo
"86737286", // PetTheMouche
"116769542", // welshdestroyer
"96387654", // Villanyi
"126793030", // Stevie
"77780806", // 25Mattman
"118167942", //savagezcattack01
"101444806", // JohnnyBoiSloth
"77780806", // 25Mattman
"120645126", // HerpOfWar
"76880198", // Joebie5
"144819462", // Matthew Hughes
"234274694", // Mason
"101771782", // sanity
"121337158", // Forrest
"97770502", // Requiem
"101771782", // Sanity
"77813382", // SFC Ellis
"71304198", // AcBush
"5326272", // Woody
"122133574", // TheCookieMonster
"104600070", // theonebullet
"49340678", // lunchbox
"121152710", // I Was Legend
"24521414", // Roman
"89270470", // skyline232
"124724678", //Hardwork
"23305734", // Razaguy
"31560902", // Robbie 3578
"92490950", // WolfSlayer1997
"86237254", // MurdererLaFleur
"140529926", // DefiantTech
"154413638", // Gucci
"135505798", // echo97
"114483718", // kizor
"77902918", // [assault] Priest
"89447430", // Theherodaniellyng
"169738182", // indep_000
"119741958", // dezric
"89447430", // Daniel Lyng
"114101702", // daniel
"129261958", // SPC Grismer
"171433478", // Alkrin ShotZzZ
"15584070", // unknownaussie1
"103206342", // DerpOfWar 
"108564038", // wolfslayer
"130069190" // PredatorReMiXx
];

hitmanlist = [
"102345478", // Valgarr
"60447366", // testing
"110245190", // Jim
"111480582", //dezric
"114483718", // kizor
"137166086"

];
//if (!(_uid in isStaff) && (call player_cop;) && (    )) then {call kick_whitelist};


// Remember the Array format! No comma on last item in array!

// Blacklisting
copblacklist = [];
opfblacklist = [];
insblacklist = [];
pmcblacklist = [];


_side = playerSide;
if((_uid in copblacklist) && (_side == west)) then {liafu = true;
	player groupChat "You are Blacklisted from Blufor!";
	sleep 8;
	failMission "END1";
};

if((_uid in opfblacklist) && (_side == east)) then {liafu = true;
	player groupChat "You are Blacklisted from Opfor!";
	sleep 8;
	failMission "END1";};

if((_uid in insblacklist) && (_side == resistance)) then {liafu = true;
	player groupChat "You are Blacklisted from Insurgent!";
	sleep 8;
	failMission "END1";};



