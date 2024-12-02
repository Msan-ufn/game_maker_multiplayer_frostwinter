/// @description Insert description here
// You can write your code in this editor

draw_sprite_pos(sprite_index,image_index, 
					slv_original_bbox_left - slv_image_incline_now , slv_original_bbox_top,  ///top left
					slv_original_bbox_right - slv_image_incline_now, slv_original_bbox_top, //top rightx_left,  
					slv_original_bbox_right , slv_original_bbox_bottom , ///bottom right
					slv_original_bbox_left ,slv_original_bbox_bottom, //bottom left
					1); //alpha
	
	
slv_image_incline_now +=slv_image_incline_strength_now	*slv_image_incline_direction

if(slv_image_incline_now >= slv_image_incline_max)
{
	slv_image_incline_now=slv_image_incline_max
	slv_image_incline_direction *= -1
}
else if (slv_image_incline_now < 0)
{
	slv_image_incline_direction *= -1
}
	


draw_set_color(c_aqua)
draw_set_alpha(fa_center)
	//draw_text(x-40,y-60, "My id is: "+sls_tree_id)
				
