/// @description Insert description here
// You can write your code in this editor
image_alpha=sgf_get_alpha_devtools() 


slv_port = sgf_get_port()
slv_max_players = sgf_get_max_players()


slv_server_id = network_create_server(network_socket_tcp,slv_port,slv_max_players)

sla_player_list= array_create(0)

slv_is_game_running = false



//if server id = -1 failed to create server
if(slv_server_id<0)
{
	show_message("error creating server, another server is probably running already")
	game_restart()
}



//main server data manipulation 


slf_server_data = function ()
{
	
}




///@description this network update if focused in updating the players
slf_network_update_players = function (stv_buffer_package_received)
{
		
		
				
		#region reading info from player
		var stv_buffer_player_id = buffer_read(stv_buffer_package_received,buffer_u16)
		var stv_buffer_player_x = buffer_read(stv_buffer_package_received,buffer_s16)				
		var stv_buffer_player_y = buffer_read(stv_buffer_package_received,buffer_s16)
		var stv_buffer_player_state = buffer_read(stv_buffer_package_received,buffer_u8)
		var stv_buffer_player_health = buffer_read(stv_buffer_package_received,buffer_s16)
		#endregion
		
		#region preparing buffer to boardcast, tried using same buffer and bugged
		
		var stv_buffer_player_update_all_id = sgf_package_create_update_player_information(
												stv_buffer_player_id,
												stv_buffer_player_x,
												stv_buffer_player_y,
												stv_buffer_player_state,
												stv_buffer_player_health)

		
		var stv_i = array_length(sla_player_list)
		var stv_buffer_size_update_all = buffer_tell(stv_buffer_player_update_all_id)
		#endregion
		
		repeat(stv_i) //boardcasting update to all players
		{	
			stv_i--//this is used to run through the list of players
				
			
			network_send_packet(sla_player_list[stv_i],
						stv_buffer_player_update_all_id, 
						stv_buffer_size_update_all)
	
			//todo ADD PLAYER NAME AND PING TO THIS 
		}	
		
		sgf_buffer_deletion(stv_buffer_player_update_all_id)//clearing the buffer that was used to boardcast
		
}

slf_network_update_items = function (stv_buffer_package_received)
{
}

slf_network_update_player_hit_player = function (stv_buffer_package_received)
{
	var stv_buffer_player_id = buffer_read(stv_buffer_package_received,buffer_u16)
	
	
	
	var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.PLAYER_HIT_PLAYER)
	
	buffer_write(stv_buffer_id,buffer_u16, stv_buffer_player_id)
					
	var stv_i = array_length(self.sla_player_list)
	var stv_buffer_size_update_all = buffer_tell(stv_buffer_id)
	#endregion
		
	repeat(stv_i) //boardcasting update to all players
	{	
		stv_i--//this is used to run through the list of players
				
			
		network_send_packet(sla_player_list[stv_i],
					stv_buffer_id, 
					stv_buffer_size_update_all)
	
		
	}	
		
	sgf_buffer_deletion(stv_buffer_id)//clearing the buffer 
					
	
}


slf_network_update_player_hit_tree = function (stv_buffer_package_received)
{
	var stv_buffer_tree_who_hit_id = buffer_read(stv_buffer_package_received,buffer_u16)
	var stv_buffer_tree_id = buffer_read(stv_buffer_package_received,buffer_string)
	
	
	
	
	var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.PLAYER_HIT_TREE)
	
	buffer_write(stv_buffer_id,buffer_u16, stv_buffer_tree_who_hit_id)
	buffer_write(stv_buffer_id,buffer_text, stv_buffer_tree_id)
	
					
	var stv_i = array_length(self.sla_player_list)
	var stv_buffer_size_update_all = buffer_tell(stv_buffer_id)
	#endregion
		
	repeat(stv_i) //boardcasting update to all players
	{	
		stv_i--//this is used to run through the list of players
				
			
		network_send_packet(sla_player_list[stv_i],
					stv_buffer_id, 
					stv_buffer_size_update_all)
	
		
	}	
		
	sgf_buffer_deletion(stv_buffer_id)//clearing the buffer 
		
}




slf_network_update_tree = function (stv_buffer_package_received)
{
	var stv_buffer_tree_id = buffer_read(stv_buffer_package_received,buffer_string)
	var stv_buffer_tree_hp= buffer_read(stv_buffer_package_received,buffer_s16)
	var stv_buffer_tree_scale= buffer_read(stv_buffer_package_received,buffer_s16)
	

	
	var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.ITEMS_TREE_UPDATE)
	
	buffer_write(stv_buffer_id,buffer_string, stv_buffer_tree_id)
	buffer_write(stv_buffer_id,buffer_s16, stv_buffer_tree_hp)
	buffer_write(stv_buffer_id,buffer_s16, stv_buffer_tree_scale)
	
					
	var stv_i = array_length(self.sla_player_list)
	var stv_buffer_size_update_all = buffer_tell(stv_buffer_id)
	#endregion
		
	repeat(stv_i) //boardcasting update to all players
	{	
		stv_i--//this is used to run through the list of players
				
			
		network_send_packet(sla_player_list[stv_i],
					stv_buffer_id, 
					stv_buffer_size_update_all)
	
		
	}	
		
	sgf_buffer_deletion(stv_buffer_id)//clearing the buffer 
		
}



///public functions
///@description returns the array of connected players(which is their sockets)
///.======\\\\\\can be used to make a network_send====/////
spf_get_player_list_array = function()
{
	return sla_player_list
}
