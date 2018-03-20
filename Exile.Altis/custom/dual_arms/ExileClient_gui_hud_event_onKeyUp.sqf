/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_stopPropagation","_caller","_keyCode","_shiftState","_controlState","_altState","_posObject","_step"];
_stopPropagation = false;
_caller = _this select 0;
_keyCode = _this select 1;
_shiftState = _this select 2;
_controlState = _this select 3;
_altState = _this select 4;
if (_keyCode in (actionKeys 'TacticalView'))exitWith{true};
switch (_keyCode) do  
{ 
	case 0x29:	{ _stopPropagation = true; }; 
	case 0x0B:	 	
	{ 
		if ((vehicle player) isEqualTo player) then
		{
			if (ExileClientIsAutoRunning) then
			{
				false call ExileClient_gui_hud_toggleAutoRunIcon;
				ExileClientIsAutoRunning = false;
				player switchMove "";
			}
			else 
			{
				true call ExileClient_gui_hud_toggleAutoRunIcon;
				ExileClientIsAutoRunning = true;
			};
		};
		_stopPropagation = true; 
	};
	case 0x08: 	{ _stopPropagation = true; };
	case 0x09: 	{ _stopPropagation = true; };
	case 0x0A: 	{ _stopPropagation = true; };
	case 0x3B: 	{ _stopPropagation = true; };
	case 0x3C: 	{ _stopPropagation = true; };
	case 0x3D:	{ _stopPropagation = true; };
	case 0x3E:	{ _stopPropagation = true; };
	case 0x3F:	
	{ 
		_stopPropagation = true; 
	};
	case 0x40: 	{ _stopPropagation = true; };
	case 0x41: 	{ _stopPropagation = true; };
	case 0x42:	{ _stopPropagation = true; };
	case 0x43: 	{ _stopPropagation = true; };
	case 0x44:	{ _stopPropagation = true; };
	case 0x57: 	{ _stopPropagation = true; };
	case 0x58: 	{ _stopPropagation = true; };
	case 0x0E: 	{ _stopPropagation = true; };
	case 0x02: 	
	{ 
		if (ExileClientIsInConstructionMode) then
		{
			ExileClientConstructionObject setObjectTexture[0, "#(argb,2,2,1)color(0.7,0.93,0,0.6,ca)"];
			ExileClientConstructionCurrentSnapToObject = objNull;
			ExileClientConstructionIsInSelectSnapObjectMode = false;
			ExileClientConstructionPossibleSnapPositions = [];
			ExileClientConstructionMode = 1; 
			[] call ExileClient_gui_constructionMode_update;
		}
		else 
		{
			if (primaryWeapon player != "") then
			{
				if (primaryWeapon player != currentWeapon player) then
				{
					player selectWeapon (primaryWeapon player);
				};
			};
		};
		_stopPropagation = true; 
	};
	case 0x03: 	
	{ 
		if (ExileClientIsInConstructionMode) then
		{
			ExileClientConstructionObject setObjectTexture[0, "#(argb,2,2,1)color(0.7,0.93,0,0.6,ca)"];
			ExileClientConstructionCurrentSnapToObject = objNull;
			ExileClientConstructionIsInSelectSnapObjectMode = false;
			ExileClientConstructionPossibleSnapPositions = [];
			ExileClientConstructionMode = 2; 
			[] call ExileClient_gui_constructionMode_update;
		}
		else 
		{
			if (handgunWeapon player != "") then
			{
				if (handgunWeapon player != currentWeapon player) then
				{
					player selectWeapon (handgunWeapon player);
				};
			};
		};
		_stopPropagation = true; 
	};
	case 0x04: 	
	{ 
		if (ExileClientIsInConstructionMode) then
		{
			if (ExileClientConstructionSupportSnapMode) then
			{
				if (ExileClientConstructionMode != 3) then 
				{
					ExileClientConstructionCurrentSnapToObject = objNull; 
					ExileClientConstructionPossibleSnapPositions = [];
					hintSilent "Look at the object you want to snap to, press SPACE to lock on it and then move your object next to a snap point. Press SPACE again to place object.";
				};
				ExileClientConstructionMode = 3; 
				ExileClientConstructionIsInSelectSnapObjectMode = true;
				[] call ExileClient_gui_constructionMode_update;
			};
		}
		else 
		{
			//Dual Arms Start
			if (secondaryWeapon player != "") then
			{
				if (((secondaryWeapon player) splitString "_") select ((count ((secondaryWeapon player) splitString "_"))-1) == "secondary") then 
				{
					(primaryWeapon player) spawn SecondaryWeapons_events_swapSecondaryWeapon;
				} else {
					if (secondaryWeapon player != currentWeapon player) then
					{
						player selectWeapon (secondaryWeapon player);
					};
				};
			} else {
				if (primaryWeapon player != "") then {
					(primaryWeapon player) call SecondaryWeapons_events_addSecondaryWeapon;
				};
			};
			//Dual Arms End
		};
		_stopPropagation = true; 
	};
	case 0x05: 	
	{ 
		if (ExileClientIsInConstructionMode) then
		{
			ExileClientConstructionModePhysx = !ExileClientConstructionModePhysx;
			[] call ExileClient_gui_constructionMode_update;
		}
		else
		{
			if (currentWeapon player != "") then
			{
				ExileClientPlayerHolsteredWeapon = currentWeapon player;
				player action["switchWeapon", player, player, 100];
			}
			else 
			{
				if (ExileClientPlayerHolsteredWeapon != "") then
				{
					player selectWeapon ExileClientPlayerHolsteredWeapon;
				};
			};
		};
		_stopPropagation = true;
	};
	case 0x06:
	{
		if (ExileClientIsInConstructionMode) then
		{
			ExileClientConstructionShowHint = !ExileClientConstructionShowHint;
			[] call ExileClient_gui_constructionMode_update;
		}
		else 
		{
			call ExileClient_system_music_earplugs_toggle;
		};
		_stopPropagation = true;
	};
	case 0x07:
	{
		if (ExileClientIsInConstructionMode) then
		{
			if(ExileClientConstructionLock)then
			{
				ExileClientConstructionLock = false;
				_posObject = position ExileClientConstructionObject;
				ExileClientConstructionOffset = player worldToModel _posObject;
				ExileClientConstructionRotation = (getDir ExileClientConstructionObject) - (getDir player);
			}
			else
			{
				ExileClientConstructionLock = true;
			};	
		}
		else
		{
			if (!ExileClientXM8IsVisible) then
			{
				if ("Exile_Item_XM8" in (assignedItems player)) then
				{
					if (alive player) then
					{
						[] call ExileClient_gui_xm8_show;
					};	
				};
			};
		};
		_stopPropagation = true;
	};
	case 0x39:
	{
		if (ExileClientIsInConstructionMode) then
		{
			if (ExileClientConstructionMode == 3) then 
			{
				if (ExileClientConstructionIsInSelectSnapObjectMode) then 
				{
					if !(isNull ExileClientConstructionCurrentSnapToObject) then
					{
						ExileClientConstructionIsInSelectSnapObjectMode = false;
						[] call ExileClient_gui_constructionMode_update;
					};
				}
				else 
				{
					if (ExileClientConstructionCanPlaceObject) then
					{
						ExileClientConstructionResult = 1;
					};
				};
			}
			else 
			{
				if (ExileClientConstructionCanPlaceObject) then
				{
					ExileClientConstructionResult = 1;
				};
			};
			_stopPropagation = true;
		};
	};
	case 0x01:
	{
		if (ExileClientIsInConstructionMode) then
		{
			_stopPropagation = true;
		};
	};
	case 0x10:
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 45;
			if (_shiftState) then 
			{
				_step = 90;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 22.5;
				};
			};
			ExileClientConstructionRotation = (ExileClientConstructionRotation - _step + 360) % 360;	
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
	case 0x12:
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 45;
			if (_shiftState) then 
			{
				_step = 90;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 22.5;
				};
			};
			ExileClientConstructionRotation = (ExileClientConstructionRotation + _step + 360) % 360;	
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
	case 0xC9: 
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 0.25;
			if (_shiftState) then 
			{
				_step = 1;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 0.025;
				};
			};
			ExileClientConstructionOffset set [2, ((((ExileClientConstructionOffset select 2) + _step) min 6) max -3) ];
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
	case 0xD1: 
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 0.25;
			if (_shiftState) then 
			{
				_step = 1;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 0.025;
				};
			};
			ExileClientConstructionOffset set [2, ((((ExileClientConstructionOffset select 2) - _step) min 6) max -3) ];
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
	case 0xC7: 
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 0.25;
			if (_shiftState) then 
			{
				_step = 1;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 0.025;
				};
			};
			ExileClientConstructionOffset set [1, (((ExileClientConstructionOffset select 1) + _step) min 6) max ExileClientConstructionBoundingRadius ];
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
	case 0xCF: 
	{
		if (ExileClientIsInConstructionMode) then
		{
			_step = 0.25;
			if (_shiftState) then 
			{
				_step = 1;
			}
			else 
			{
				if (_controlState) then
				{
					_step = 0.025;
				};
			};
			ExileClientConstructionOffset set [1, (((ExileClientConstructionOffset select 1) - _step) min 6) max ExileClientConstructionBoundingRadius ];
			[] call ExileClient_gui_constructionMode_update;
			_stopPropagation = true;
		};
	};
};
_stopPropagation