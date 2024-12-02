/// @description Insert description here
// You can write your code in this editor

image_alpha = sgf_get_alpha_devtools()

slv_ttl = 6
slv_creator_id_socket = slv_creator_id_socket //this var should be set when creating this item
slv_creator_id_instance = slv_creator_id_instance

sla_array_already_hit = array_create(0)

slf_step_update = function ()
{
	/*
	if (instance_exists(slv_creator_id_instance ))
	{
		x = slv_creator_id_instance.x
		y = slv_creator_id_instance.y
	}*/
	
	//========================
	#region///------check hit players, send network if hit player
	var stv_list = ds_list_create();
	var stv_num = instance_place_list(x, y, sobj_player, stv_list, false);
	
	if (stv_num > 0)
	{
		for (var i = 0; i < stv_num; ++i;)
		{
			var stv_instance_checking_now = stv_list[| i];
			if(!array_contains(sla_array_already_hit,stv_instance_checking_now))
			{
				array_push(sla_array_already_hit,stv_instance_checking_now)
				if(stv_instance_checking_now.slv_player_id != slv_creator_id_socket)
				{
					//show_message("hit"+string(stv_instance_checking_now.slv_player_id))	
					#region ======hit player send network=====================================
					var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
					buffer_seek(stv_buffer_id, buffer_seek_start,0)
					buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.PLAYER_HIT_PLAYER)
	
					buffer_write(stv_buffer_id,buffer_u16, stv_instance_checking_now.slv_player_id)
					
					var stv_socket_server_to_send_pack = sgf_get_socket_server_id_to_send_package()
					var stv_buffer_size = sgf_buffer_get_size(stv_buffer_id)
					
					network_send_packet(stv_socket_server_to_send_pack,
										stv_buffer_id,stv_buffer_size)
					
					sgf_buffer_deletion(stv_buffer_id)
					#endregion====================================
					
					
				}					
				else 
				{
					//show_message("hitting creator")
				}
			}
			
	    }
	}

	ds_list_destroy(stv_list); 
	#endregion
	//========================
	
	//==========
	#region treechecking
	
	var stv_list_tree = ds_list_create();
	var stv_num_tree = instance_place_list(x, y, sobj_tree, stv_list_tree, false);
	
	if(stv_num_tree>0)
	{
		
		for (var i_t = 0; i_t < stv_num_tree; ++i_t;)
		{
			var stv_instance_checking_now_tree = stv_list[| i_t];
			if(!array_contains(sla_array_already_hit , stv_instance_checking_now_tree))
			{
				array_push(sla_array_already_hit,stv_instance_checking_now_tree)
							
				var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
				buffer_seek(stv_buffer_id, buffer_seek_start,0)
				buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.PLAYER_HIT_TREE)
	
				buffer_write(stv_buffer_id,buffer_u16, slv_creator_id_socket)
				buffer_write(stv_buffer_id,buffer_string, stv_instance_checking_now_tree.sls_tree_id)
				
					
				var stv_socket_server_to_send_pack = sgf_get_socket_server_id_to_send_package()
				var stv_buffer_size = sgf_buffer_get_size(stv_buffer_id)
					
				network_send_packet(stv_socket_server_to_send_pack,
									stv_buffer_id,stv_buffer_size)
					
				sgf_buffer_deletion(stv_buffer_id)				
			}			
	    }
	}
	#endregion//==============
	//======================
	
	
	
	
	#region self destroy after timer
	slv_ttl--
	if(slv_ttl<0)
	{
		instance_destroy()
	}
	#endregion
}