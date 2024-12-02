#region phase 3//this player should not be created by itself, it always should be created by client node



//this code might think its running inside sobj_client_node but its only called
//inside a with(){} making it execute locally instead
// this may cause ide not recognize its local variables for autocomplete till its used once



//identification 
slv_player_id=slv_player_id 


#region //movement vars
slv_gravity = 0.2
slv_jump_power = 4.5

slv_is_grounded = false


slv_is_grounded_coyote_time_og = 10
slv_is_grounded_coyote_time_now = 0

slv_movement_x = 0
slv_movement_y = 0



slv_player_speed_og = 2.25

slv_player_speed_max_gravity = slv_player_speed_og * 6
slv_player_speed = slv_player_speed_og


slv_collision_tileset_id = sgf_get_collision_tileset_id()

#endregion

///==============================
#region //gameplay vars
slv_PLAYER_STATE = SGE_PLAYER_STATE.FREE
slv_player_last_state = slv_PLAYER_STATE

slv_player_health_max = 1000
slv_player_health_now = slv_player_health_max
slv_player_health_restore = round (slv_player_health_max/2)
slv_player_health_decrease = -1//-0.25 //this value must be negative
slv_player_health_increase = 5 //this value is used when warming by fire

slv_player_health_iced_max = 12 //how many hits to break ice
slv_player_health_iced_now = 0


slv_player_health_display = round(slv_player_health_max/10)

slv_is_carrying_wood = false

slv_has_attacked_in_this_frame_animation = false

#endregion

//===================================











slf_game_logic= function ()
{
/*	
	#region //gb ignore this
	self.slv_is_grounded_coyote_time_og = slv_is_grounded_coyote_time_og
	self.slv_is_grounded_coyote_time_now = slv_is_grounded_coyote_time_now
	self.slv_movement_x = slv_movement_x
	self.slv_movement_y = slv_movement_y
	self.slv_gravity = self.slv_gravity
	self.slv_is_grounded = slv_is_grounded
	self.slv_jump_power = slv_jump_power
	self.slv_collision_tileset_id=slv_collision_tileset_id
	self.slv_player_speed_max_gravity = real( slv_player_speed_max_gravity)
	self.slv_is_carrying_wood = slv_is_carrying_wood
	self.slv_PLAYER_STATE = slv_PLAYER_STATE
	#endregion //====
*/	
	
	//=====================================
	#region state change logic
	
	
	self.slv_player_health_now +=self.slv_player_health_decrease
	self.slv_player_health_display = round(slv_player_health_now/10)
	
	if(slv_player_health_now<=0)
	{
		slv_player_health_display = 0
		slv_player_health_now = 0
		slv_PLAYER_STATE = SGE_PLAYER_STATE.FROZEN
		if(slv_PLAYER_STATE !=self.slv_player_last_state)
		{
			self.slv_player_health_iced_now = self.slv_player_health_iced_max
		}
	}
	else if (slv_PLAYER_STATE == SGE_PLAYER_STATE.FROZEN && slv_player_health_now>0)
	{
		slv_PLAYER_STATE = SGE_PLAYER_STATE.FREE
	}
	
	
	if(keyboard_check(ord("E")) ||keyboard_check(ord("X")))
	{
		if(self.slv_PLAYER_STATE==SGE_PLAYER_STATE.FREE)
		{
			slv_PLAYER_STATE = SGE_PLAYER_STATE.ATTACKING
			//do attack			
		}
	}
	
	
	if(place_meeting(x,y,sobj_campfire))
	{
		if(slv_player_health_now < self.slv_player_health_max)
		{
			slv_player_health_now += self.slv_player_health_increase
		}
	}
	
	#endregion
	
	//=============================
	
	#region movement logic
	self.slv_player_speed = self.slv_player_speed_og
	
	var stv_movement_x = 0
	var stv_movement_y = 0
	
	var stv_jump_pressed = false
	
	
	if(keyboard_check(vk_shift))//fake srpint
	{
		slv_player_speed *= 1.5
	}
	
	
	
	if(keyboard_check(ord("W")) || keyboard_check(vk_up)||
	keyboard_check(vk_space)|| keyboard_check(ord("Z"))) stv_jump_pressed = true //stv_movement_y -= 1
	
	
	if(keyboard_check(ord("S")) || keyboard_check(vk_down))  stv_movement_y += 1
	if(keyboard_check(ord("A")) || keyboard_check(vk_left))  stv_movement_x -= 1
	if(keyboard_check(ord("D")) || keyboard_check(vk_right)) stv_movement_x += 1
	
	
	if (stv_jump_pressed && self.slv_is_grounded && slv_PLAYER_STATE==SGE_PLAYER_STATE.FREE)
	{
		self.slv_movement_y = - self.slv_jump_power
		self.slv_is_grounded = false//this helps coyote time not bug jumps	
	}
	else if (!stv_jump_pressed && slv_movement_y<0)
	{
		self.slv_movement_y /=10
	}
	
	var stv_speed_x = stv_movement_x*slv_player_speed + slv_movement_x
	var stv_speed_y = stv_movement_y*slv_player_speed + slv_movement_y
	
	
	
	if(slv_PLAYER_STATE == SGE_PLAYER_STATE.FREE)
	{
		var stv_collision_side_wall = move_and_collide(stv_speed_x,0,slv_collision_tileset_id,
										slv_player_speed,0,0,slv_player_speed,slv_player_speed)
	}
	
	
	var stv_collision_roof_ground = move_and_collide(0,stv_speed_y,slv_collision_tileset_id,
										slv_player_speed+1,0,0,0,real(slv_player_speed_max_gravity))	
	if(array_length(stv_collision_roof_ground)>0)
	{
		//todo need extra check here to make sure the ground is bellow
		//otherwise it works on ceiling
		//feature?
		//show_debug_message("grounded")
		self.slv_movement_y = slv_gravity
		self.slv_is_grounded = true
		//
		
		self.slv_is_grounded_coyote_time_now = self.slv_is_grounded_coyote_time_og
	}
	else
	{
		self.slv_is_grounded_coyote_time_now--
		if(slv_is_grounded_coyote_time_now<0)
		{
			//show_debug_message("floating")
			self.slv_is_grounded = false
			//slow down player here if you want to prevent jump spam
			
		}	
		else show_debug_message("coyote")
		
		self.slv_movement_y += self.slv_gravity
	}
	#endregion
	//========================================================
	#region interaction logic
	
	var stv_firewood_meeting = instance_place(x,y,sobj_item_firewood)
	if(stv_firewood_meeting!= noone && !slv_is_carrying_wood)
	{
		slv_is_carrying_wood=true
		instance_destroy( stv_firewood_meeting)
	}
	
	var stv_campfire_meeting = instance_place(x,y,sobj_campfire) 
	if(stv_campfire_meeting!=noone && slv_is_carrying_wood)
	{
		slv_is_carrying_wood=false
		
		stv_campfire_meeting.spf_campfire_add_fuel_server_request(1000)		
		
		
	}
	#endregion

}//=============--------------game logic--------===========
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//this is called inside client node when player is the client player	
slf_network_update_self = function ()
{
	
	var stv_buffer_id = sgf_package_create_update_player_information
						(slv_player_id,	x,y,slv_PLAYER_STATE,slv_player_health_display)
													
	var stv_buffer_size = buffer_tell(stv_buffer_id)
	var stv_server_socket = sgf_get_socket_server_id_to_send_package()
	network_send_packet(stv_server_socket , stv_buffer_id, stv_buffer_size)
	
	
	
	sgf_buffer_deletion(stv_buffer_id)
		
	
	
}


slv_other_player_desired_pos_x = 0
slv_other_player_desired_pos_y = 0

///@description called inside the client node when package is recieved from other players, should be used inside a with() 
slf_other_players_update = function ()
{
	#region //gb not needed
	slv_other_player_desired_pos_x=slv_other_player_desired_pos_x
	slv_other_player_desired_pos_y=slv_other_player_desired_pos_y
	#endregion
	//smooth movement for other players on the client side of things
	x = lerp(x, real ( slv_other_player_desired_pos_x ) ,0.5)
	y = lerp(y, real ( slv_other_player_desired_pos_y ),0.5)
	
	#region //make sure it dont take too long to stop so animation dont break	
	if(abs(y-slv_other_player_desired_pos_y)<1) 	y = slv_other_player_desired_pos_y
	if(abs(x-slv_other_player_desired_pos_x)<1) 	x = slv_other_player_desired_pos_x
	#endregion
}

	
	
	
spf_check_get_hit_if_frozen = function(stv_id_who_got_hit)
{
	if(self.slv_PLAYER_STATE == SGE_PLAYER_STATE.FROZEN &&
			stv_id_who_got_hit == self.slv_player_id)
	{
		instance_create_layer(x,y,sgf_get_layer_players(),sobj_particle_ice_hit)
		self.slv_player_health_iced_now--
		if(slv_player_health_iced_now<=0)
		{
			self.slv_player_health_now = self.slv_player_health_restore
			
			
			
			//slv_PLAYER_STATE = SGE_PLAYER_STATE.FREE
			// /\ hot needed as any health above 0 remove frozen state
		}
		
		//reduce ice duration here
		//if ice duration <=0 
		//increase health
	}
}
#endregion