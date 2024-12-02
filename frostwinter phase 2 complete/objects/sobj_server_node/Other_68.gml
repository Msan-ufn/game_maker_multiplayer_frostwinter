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
		
		
		#region phase 2 send back the socket client was connected on to be used as id  
			
			var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
			buffer_seek	(stv_buffer_id, buffer_seek_start, 0)		
			buffer_write(stv_buffer_id, buffer_u8, SGE_NETWORK.JOIN)
			buffer_write(stv_buffer_id, buffer_u8, stv_player_socket)
		
			
			
			var stv_buffer_size = buffer_tell(stv_buffer_id)
		
			network_send_packet(stv_player_socket, stv_buffer_id , stv_buffer_size)
			
			#region buffer deletion,  manual says to reset buffer var after deleting it 
				buffer_delete(stv_buffer_id)
				stv_buffer_id=-1
			#endregion
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
			

			if(stv_PACKET_KIND_ID == SGE_NETWORK.UPDATE)
			{	
				
				var stv_i = array_length(sla_player_list)
				
				
				var stv_buffer_player_id = buffer_read(stv_buffer_package_recived,buffer_u16)
				var stv_buffer_player_x = buffer_read(stv_buffer_package_recived,buffer_s16)				
				var stv_buffer_player_y = buffer_read(stv_buffer_package_recived,buffer_s16)
				
				var stv_buffer_player_update_all_id =buffer_create(32 , buffer_grow , 1)
				sgf_package_create_update_player_information(stv_buffer_player_update_all_id,
														stv_buffer_player_id,
														stv_buffer_player_x,
														stv_buffer_player_y)

				
				
				repeat(stv_i)
				{	
					stv_i--//this is used to run through the list of players
				
					var stv_buffer_size_update_all = buffer_tell(stv_buffer_player_update_all_id)
					network_send_packet(sla_player_list[stv_i],
								stv_buffer_player_update_all_id, 
								stv_buffer_size_update_all)
	
					//todo ADD PLAYER NAME AND PING TO THIS 
				}				
			}
		
		



			#region buffer deletion,  manual says to reset buffer var after deleting it 
				buffer_delete(stv_buffer_package_recived)
				stv_buffer_package_recived=-1
			#endregion




			#endregion phase 3 end			
	#endregion 	
}


//buffer_delete(stv_data_type)
//stv_data_type=-1