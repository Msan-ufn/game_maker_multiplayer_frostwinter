/// @description Insert description here
// You can write your code in this editor


slv_camera_width  = 480 
slv_camera_height = 270

slv_target_to_follow = noone

slv_target_x = x
slv_target_y = y

slv_smooth_factor = 5 //smaller = faster camera follow


slv_snow_particle_system_id = instance_create_layer(x,y,sgf_get_layer_players(),sobj_particle_snow_constant)


slf_step_update = function ()
{
	if(slv_target_to_follow!= noone)
	{
		slv_target_x = slv_target_to_follow.x
		slv_target_y = slv_target_to_follow.y
	}
	x+= (slv_target_x-x)   / slv_smooth_factor
	y+= (slv_target_y-y)   / slv_smooth_factor
	
	self.slv_snow_particle_system_id.x = x
	self.slv_snow_particle_system_id.y = y
	
	camera_set_view_pos(view_camera[0] , x-slv_camera_width/2 , y-slv_camera_height/2)
	
	
}