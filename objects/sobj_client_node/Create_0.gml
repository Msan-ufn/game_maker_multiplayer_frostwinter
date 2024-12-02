/// @description Insert description here
// You can write your code in this editor
image_alpha=sgf_get_alpha_devtools()

show_message("trying to connect to ip: "+sgf_get_ip()+"\n press ok to continue")


#region nodes are singular objects that control networking , there shouldnt be more than one of the same time on a room
var stv_client_node_count = 0 
with(sobj_client_node)
{
	stv_client_node_count++
}

if (stv_client_node_count>1)
{
	show_message("WARNING: MORE THAN 1 CLIENT NODE DETECTED")
}
#endregion


//=====
slv_ip = sgf_get_ip()
slv_port = sgf_get_port()

slv_my_socket_at_server = -1//phase 2 var
slv_my_player_id = slv_my_socket_at_server//phase 3 var


#region//connection 
	//set timeout to not freeze game if connection fails
	network_set_config(network_config_connect_timeout,3000); 
	slv_client_socket_id = network_create_socket(network_socket_tcp)//local socket used on destroy

	slv_network_connection = network_connect(slv_client_socket_id,slv_ip,slv_port)
#endregion

//if -1 means creating connection failed
if(slv_network_connection<0)
{
	show_message("cannot connect to server")
	game_restart()
}





#region phase 3 

//VARS =====

sla_connected_players = array_create(0)






//======STEP EVENT ==================
slf_step_update = function ()
{
	#region the player that we control is created here and its id is set to the same as the socket we are returned by the server making our player and client id the same so we can find it later
	if(slv_my_socket_at_server!= -1 && slv_my_player_id==-1)//!slv_was_player_created && 
	{
	
		slv_my_player_id = slv_my_socket_at_server
		var stv_player = instance_create_layer(x,y,sgf_get_layer_players(),sobj_player)
		stv_player.slv_player_id = slv_my_player_id
		var stv_camera = instance_create_layer(x,y,sgf_get_layer_players(),sobj_camera)
		stv_camera.slv_target_to_follow = stv_player
		
		with(sobj_tree)
		{
			spf_tree_id_initialize()
		}
	}
	#endregion
	
	
	with(sobj_player)
	{
		//all code inside 'with' will execute on each instance of sobj_player, 
		//other. on this if refers to the calling client node
		if(slv_player_id == other.slv_my_player_id)
		{
			//we look through the sobj_players to find ours and then execute his functions
			//these function are inside sobj_player
			slf_game_logic()
			slf_network_update_self()
		}		
		else 
		{
			slf_other_players_update()
		}
	}
	
}






#endregion end phase 3