/// @description phase 4
// You can write your code in this editor





slv_campfire_fuel = 6000
slv_campfire_fuel_lost_per_step = 1


slf_step_update = function ()
{
	if(slv_campfire_fuel>0)
	{
		slv_campfire_fuel -= slv_campfire_fuel_lost_per_step
	}
	
	
	#region network update
	
	var stv_buffer_to_all_players = buffer_create(32 , buffer_grow , 1)
	
	
	
	buffer_seek(stv_buffer_to_all_players, buffer_seek_start,0)
	buffer_write(stv_buffer_to_all_players,buffer_u8, SGE_NETWORK.CAMPFIRE_UPDATE)
	
	buffer_write(stv_buffer_to_all_players,buffer_s16, slv_campfire_fuel)
	
	
	var stv_buffer_size = buffer_tell(stv_buffer_to_all_players)
	
	
	var sta_player_list = array_create(0)
	sta_player_list = sobj_server_node.spf_get_player_list_array()
	var stv_i = array_length(sta_player_list)
	
	
	repeat(stv_i)
	{	
		stv_i--//this is used to run through the list of players
				
		
		network_send_packet(sta_player_list[stv_i],
					stv_buffer_to_all_players, 
					stv_buffer_size)
	
		//todo ADD PLAYER NAME AND PING TO THIS 
	}	
		
	sgf_buffer_deletion(stv_buffer_to_all_players)
	
	
	
	
	#endregion
}





spf_server_add_fuel_to_campfire = function(stv_campfire_fuel_to_add_server)
{
	slv_campfire_fuel+=stv_campfire_fuel_to_add_server
}

