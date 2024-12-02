
#region DEV TOOL ITEMS YOU MAY EDIT SOME OF THESE VALUES
global.sgv_alpha_for_devtools = 0.5 //safe to edit
#endregion

#region GLOBAL VARS DECLARATION

global.sgv_ip_to_connect =  "127.0.0.1" // if no string is defined when joining , join localhost
global.sgv_port = 7676

global.sgv_max_players = 8

#endregion




#region ip manipulation for connection
	function sgf_get_ip()
	{
		return global.sgv_ip_to_connect
	}

	function sgf_set_ip(stv_string)
	{
		global.sgv_ip_to_connect = string(stv_string)
	}
#endregion

function sgf_get_port()
{
	return global.sgv_port
}

function sgf_get_max_players()
{
	return global.sgv_max_players
}

#region DEVTOOLS

function sgf_get_alpha_devtools()
{
	return global.sgv_alpha_for_devtools
}
#endregion
