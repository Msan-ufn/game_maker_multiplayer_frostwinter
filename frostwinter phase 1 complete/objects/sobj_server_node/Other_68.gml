/// @description Insert description here
// You can write your code in this editor
var stv_data_type = async_load[? "type"]


switch (stv_data_type) 
{
    case network_type_connect:
        var stv_player_socket = async_load[? "socket"]
		//this 
		show_message("connecting player at socket: "+string(stv_player_socket))
		array_push(sla_player_list,stv_player_socket)
		//ds_list_add(slv_total_players,stv_player_socket)
	break;
	
	case network_type_disconnect:
        var stv_disconnect_socket = async_load[? "socket"]
		show_message("disconnecting player at socket: "+string(stv_disconnect_socket))
		var stv_array_index_to_delete = array_get_index(sla_player_list,stv_disconnect_socket)
		array_delete(sla_player_list,stv_array_index_to_delete,1)
		//ds_list_delete(slv_total_players,ds_list_find_index(slv_total_players,stv_disconnect_socket))
	break;
	
	case network_type_data:
		//this bulk data manipulation is set on the create event for clarity
		slf_server_data()
	
    default:
        
    break;
}