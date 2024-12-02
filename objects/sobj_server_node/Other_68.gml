/// @description Insert description here
// You can write your code in this editor
var stv_data_type = async_load[? "type"]


switch (stv_data_type) 
{
	#region connect
    case network_type_connect:
        var stv_player_socket = async_load[? "socket"]
		
		//show_message("connecting player socket:"+string(stv_player_socket))
		
		array_push(sla_player_list,stv_player_socket)
		
		//phase 4
		
		
		#region phase 2 send back the socket client was connected on to be used as id  
			
			var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
			buffer_seek	(stv_buffer_id, buffer_seek_start, 0)		
			buffer_write(stv_buffer_id, buffer_u8, SGE_NETWORK.JOIN)
			buffer_write(stv_buffer_id, buffer_u8, stv_player_socket)
		
			
			
			var stv_buffer_size = buffer_tell(stv_buffer_id)
		
			network_send_packet(stv_player_socket, stv_buffer_id , stv_buffer_size)
			
			
			sgf_buffer_deletion(stv_buffer_id)
			
		#endregion
	break;
	#endregion
	#region disconnect
	case network_type_disconnect:
        var stv_disconnect_socket = async_load[? "socket"]
		//show_message("disconnecting:"+string(stv_disconnect_socket))
		
		var stv_array_index_to_delete = array_get_index(sla_player_list,stv_disconnect_socket)
		array_delete(sla_player_list,stv_array_index_to_delete,1)
		
	break;
	#endregion
	
	#region data transfer
	case network_type_data:
		//this bulk data manipulation is set on the create event for clarity
		
		#region phase 3
			var stv_buffer_package_recived = async_load[? "buffer"]
			
			buffer_seek(stv_buffer_package_recived,buffer_seek_start,0)

			var stv_PACKET_KIND_ID = buffer_read(stv_buffer_package_recived,buffer_u8)
			show_debug_message(stv_PACKET_KIND_ID)
			switch (stv_PACKET_KIND_ID)
			{
				///==========================
			    case SGE_NETWORK.UPDATE_PLAYERS:
			        slf_network_update_players(stv_buffer_package_recived)
			    break;
				///==========================
				case SGE_NETWORK.UPDATE_ITEMS:
					slf_network_update_items(stv_buffer_package_recived)
				break;
				///==========================
				case SGE_NETWORK.CAMPFIRE_ADD_FUEL:					
					var stv_campfire_fuel_to_add = buffer_read(stv_buffer_package_recived,buffer_s16)
					sobj_server_campfire_node.spf_server_add_fuel_to_campfire(stv_campfire_fuel_to_add)
				break;
				///==========================
				case SGE_NETWORK.PLAYER_HIT_PLAYER:
					slf_network_update_player_hit_player(stv_buffer_package_recived)					
				break;
				///==========================
				case SGE_NETWORK.PLAYER_HIT_TREE:
					slf_network_update_player_hit_tree(stv_buffer_package_recived)					
				break;
				///==========================
				case SGE_NETWORK.ITEMS_TREE_UPDATE:
					slf_network_update_tree(stv_buffer_package_recived)					
				break;
			
			
			}   
			   



		#endregion phase 3 end			
	#endregion 	
}




//buffer_delete(stv_data_type)
//stv_data_type=-1