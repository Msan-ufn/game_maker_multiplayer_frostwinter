/// @description Insert description here
// You can write your code in this editor
draw_self()

#region phase 2
	draw_set_color(c_white)
	draw_set_alpha(fa_center)
	draw_text(x-40,y-60, "myid: "+string(slv_player_id)+
				"\n 'heat'"+string(slv_player_health_display))

#endregion
