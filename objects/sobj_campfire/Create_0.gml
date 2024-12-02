/// @description phase 3 obj
// You can write your code in this editor

image_xscale=0.5
image_yscale=0.5

//sobj_server_campfire_node will control the logic of the campfire
//this sobj_campfire will make requests to the node for updates (ie someone feed the fire)
//

slv_campfire_fuel = -100

///@description run only once , requesting main campfire id and self id(on campfire id list at server)







spf_campfire_add_fuel_server_request = function(stv_fuel_to_add_at_server)
{
	var stv_buffer_add_fuel_at_server = sgf_buffer_creation()
	
	//sgf_buffer_type(stv_buffer_add_fuel_at_server,SGE_NETWORK.CAMPFIRE_ADD_FUEL)
	
	buffer_write(stv_buffer_add_fuel_at_server,buffer_u8, SGE_NETWORK.CAMPFIRE_ADD_FUEL)
	
	
	buffer_write(stv_buffer_add_fuel_at_server,buffer_s16,1000)
	
	var stv_buffer_size = sgf_buffer_get_size(stv_buffer_add_fuel_at_server)
	var stv_server_socket_to_send = sgf_get_socket_server_id_to_send_package()
	network_send_packet(stv_server_socket_to_send,
							stv_buffer_add_fuel_at_server
							,stv_buffer_size)
	
	
	sgf_buffer_deletion(stv_buffer_add_fuel_at_server)
	
}

spf_campfire_fuel_update = function (stv_fuel_update)
{
	self.slv_campfire_fuel  = stv_fuel_update
}
spf_campfire_fuel_update(slv_campfire_fuel)


