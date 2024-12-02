/// @description Insert description here
// You can write your code in this editor
image_alpha=sgf_get_alpha_devtools()

show_message("trying to connect to ip:"+sgf_get_ip())


//=====
slv_ip = sgf_get_ip()
slv_port = sgf_get_port()

//set timeout to not freeze game if connection fails
network_set_config(network_config_connect_timeout,3000); 

//connection 
slv_client_socket_id =  network_create_socket(network_socket_tcp)

slv_network_connection = network_connect(slv_client_socket_id,slv_ip,slv_port)



//if -1 means creating connection failed
if(slv_network_connection<0)
{
	show_message("cannot connect to server")
	game_restart()
}