INV_Licenses =
    [

        ["car",[licenseflag3,southlicense1,university,licenseflag5],localize "STRS_license_car",5000],
        ["truck",[licenseflag3,southlicense1,university,licenseflag5],localize "STRS_license_truck",32500],
        ["oil",[Oil_1,Oil_1,Oil_2,Oil_2],"Oil Processor's License",45000],
        ["diamond",[Diamond_1,Diamond_1,Diamond_1,Diamond_1],"Diamond Processor's License",95000],
        ["glassblowing",[Glassblower,Glassblower,Glassblower,Glassblower],localize "STRS_license_glassblowerlicense",65000],
        ["cocaine ga1",[gangarea1,gangarea1,gangarea1,gangarea1],"GA1 Cocaine Processing Training",45000],
        ["lsd ga1",[gangarea1,gangarea1,gangarea1,gangarea1],"GA1 LSD Processing Training",30000],
        ["heroin ga2",[gangarea2,gangarea2,gangarea2,gangarea2],"GA2 Heroin Processing Training",50000],
        ["lsd ga2",[gangarea2,gangarea2,gangarea2,gangarea2],"GA2 LSD Processing Training",30000],
        ["heroin ga3",[gangarea3,gangarea3,gangarea3,gangarea3],"GA3 Heroin Processing Training",50000],
        ["marijuana ga3",[gangarea3,gangarea3,gangarea3,gangarea3],"GA3 Marijuana Processing Training",17000],
        ["air",[licenseflag3,licenseflag5,university,southlicense1],localize "STRS_license_air",500000],
		["jet",[licenseflag3,licenseflag5,southlicense1,university],localize "STRS_license_jet",400000],
        ["pistollicense",[pmcatm,licenseflag2,licenseflag2,licenseflag2],"Pistol License",40000],
        ["riflelicense",[pmcatm,licenseflag2,licenseflag2,licenseflag2],"Rifle License",125000],
        ["automatic",[pmcatm,licenseflag2,licenseflag2,licenseflag2],"Assault Weapon License",205000],
		["engineer",[southlicense1,university,atmins,atm5],localize "STRS_license_engineer",65000],
        ["bomb",[airshop3,atmins,atm5,terrorshop],"Combat Training",350000],
        ["probator",[copbank,copbank,copbank,copbank],localize "STRS_license_probator",10000],
        ["patrol_training",[copbank,copbank,copbank,copbank],localize "STRS_license_coppatrol",15000],
        ["response_training",[copbank,copbank,copbank,copbank],localize "STRS_license_copresponse",150000],
        ["sobr_training",[copbank,copbank,copbank,copbank],localize "STRS_license_copswat",500000],
        ["air_support_training",[copbank,copbank,copbank,copbank],localize "STRS_license_copairsupport",225000],
        ["passport_civilian",[licenseflag3,licenseflag3,licenseflag5,licenseflag5],"Takistani Passport",35000],
        ["pmc_license_journeyman",[pmcatm,pmcatm,pmcatm,pmcatm],"PMC Journeyman License",1350000],
        ["pmc_license_defense",[pmcatm,pmcatm,pmcatm,pmcatm],"PMC Defense License",350000],
        ["pmc_license_air",[pmcatm,pmcatm,pmcatm,pmcatm],"PMC Pilot License",850000],
		["soviet_vehicles",[atmins,atm5,airshop3,terrorshop],"Soviet Vehicle Training",500000],
        ["soviet_air_veh",[atmins,atm5,airshop3,terrorshop],"Soviet Aircraft Training",300000],
        ["paramedic_license",[tdoc,tdoc,tdoc_1,tdoc_1],"Paramedic Training",750000],
		["donator",[null,null,null,null],"Donator License",999999999],
		["viplicense",[null,null,null,null],"VIP Donator License",999999999],
		["highcaliberrifle",[licenseflag2,licenseflag2,licenseflag2,licenseflag2],"High Caliber Rifle License",250000],
		["newslicense",[atmnews,atmnews,atmnews,atmnews],"News Reporters License",150000],
		["hitman",[hitshop,hitshop,hitshop,hitshop],"Hitman License",1700000]
        //["assassin",[agunshop,agunshop,objnull],"Assassin Training",30000]
    ];

["INV_LicenseOwner", []] call stats_init_variable;