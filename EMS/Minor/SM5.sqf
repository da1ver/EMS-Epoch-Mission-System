//Hummer Wreck by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
//Edited for EMS by Fuchs

private ["_coords","_wait","_MainMarker75"];
[] execVM "\z\addons\dayz_server\EMS\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords =  [getMarkerPos "center",0,4000,10,0,2000,0] call BIS_fnc_findSafePos;

diag_log "EMS: Minor mission created (SM5)";

//Mission accomplished
[nil,nil,rTitleText,"A Humvee has crashed! Check your map for the location!", "PLAIN",10] call RE;

MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_humveecrash = createVehicle ["HMMWVwreck",_coords,[], 0, "CAN_COLLIDE"];
_humveecrash setVariable ["Sarge",1,true];

_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 14, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate3] execVM "\z\addons\dayz_server\EMS\misc\fillBoxesH.sqf";
_crate3 setVariable ["permaLoot",true];

_aispawn = [_coords,40,4,3,1] execVM "\z\addons\dayz_server\EMS\add_unit_server.sqf";//AI Guards
sleep 1;
_aispawn = [_coords,50,4,3,1] execVM "\z\addons\dayz_server\EMS\add_unit_server.sqf";//AI Guards
sleep 1;

waitUntil{{isPlayer _x && _x distance _humveecrash < 30  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"The crash site has been secured by survivors!", "PLAIN",6] call RE;

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 5;

[0] execVM "\z\addons\dayz_server\EMS\minor\SMfinder.sqf";
