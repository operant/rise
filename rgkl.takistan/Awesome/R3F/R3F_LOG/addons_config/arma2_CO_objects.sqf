/**
 * English and French comments
 * Commentaires anglais et fran�ais
 * 
 * This file adds the ArmA 2 and Arrowhead objetcs in the configuration variables of the logistics system.
 * Fichier ajoutant les objets d'ArmA 2 et Arrowhead dans la configuration du syst�me de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes d�rivant de celles utilis�es dans les variables de configuration seront aussi valables.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of vehicles which can tow towable objects.
 * Liste des noms de classes des v�hicules terrestres pouvant remorquer des objets remorquables.
 */
R3F_LOG_CFG_remorqueurs = R3F_LOG_CFG_remorqueurs +
[
	"TowingTractor",
	"Tractor",
	"Kamaz_Base",
	"MTVR",
	"GRAD_Base",
	"Ural_Base",
	"V3S_Base",
	"BRDM2_Base",
	"BTR90_Base",
	"GAZ_Vodnik_HMG",
	"LAV25_Base",
	"StrykerBase_EP1",
	"M2A2_Base",
	"MLRS"
];

/**
 * List of class names of towables objects.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_objets_remorquables = R3F_LOG_CFG_objets_remorquables +
[
	"M119",
	"D30_base",
	"ZU23_base"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftable objects.
 * Liste des noms de classes des v�hicules a�riens pouvant h�liporter des objets h�liportables.
 */
R3F_LOG_CFG_heliporteurs = R3F_LOG_CFG_heliporteurs +
[
	"CH47_base_EP1",
	"Mi17_base",
	"Mi24_Base",
	"UH60_Base",
	"MV22"
];

/**
 * List of class names of liftable objects.
 * Liste des noms de classes des objets h�liportables.
 */
R3F_LOG_CFG_objets_heliportables = R3F_LOG_CFG_objets_heliportables +
[
	"ATV_Base_EP1",
	"HMMWV_Base",
	"Ikarus_TK_CIV_EP1",
	"Lada_base",
	"LandRover_Base",
	"Offroad_DSHKM_base",
	"Pickup_PK_base",
	"S1203_TK_CIV_EP1",
	"SUV_Base_EP1",
	"SkodaBase",
	"TowingTractor",
	"Tractor",
	"Kamaz_Base",
	"MTVR",
	"GRAD_Base",
	"Ural_Base",
	"Ural_ZU23_Base",
	"V3S_Base",
	"UAZ_Base",
	"VWGolf",
	"Volha_TK_CIV_Base_EP1",
	"BTR40_MG_base_EP1",
	"hilux1_civil_1_open",
	"hilux1_civil_3_open_EP1",
	"D30_base",
	"M119",
	"ZU23_base",
	"Boat",
	"Fishing_Boat",
	"SeaFox",
	"Smallboat_1"
];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USSpecialWeaponsBox "weights" 5 units.
 * 
 * Cette section utilise une quantification du volume et/ou poids des objets.
 * Le r�f�rentiel arbitraire utilis� est : une caisse de munition de type USSpecialWeaponsBox "p�se" 5 unit�s.
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 * 
 * Note : la priorit� d'une d�claration de capacit� sur une autre correspond � leur ordre dans les tableaux.
 *   Par exemple : la classe "Truck" appartient � la classe "Car" (voir http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   Si "Truck" est d�clar� avec une capacit� de 140 avant "Car". Et que "Car" est d�clar� apr�s "Truck" avec une capacit� de 40,
 *   Alors toutes les sous-classes appartenant � "Truck" auront une capacit� de 140. Et toutes les sous-classes appartenant
 *   � "Car", except�es celles de "Truck", auront une capacit� de 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportable objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * Liste des noms de classes des v�hicules (terrestres ou a�riens) pouvant transporter des objets transportables.
 * Le deuxi�me �l�ment des tableaux est la capacit� de chargement (en relation avec le co�t de capacit� des objets).
 */
R3F_LOG_CFG_transporteurs = R3F_LOG_CFG_transporteurs +
[
	["CH47_base_EP1", 150],
	["AH6_Base_EP1", 25],
	["Mi17_base", 100],
	["Mi24_Base", 50],
	["UH1H_base", 35],
	["UH1_Base", 30],
	["UH60_Base", 40],
	["An2_Base_EP1", 40],
	["C130J", 150],
	["MV22", 80],
	["ATV_Base_EP1", 5],
	["HMMWV_Avenger", 5],
	["HMMWV_M998A2_SOV_DES_EP1", 12],
	["HMMWV_Base", 18],
	["Ikarus", 50],
	["Lada_base", 10],
	["LandRover_Base", 15],
	["Offroad_DSHKM_base", 15],
	["Pickup_PK_base", 15],
	["S1203_TK_CIV_EP1", 20],
	["SUV_Base_EP1", 15],
	["SkodaBase", 10],
	["TowingTractor", 5],
	["Tractor", 5],
	["KamazRefuel", 10],
	["Kamaz", 50],
	["Kamaz_Base", 35],
	["MAZ_543_SCUD_Base_EP1", 10],
	["MtvrReammo", 35],
	["MtvrRepair", 35],
	["MtvrRefuel", 10],
	["MTVR", 50],
	["GRAD_Base", 10],
	["Ural_ZU23_Base", 12],
	["Ural_CDF", 50],
	["Ural_INS", 50],
	["UralRefuel_Base", 10],
	["Ural_Base", 35],
	["V3S_Refuel_TK_GUE_EP1", 10],
	["V3S_Civ", 35],
	["V3S_Base_EP1", 50],
	["UAZ_Base", 10],
	["VWGolf", 8],
	["Volha_TK_CIV_Base_EP1", 8],
	["BRDM2_Base", 15],
	["BTR40_MG_base_EP1", 15],
	["BTR90_Base", 25],
	["GAZ_Vodnik_HMG", 25],
	["LAV25_Base", 25],
	["StrykerBase_EP1", 25],
	["hilux1_civil_1_open", 12],
	["hilux1_civil_3_open_EP1", 12],
	["Motorcycle", 3],
	["2S6M_Tunguska", 10],
	["M113_Base", 12],
	["M1A1", 5],
	["M2A2_Base", 15],
	["MLRS", 8],
	["T34", 5],
	["T55_Base", 5],
	["T72_Base", 5],
	["T90", 5],
	["AAV", 12],
	["BMP2_Base", 7],
	["BMP3", 7],
	["ZSU_Base", 5],
	["RHIB", 10],
	["RubberBoat", 5],
	["Fishing_Boat", 10],
	["SeaFox", 5],
	["Smallboat_1", 8],
	["Fort_Crate_wood", 5],
	["Ka60_Base_PMC", 50],
	["BAF_Merlin_HC3_D", 200]
];

/**
 * List of class names of transportable objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * Liste des noms de classes des objets transportables.
 * Le deuxi�me �l�ment des tableaux est le co�t de capacit� (en relation avec la capacit� des v�hicules).
 */
R3F_LOG_CFG_objets_transportables = R3F_LOG_CFG_objets_transportables +
[
	["Pchela1T", 15],
	["ATV_Base_EP1", 20],
	["MMT_base", 1],
	["Old_bike_base_EP1", 1],
	["M1030", 5],
	["Old_moto_base", 5],
	["TT650_Base", 5],
	["Fort_Crate_wood", 2],
	["Fort_RazorWire", 2],
	["Land_fort_bagfence_corner", 2],
	["Land_fort_bagfence_long", 2],
	["Land_fort_bagfence_round", 3],
	["Land_fortified_nest_small", 6],
	["Land_arrows_desk_R", 2],
	["Land_arrows_desk_L", 2],
	["Land_arrows_yellow_L",2],
	["Land_arrows_yellow_R",2],
	["Land_BagFenceCorner", 1],
	["Land_HBarrier1", 3],
	["Land_Toilet", 3],
	["RoadBarrier_light", 1],
	["RoadBarrier_long", 2],
	["Hedgehog", 5],
	["Land_coneLight", 1],
	["Pallets_comlumn", 1],
	["RoadCone", 1],
	["Sign_1L_Border", 1],
	["Sign_Danger", 1],
	["Land_Chair_EP1", 1],
	["WeaponBagBase_EP1", 3],
	["Land_CncBlock_Stripes",2],
	["ZavoraAnim",4],
	["GuerillaCacheBox_EP1",2],
	["Fort_Barricade_EP1",10],
	["Fort_Barricade",10],
	["Sign_Checkpoint_US_EP1",1],
	["Sign_Checkpoint_TK_EP1",1],
	["Land_CamoNetVar_NATO",5],
	["Land_CamoNetVar_EAST",5],
	["Land_CamoNetB_NATO",5],
	["Land_CamoNetB_EAST",5],
	["Land_CamoNet_NATO",5],
	["Land_CamoNet_EAST",5]
];


/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveable by player.
 * Liste des noms de classes des objets transportables par le joueur.
 */
R3F_LOG_CFG_objets_deplacables = R3F_LOG_CFG_objets_deplacables +
[
	"Fort_Crate_wood",
	"Fort_RazorWire",
	"Land_fort_bagfence_corner",
	"Land_fort_bagfence_long",
	"Land_fort_bagfence_round",
	"Land_fortified_nest_small",
	"Land_BagFenceCorner",
	"Land_BagFenceEnd",
	"Land_BagFenceLong",
	"Land_BagFenceRound",
	"Land_BagFenceShort",
	"Land_HBarrier1",
	"RoadBarrier_light",
	"RoadBarrier_long",
	"Sign_Danger",
	"Hedgehog",
	"Land_arrows_yellow_L",
	"Land_arrows_yellow_R",
	"Land_arrows_desk_R",
	"Land_arrows_desk_L",
	"Land_coneLight",
	"Pallets_comlumn",
	"RoadCone",
	"Sign_1L_Border",
	"Sign_Danger",
	"WeaponBagBase_EP1",
	"Land_CncBlock_Stripes",
	"GuerillaCacheBox_EP1",
	"ZavoraAnim",
	"Fort_Barricade_EP1",
	"Fort_Barricade",
	"Sign_Checkpoint_TK_EP1",
	"Sign_Checkpoint_US_EP1",
	"Land_CamoNetVar_NATO",
	"Land_CamoNetVar_EAST",
	"Land_CamoNetB_NATO",
	"Land_CamoNetB_EAST",
	"Land_CamoNet_NATO",
	"Land_CamoNet_EAST"
];
