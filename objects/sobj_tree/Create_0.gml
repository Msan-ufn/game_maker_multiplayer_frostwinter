/// @description Insert description here
// You can write your code in this editor
slf_set_scale = function (stv_scale_multplier)
{
	self.image_xscale= 1
	self.image_yscale = 1
	
	mask_index = sspr_tree_swap
 
	self.image_xscale = stv_scale_multplier
	self.image_yscale = stv_scale_multplier
	
	slv_original_bbox_left = bbox_left
	slv_original_bbox_right = bbox_right
	slv_original_bbox_top = bbox_top
	slv_original_bbox_bottom = bbox_bottom

	mask_index = sspr_tree
}




slv_image_incline_max = 5
slv_image_incline_now = random(slv_image_incline_max)
slv_image_incline_direction = 1
slv_image_incline_strength_max = 5
slv_image_incline_strength_now = 0.1



slv_my_scale =random_range(1.25,2.10) 
slf_set_scale(slv_my_scale)
/*
slv_original_bbox_left = bbox_left
slv_original_bbox_right = bbox_right
slv_original_bbox_top = bbox_top
slv_original_bbox_bottom = bbox_bottom

mask_index = sspr_tree
*/


slv_tree_hp = 12


sls_tree_id = "-1"


spf_tree_id_initialize = function ()
{ 
	var stv_x_string = string( round (x))
	var stv_y_string = string( round (y))
	self.sls_tree_id = stv_x_string+stv_y_string
	
}


spf_tree_hit = function (stv_id_received,stv_id_hitter)
{
	if(stv_id_received==sls_tree_id)
	{
		if(sobj_client_node.slv_my_player_id==stv_id_hitter)
		{
			//create wood item to ground here
			self.slv_tree_hp--
				
			spf_tree_network_update_send()
		}
		var stv_y_offset = -10
		instance_create_layer(x,y + stv_y_offset ,sgf_get_layer_players(),sobj_particle_wood_hit)
	}	
}



spf_tree_network_update_send= function ()
{
	
		
							
	var stv_buffer_id = buffer_create(32 , buffer_grow , 1)
	
	buffer_seek(stv_buffer_id, buffer_seek_start,0)
	buffer_write(stv_buffer_id,buffer_u8, SGE_NETWORK.ITEMS_TREE_UPDATE)
		
	buffer_write(stv_buffer_id,buffer_string, self.sls_tree_id)
	buffer_write(stv_buffer_id,buffer_s16, self.slv_tree_hp)
	buffer_write(stv_buffer_id,buffer_s16, self.slv_my_scale)
					
	var stv_socket_server_to_send_pack = sgf_get_socket_server_id_to_send_package()
	var stv_buffer_size = sgf_buffer_get_size(stv_buffer_id)
					
	network_send_packet(stv_socket_server_to_send_pack,
						stv_buffer_id,stv_buffer_size)
					
	sgf_buffer_deletion(stv_buffer_id)				
			
	//send package with my id and hp, and scale
	
}

spf_tree_network_update_listen = function (stv_string_id,stv_hp,stv_scale)
{
	if(self.sls_tree_id==stv_string_id)
	{
		slv_tree_hp = stv_hp
		if(stv_scale != self.slv_my_scale)
		{
			//self.slf_set_scale(stv_scale)
		}
	}
}