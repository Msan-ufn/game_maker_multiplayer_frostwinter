/// @description Insert description here
// You can write your code in this editor


if(array_length( sla_player_list) > 0)
{
	slv_is_game_running = true
}
else slv_is_game_running = false




if(slv_is_game_running)
{
	var stv_campfire_nodes = 0
	with(sobj_server_campfire_node)
	{
		stv_campfire_nodes++
	}
	if(stv_campfire_nodes<1)
	{
		instance_create_layer(x,y+40,sgf_get_layer_players(),sobj_server_campfire_node)
	}
	if(stv_campfire_nodes>1)
	{
		show_message("WARNING: TOO MANY CAMPFIRE NODES")
	}
}
else instance_destroy(sobj_server_campfire_node)
		