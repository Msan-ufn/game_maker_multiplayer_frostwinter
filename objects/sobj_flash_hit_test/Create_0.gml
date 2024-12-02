/// @description Insert description here
// You can write your code in this editor

slv_ttl = 10


slf_step_update = function ()
{
	self.slv_ttl--
	if(slv_ttl<0)
	{
		instance_destroy()
	}
}