

#region phase 3


function sgf_get_layer_players()
{
	if(!layer_exists("players"))
	{
		layer_create(0,"players")
	}
	return "players"
}


#endregion