

class CfgExileCustomCode 
{
	/*
		You can overwrite every single file of our code without touching it.
		To do that, add the function name you want to overwrite plus the 
		path to your custom file here. If you wonder how this works, have a
		look at our bootstrap/fn_preInit.sqf function.

		Simply add the following scheme here:

		<Function Name of Exile> = "<New File Name>";

		Example:

		ExileClient_util_fusRoDah = "myaddon\myfunction.sqf";
	*/
	
	//Dual Arms Client
	ExileClient_object_player_event_onInventoryClosed = "custom\dual_arms\ExileClient_object_player_event_onInventoryClosed.sqf";
	ExileClient_object_player_event_onInventoryOpened = "custom\dual_arms\ExileClient_object_player_event_onInventoryOpened.sqf";
	ExileClient_object_player_event_onKilled = "custom\dual_arms\ExileClient_object_player_event_onKilled.sqf";
	ExileClient_object_player_event_onTake = "custom\dual_arms\ExileClient_object_player_event_onTake.sqf";
	ExileClient_gui_hud_event_onKeyUp = "custom\dual_arms\ExileClient_gui_hud_event_onKeyUp.sqf";
	
	//Dual Arms Server
	ExileServer_system_network_event_onHandleDisconnect = "custom\dual_arms\ExileServer_system_network_event_onHandleDisconnect.sqf";
};