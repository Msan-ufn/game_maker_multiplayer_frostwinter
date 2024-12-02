/// @description Insert description here
// You can write your code in this editor



slf_step_update = function ()
{
	image_alpha -=0.001
	
	if(image_alpha<=0)
	{
		instance_destroy()
	}
}