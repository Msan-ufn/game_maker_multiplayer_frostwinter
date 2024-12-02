/// @description Insert description here
// You can write your code in this editor
image_alpha=sgf_get_alpha_devtools() 


slv_port = sgf_get_port()
slv_max_players = sgf_get_max_players()


slv_server_id = network_create_server(network_socket_tcp,slv_port,slv_max_players)

sla_player_list= array_create(0)

//if server id = -1 failed to create server
if(slv_server_id<0)
{
	show_message("error creating server, another server is probably running already")
	game_restart()
}



//main server data manipulation 


slf_server_data = function ()
{
	
}
