
#region DEV TOOL ITEMS YOU MAY EDIT SOME OF THESE VALUES
global.sgv_alpha_for_devtools = 0.5 //safe to edit
#endregion

#region GLOBAL VARS DECLARATION

global.sgv_ip_to_connect =  "127.0.0.1" // if no string is defined when joining , join localhost
global.sgv_port = 7676

global.sgv_max_players = 8

#endregion



#region collision tilesets
function sgf_get_collision_tileset_id()
{
	var lay_id = layer_get_id("stls_layer_tileset_collision_bg");
	var stv_tileset_id = layer_tilemap_get_id(lay_id);
	return stv_tileset_id
}
#endregion



#region ip/port manipulation for connection
	function sgf_get_ip()
	{
		return global.sgv_ip_to_connect
	}

	function sgf_set_ip(stv_string)
	{
		global.sgv_ip_to_connect = string(stv_string)
	}


	function sgf_get_port()
	{
		return global.sgv_port
	}
	
#endregion

function sgf_get_max_players()
{
	return global.sgv_max_players
}





//package productions
function sgf_package_create_update_player_information(stv_buffer_id,
														stv_player_id,
														stv_player_x,
														stv_player_y)
{
	//please note stv_buffer_id is a 'pointer' 
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.UPDATE)
	
	buffer_write(stv_buffer_id,buffer_u16, stv_player_id)
	buffer_write(stv_buffer_id,buffer_s16, stv_player_x)
	buffer_write(stv_buffer_id,buffer_s16, stv_player_y)	

}









#region DEVTOOLS

function sgf_get_alpha_devtools()
{
	return global.sgv_alpha_for_devtools
}
#endregion



