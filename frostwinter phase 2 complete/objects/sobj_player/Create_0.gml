#region phase 3//this player should not be created by itself, it always should be created by client node
//show_message("iam alive")


//this code might think its running inside sobj_client_node but its only called
//inside a with(){} making it execute locally instead
// this may cause ide not recognize its local variables for autocomplete till its used once




slv_player_id=slv_player_id 



slv_gravity = 0.5
slv_jump_power = 7
slv_is_grounded = false



slv_movement_x = 0
slv_movement_y = 0



slv_player_speed_og = 4	

slv_player_speed_max_gravity = slv_player_speed_og * 3
slv_player_speed = slv_player_speed_og





slv_collision_tileset_id = sgf_get_collision_tileset_id()





slf_game_logic= function ()
{
	slv_movement_x = slv_movement_x
	slv_movement_y = slv_movement_y
	slv_gravity = slv_gravity
	slv_is_grounded = slv_is_grounded
	slv_jump_power = slv_jump_power
	slv_player_speed_max_gravity = real( slv_player_speed_max_gravity)
	
	slv_player_speed = slv_player_speed_og
	
	var stv_movement_x = 0
	var stv_movement_y = 0
	
	var stv_jump_pressed = false
	
	
	if(keyboard_check(vk_shift))//fake srpint
	{
		slv_player_speed *= 1.5
	}
	
	
	
	if(keyboard_check(ord("W")) || keyboard_check(vk_up)) stv_jump_pressed = true //stv_movement_y -= 1
	if(keyboard_check(ord("S"))|| keyboard_check(vk_down))  stv_movement_y += 1
	if(keyboard_check(ord("A")) || keyboard_check(vk_left))  stv_movement_x -= 1
	if(keyboard_check(ord("D"))|| keyboard_check(vk_right)) stv_movement_x += 1
	
	
	if (stv_jump_pressed && slv_is_grounded)
	{
		slv_movement_y = -slv_jump_power
	
	}
	else if (!stv_jump_pressed && slv_movement_y<0)
	{
		slv_movement_y /=10
	}
	
	var stv_speed_x = stv_movement_x*slv_player_speed + slv_movement_x
	var stv_speed_y = stv_movement_y*slv_player_speed + slv_movement_y
	
	
	
	var stv_collision_side_wall = move_and_collide(stv_speed_x,0,slv_collision_tileset_id,
										slv_player_speed,0,0,slv_player_speed,slv_player_speed)
	
	var stv_collision_roof_ground = move_and_collide(0,stv_speed_y,slv_collision_tileset_id,
										slv_player_speed,0,0,slv_player_speed_max_gravity,slv_player_speed_max_gravity)	
	if(array_length(stv_collision_roof_ground)>0)
	{
		//todo need extra check here to make sure the ground is bellow
		//otherwise it works on ceiling
		//feature?
		show_debug_message("grounded")
		slv_movement_y = slv_gravity
		slv_is_grounded = true
		
	}
	else
	{
		show_debug_message("floating")
		slv_is_grounded = false
		slv_movement_y += slv_gravity
	}

}
	
	
	
	
//this is called inside client node when player is the client player	
slf_network_update_self = function ()
{
	
	var stv_buffer_id=buffer_create(32 , buffer_grow , 1)

	sgf_package_create_update_player_information(stv_buffer_id,
													slv_player_id,
													x,
													y)
													
	var stv_buffer_size = buffer_tell(stv_buffer_id)
	network_send_packet(sobj_client_node.slv_client_socket_id, stv_buffer_id, stv_buffer_size)
	
	
	#region buffer deletion,  manual says to reset buffer var after deleting it 
		buffer_delete(stv_buffer_id)
		stv_buffer_id=-1
	#endregion
	
}


slv_other_player_desired_pos_x = 0
slv_other_player_desired_pos_y = 0
slf_other_players_update = function ()
{
	
	
	
	x = lerp(x, real ( slv_other_player_desired_pos_x ) ,0.5)
	y = lerp(y, real ( slv_other_player_desired_pos_y ),0.5)
}

	
#endregion