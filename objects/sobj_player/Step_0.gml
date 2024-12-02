/// @description Insert description here
// You can write your code in this editor

#region phase 3
//slf_step_update_animation_control()



//very simple animation controller , allows to client change animation depending
//on what other players are doing , so it dont need to be sent as a package


#region animation control //phase 4 better animation controller


if(slv_PLAYER_STATE==SGE_PLAYER_STATE.FREE)
{
	if(x<xprevious)
	{
		image_xscale=-1
		sprite_index = sspr_player_white_walking
	}
	else if(x>xprevious)
	{
		image_xscale=1
		sprite_index = sspr_player_white_walking
	}
	else //if x == xprevious
	{
		sprite_index = sspr_player_white_idle
	}


	//todo , change this as it dont work for other players
	//related to bug#002
	if(!slv_is_grounded)
	{
		if(y <yprevious)
		{
			sprite_index = sspr_player_white_jumping
		}
		else if(y>yprevious&& abs (y-yprevious)>1)//this y-yprev causes the animation to "transition" between idle during the jump , looks better 
		{
			sprite_index = sspr_player_white_falling
		}	
	}
}
else if (slv_PLAYER_STATE== SGE_PLAYER_STATE.ATTACKING)
{
	if ( slv_PLAYER_STATE!= slv_player_last_state)
	{
		sprite_index = sspr_player_white_attacking
		image_index=0
		slv_has_attacked_in_this_frame_animation = false
	}
	if(round(image_index+0.25)> image_number - 2&& 			
			slv_player_id==sobj_client_node.slv_my_player_id)
	{
		if(!instance_exists(sobj_player_atk_hitbox))
		{
			var stv_y_offset = 7
			var stv_x_offset = 12
			if(!slv_has_attacked_in_this_frame_animation)
			{
				var stv_instance = instance_create_layer(x+(stv_x_offset*image_xscale),y+stv_y_offset,
													sgf_get_layer_players(),sobj_player_atk_hitbox)
				stv_instance.slv_creator_id_socket = slv_player_id
				stv_instance.slv_creator_id_instance = id
			}
		}
	}
		
	
	if(round(image_index+0.25)> image_number - 1) slv_PLAYER_STATE=SGE_PLAYER_STATE.FREE
}



if(slv_PLAYER_STATE ==SGE_PLAYER_STATE.FROZEN)
{
	sprite_index = sspr_player_white_frozen
}

if(slv_player_last_state!= slv_PLAYER_STATE)
{
	if(slv_player_last_state==SGE_PLAYER_STATE.FROZEN)
	repeat(5)
	{
		instance_create_layer(x,y,sgf_get_layer_players(),sobj_particle_ice_hit)
	}
}



slv_player_last_state = slv_PLAYER_STATE


#endregion


#endregion