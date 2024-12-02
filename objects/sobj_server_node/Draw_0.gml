/// @description Insert description here
// You can write your code in this editor
var stv_all_players = array_length(sla_player_list)
draw_self()
draw_set_color(c_white)
draw_set_alpha(fa_center)
draw_text(40,40, "Connected players: "+string(stv_all_players))





#region draw player connected list

var stv_i = array_length(sla_player_list)
//'repeat' loops the code inside the number of times specified when called
//reducing stv_i is not needed to 'repeat' to be successfully completed
draw_text(80,60,"socket")
repeat(stv_i)
{	
	stv_i--//this is used to run through the list of players
	
	draw_text(80,80+stv_i*20,sla_player_list[stv_i])
	
	//todo ADD PLAYER NAME AND PING TO THIS 
}
	
#endregion