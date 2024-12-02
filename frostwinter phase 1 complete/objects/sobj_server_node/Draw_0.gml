/// @description Insert description here
// You can write your code in this editor
var stv_all_players = array_length(sla_player_list)

draw_set_color(c_white)
draw_set_alpha(fa_center)
draw_text(room_width/2,room_height/2, "Connected players: "+string(stv_all_players))
