/**
 * SecondaryWeapons_player_hook
 *
 * Dual Arms Mod
 * Contact: Andrew#0693 on Discord
 * © 2020 Andrew_S90
 *
 * This mod may be used in private repos for units but reuploads on steam/armaholic/playwithsix are not allowed.
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 

[] spawn
{
	waitUntil {!isNull (findDisplay 46) && (alive player)};
	diag_log "SecondaryWeapons_hook Fired";
	
	SecondaryWeaponsSwapSecond = player addAction [format["Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")], { [] call SecondaryWeapons_SwitchToSecondary; } , "", 1.5, false, true, "", "(((secondaryWeapon player) !="""") && { (secondaryWeapon player != currentWeapon player) && {(((secondaryWeapon player) splitString ""_"") select ((count ((secondaryWeapon player) splitString ""_""))-1) != ""secondary"")}})", 0];
	if(SecondaryWeaponsAddAction) then
	{
		SecondaryWeaponsAddSecondary = player addAction [format["Put Weapon %1 on back", getText (configFile >> "CfgWeapons" >> (primaryWeapon player) >> "displayName")], { (primaryWeapon player) spawn SecondaryWeapons_events_addSecondaryWeapon; } , "", 1.6, false, true, "", "(((secondaryWeapon player) =="""") && { (isClass (configFile >> ""CfgWeapons"" >> format[""%1%2"",primaryWeapon player,""_secondary""]))})", 0];
		SecondaryWeaponsSwapPrimary = player addAction [format["Swap to Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")], { (primaryWeapon player) spawn SecondaryWeapons_events_swapSecondaryWeapon; } , "", 1.7, false, true, "", "((SecondaryWeaponsClassName !="""") && { ((isClass (configFile >> ""CfgWeapons"" >> format[""%1%2"",primaryWeapon player,""_secondary""])) || (primaryWeapon player == ""))})", 0];
	};
	
	if (((secondaryWeapon player) !="") && {((secondaryWeapon player) splitString "_") select ((count ((secondaryWeapon player) splitString "_"))-1) == "secondary"}) then {
		SecondaryWeaponsClassName = (secondaryWeapon player);
	};
	
	//DO NOT Uncomment these!!
	
	//SecondaryWeapons_InventoryOpened_EH = player addEventHandler ["InventoryOpened", { _this call SecondaryWeapons_events_onInventoryOpened}];
	//SecondaryWeapons_InventoryClosed_EH = player addEventHandler ["InventoryClosed", { _this call SecondaryWeapons_events_onInventoryClosed}];
	//SecondaryWeapons_Take_EH = player addEventHandler ["Take", { _this call SecondaryWeapons_events_onTake}];
	//SecondaryWeapons_Killed_EH = player addEventHandler ["Killed", { _this call SecondaryWeapons_events_onKilled}];
	
	waitUntil {(!alive player)};
	
	[] call SecondaryWeapons_postInit;
};