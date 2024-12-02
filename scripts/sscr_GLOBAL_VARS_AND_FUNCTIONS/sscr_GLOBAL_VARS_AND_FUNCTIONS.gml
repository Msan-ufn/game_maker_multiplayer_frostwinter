
#region DEV TOOL ITEMS YOU MAY EDIT SOME OF THESE VALUES
global.sgv_alpha_for_devtools = 0.5 //safe to edit
#endregion

#region GLOBAL VARS DECLARATION

global.sgv_ip_to_connect =  "127.0.0.1" // if no string is defined when joining , join localhost
global.sgv_port = 7676

global.sgv_max_players = 8

#endregion

randomize()




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





///@descripton hold a 'pointer' of the package, remember to clean/delete it after using
//package production
function sgf_package_create_update_player_information( stv_player_id,
														stv_player_x,
														stv_player_y,
														stv_player_state,
														stv_player_health)
{
	//please note stv_buffer_id(id.buffer) is a 'pointer' 
	var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.UPDATE_PLAYERS)
	
	buffer_write(stv_buffer_id,buffer_u16, stv_player_id)
	buffer_write(stv_buffer_id,buffer_s16, stv_player_x)
	buffer_write(stv_buffer_id,buffer_s16, stv_player_y)	
	buffer_write(stv_buffer_id,buffer_u8, stv_player_state)	
	buffer_write(stv_buffer_id,buffer_s16, stv_player_health)	
	
	return stv_buffer_id
}


function sgf_get_socket_server_id_to_send_package()
{
	return sobj_client_node.slv_client_socket_id
}

///@description prime buffer for informations using buffer_write
function sgf_buffer_creation()
{
	var stv_buffer_id =buffer_create(32,buffer_grow,1)
	buffer_seek(stv_buffer_id,buffer_seek_start,0)
	return stv_buffer_id
}

///@description clean buffer after finish using it \ this should usually be after a network_send_packet \ only dynamically created buffers need to be deleted \ async_load buffers get deleted after use automatically
function sgf_buffer_deletion (stv_buffer_id)
{
	buffer_delete(stv_buffer_id)
	stv_buffer_id=-1
}

function sgf_buffer_type(stv_buffer_id,sge_global_enum_for_type)
{
	buffer_write(stv_buffer_id,buffer_u8,sge_global_enum_for_type)
}

function sgf_buffer_get_size(stv_buffer_id)
{
	var stv_buffer_size = buffer_tell(stv_buffer_id)
	return stv_buffer_size
}




#region DEVTOOLS

function sgf_get_alpha_devtools()
{
	return global.sgv_alpha_for_devtools
}
#endregion



