/// @description Insert description here
// You can write your code in this editor

#region phase 2
	var stv_buffer_package_recived = async_load[? "buffer"]

	buffer_seek(stv_buffer_package_recived,buffer_seek_start,0)

	var stv_PACKET_KIND_ID = buffer_read(stv_buffer_package_recived,buffer_u8)
	

	switch (stv_PACKET_KIND_ID)
	{	
		//================================
		case SGE_NETWORK.JOIN://recieve the socket we are at server and we use it as our client id and player id 
		    slv_my_socket_at_server = buffer_read(stv_buffer_package_recived,buffer_u8)
		break;
		//=======================
		#region phase 3 network update players
		
		case SGE_NETWORK.UPDATE_PLAYERS: //update other players positions
			
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
				var stv_other_player_state = buffer_read(stv_buffer_package_recived,buffer_u8 )		
				var stv_other_player_health = buffer_read(stv_buffer_package_recived,buffer_s16 )		
				
				with(sobj_player)//please note, slv on with() will execute from inside sobj_player
				{				//while stv will execute from this(client_node) scope
								//acessing slv from client_node requires the 'other.' before 
					
					if(slv_player_id == stv_other_player_id && stv_other_player_id!= other.slv_my_player_id)
					{		
						
						//simple way (to use this remove slf_other_players_update() call from this client event
						//x = stv_other_player_x
						//y = stv_other_player_y
						
						
						//anti jitter on  (uses lerp on the slf_other_player_update [from sobj_player])
						slv_other_player_desired_pos_x =  stv_other_player_x
						slv_other_player_desired_pos_y =  stv_other_player_y
						slv_PLAYER_STATE = stv_other_player_state
						slv_player_health_display = stv_other_player_health
					}
				}
				
			}
		
		break;
		#endregion phase 3end
		//=============
		#region phase 4 campfire_update
			case SGE_NETWORK.CAMPFIRE_UPDATE:
				var stv_fuel_update = buffer_read(stv_buffer_package_recived,buffer_s16)
				sobj_campfire.spf_campfire_fuel_update(stv_fuel_update)
			
			break;
		#endregion phase 4 end
		
		//========================================
		#region phase 4 trees update
		case SGE_NETWORK.ITEMS_TREE_INITIALIZE:
		break;
		///======================================
		
		#region player_hit_player when frozen
		case SGE_NETWORK.PLAYER_HIT_PLAYER:
			var stv_player_hit_player_id = buffer_read(stv_buffer_package_recived,buffer_u16)
			with(sobj_player)
			{
				spf_check_get_hit_if_frozen(stv_player_hit_player_id)
			}
			
		break;
		
		#endregion//===========================
		//==========================
		
		///======================================
		#region
		case SGE_NETWORK.PLAYER_HIT_TREE:
			var stv_player_hit_tree_how_hit_id = buffer_read(stv_buffer_package_recived,buffer_u16)
			var stv_player_hit_tree_id = buffer_read(stv_buffer_package_recived,buffer_string)
			
			with(sobj_tree)
			{	
				spf_tree_hit(stv_player_hit_tree_id,stv_player_hit_tree_how_hit_id)
			
			}
		
		break;
		#endregion
		///======================================
		#region
		case SGE_NETWORK.ITEMS_TREE_UPDATE:
				var stv_tree_id_string = buffer_read(stv_buffer_package_recived,buffer_string)
				var stv_tree_hp = buffer_read(stv_buffer_package_recived,buffer_s16)
				var stv_tree_scale = buffer_read(stv_buffer_package_recived,buffer_s16)
				with(sobj_tree)
				{
					spf_tree_network_update_listen(stv_tree_id_string,stv_tree_hp,stv_tree_scale)
				}
				
		break;
		#endregion
		
		
		default:
		    // code here
		break;
	}



	#region buffer deletion,  manual says to reset buffer var after deleting it 
		sgf_buffer_deletion(stv_buffer_package_recived)
	#endregion

#endregion


