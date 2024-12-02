/// @description Insert description here
// You can write your code in this editor
if(slv_tree_hp<=0)
{
	var stv_y_offset = 10
	repeat(10)
	{
		instance_create_layer(x+random_range(-5,5),y+random_range(-5,5) + stv_y_offset ,sgf_get_layer_players(),sobj_particle_wood_hit)
	}
			
			
	instance_destroy()
}