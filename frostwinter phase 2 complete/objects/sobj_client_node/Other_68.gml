/// @description Insert description here
// You can write your code in this editor

#region phase 2
	var stv_buffer_package_recived = async_load[? "buffer"]

	buffer_seek(stv_buffer_package_recived,buffer_seek_start,0)

	var stv_PACKET_KIND_ID = buffer_read(stv_buffer_package_recived,buffer_u8)
	

	switch (stv_PACKET_KIND_ID)
	{	
		case SGE_NETWORK.JOIN://recieve the socket we are at server and we use it as our client id and player id 
		    slv_my_socket_at_server = buffer_read(stv_buffer_package_recived,buffer_u8)
		break;
		
		#region phase 3
		case SGE_NETWORK.UPDATE: //update other players positions
			
			var stv_other_player_id = buffer_read(stv_buffer_package_recived,buffer_u16)
			
			//findplayer id
			//if missing and not our own player package create a new player with its id
			if(!array_contains(sla_connected_players,stv_other_player_id) 
						&&stv_other_player_id!=slv_my_player_id)
			{
				array_push(sla_connected_players, stv_other_player_id)
				var stv_new_player = instance_create_layer(x,y,sgf_get_layer_players(),sobj_player)
				stv_new_player.slv_player_id = stv_other_player_id
			}
			
			//note : here we use 1 packet to create the online player , and only update its position
			// on the next packate, for clarity sake we will accept the 'lost' of 1 frame of position update
			
			else
			{
			
				var stv_other_player_x = buffer_read(stv_buffer_package_recived,buffer_s16)				
				var stv_other_player_y = buffer_read(stv_buffer_package_recived,buffer_s16 )		
				
				with(sobj_player)//please note, slv on with will execute from inside sobj_player
				{				//while stv will execute from this(client_node) scope
					
					if(slv_player_id == stv_other_player_id && stv_other_player_id!= other.slv_my_player_id)
					{		
						
						//simple way (to use this remove slf_other_players_update() call from this client event
						//x = stv_other_player_x
						//y = stv_other_player_y
						
						
						//anti jitter on  
						slv_other_player_desired_pos_x =  stv_other_player_x
						slv_other_player_desired_pos_y =  stv_other_player_y
					}
				}
				
			}
		#endregion phase 3end
		break;
		
		
		default:
		    // code here
		break;
	}



	#region buffer deletion,  manual says to reset buffer var after deleting it 
		buffer_delete(stv_buffer_package_recived)
		stv_buffer_package_recived=-1
	#endregion


#endregion