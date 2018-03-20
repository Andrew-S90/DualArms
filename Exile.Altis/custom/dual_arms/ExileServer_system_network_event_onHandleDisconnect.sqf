/**
 * ExileServer_system_network_event_onHandleDisconnect
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ["_unit", "_newUnitDeaths", "_constructionObject", "_animal", "_sessionID", "_SWInfo", "_uniform", "_vest", "_backpack", "_containers", "_item", "_className", "_array", "_added"];
_unit = _this select 0;
_id = _this select 1;
_uid = _this select 2;
_name = _this select 3;
_pos = getPos _unit;
_newUnitDeaths = _unit getVariable ["ExileDeaths", 0];
if !(_uid in ["", "__SERVER__", "__HEADLESS__"]) then
{
	_constructionObject = _unit getVariable ["ExileConstructionObject", objNull];
	if !(isNull _constructionObject) then 
	{
		deleteVehicle _constructionObject;
	};
	if (_unit getVariable ["IsPlayingRussianRoulette", false]) then 
	{
		_unit call ExileServer_system_russianRoulette_event_onPlayerDisconnected;
		_unit setVariable ["ExileIsDead", false];
	};
	_animal = missionNamespace getVariable [format ["ExileAnimal%1", _uid], objNull];
	if !(isNull _animal) then
	{
		deleteVehicle _animal;
		missionNamespace setVariable [format ["ExileAnimal%1", _uid], nil];
	};
	format["endAccountSession:%1", _uid] call ExileServer_system_database_query_fireAndForget;
	_sessionID = _unit getVariable ["ExileSessionID", ""];
	_sessionID call ExileServer_system_session_end;
	_unit setVariable ["ExileSessionID", nil];
	if !(_unit getVariable ["ExileIsDead", false]) then
	{
		//Dual Arms Start

		_SWInfo = _unit getVariable ["SecondaryWeaponsWeaponInfo", []];
				
		if(count _SWInfo > 0) then
		{
			_uniform = uniformContainer _unit;
			_vest = vestContainer _unit;
			_backpack = backpackContainer _unit;
			_containers = [_uniform, _vest, _backpack];
			{
				_item = _x;
				_className = "";
				_array = false;
				_added = false;
				if(typeName _item isEqualTo "ARRAY") then
				{
					_array = true;
					_className = _x select 0;
				} else {
					_className = _x;
				};
				
				{
					if (!(isNull _x)) then 
					{
						if (_x canAdd [_className, 1]) exitWith 
						{
							if(_array) then
							{
								_unit addMagazine [_className, _item select 1];
							} else {
								_className = [_className, 0, -10] call BIS_fnc_trimString;
								_unit addItem _className;
							};
							_added = true;
						};
					};
					if (_added) exitWith {};
				} forEach _containers;
			} forEach _SWInfo;
		};	
		//Dual Arms End
		
		if (_unit getVariable ["ExileIsHandcuffed", false]) then 
		{
			_unit setDamage 999;
			format["insertPlayerHistory:%1:%2:%3:%4:%5", _uid, _name, _pos select 0, _pos select 1, _pos select 2] call ExileServer_system_database_query_fireAndForget;
			format["deletePlayer:%1", _unit getVariable ["ExileDatabaseId", -1]] call ExileServer_system_database_query_fireAndForget;
			_unit setVariable ["ExileIsDead", true];
			_unit setVariable ["ExileName", _name, true]; 
			_unit call ExileServer_object_flies_spawn;
			_newUnitDeaths = _newUnitDeaths + 1;
			_unit setVariable ["ExileDeaths", _newUnitDeaths];
			format["addAccountDeath:%1", _uid] call ExileServer_system_database_query_fireAndForget;
			_unit call ExileServer_object_player_sendStatsUpdate;
			["systemChatRequest", [format["HANDCUFF LOGOUT: %1 has been killed.", name _unit]]] call ExileServer_system_network_send_broadcast;
		}
		else 
		{
			_unit call ExileServer_object_player_database_update;	
			deleteVehicle _unit;
			_unit = objNull;
		};
	};
};
if !(isNull _unit) then 
{
	[_unit] joinSilent (createGroup independent);
};
false