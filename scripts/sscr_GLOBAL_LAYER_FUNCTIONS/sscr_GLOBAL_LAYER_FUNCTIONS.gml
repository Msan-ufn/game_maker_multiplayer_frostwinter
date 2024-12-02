

#region phase 3

//try 
function sgf_get_layer_players()
{
	var stv_player_layer_name  = "players"
	var stv_player_layer_depth = 0
	if(!layer_exists(stv_player_layer_name))
	{
		layer_create(stv_player_layer_depth , stv_player_layer_name)
	}
	return stv_player_layer_name
}


#region used to get the layer id from the stv_layer_name so it can be used on collision check on the player
function sgf_get_collision_tileset_id()
{
	var stv_layer_name = "stls_layer_tileset_collision_bg"
	var lay_id = layer_get_id(stv_layer_name);
	var stv_tileset_id = layer_tilemap_get_id(lay_id);
	return stv_tileset_id
}
#endregion


#endregion