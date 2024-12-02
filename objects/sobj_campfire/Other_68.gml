/// @description Insert description here
// You can write your code in this editor

var stv_buffer_package_recived = async_load[? "buffer"]

buffer_seek(stv_buffer_package_recived,buffer_seek_start,0)

var stv_PACKET_KIND_ID = buffer_read(stv_buffer_package_recived,buffer_u8)


switch (stv_PACKET_KIND_ID) 
{
    case SGE_NETWORK.CAMPFIRE_UPDATE:
		var stv_campfire_fuel_broadcasted = buffer_read(stv_buffer_package_recived,buffer_s16)
        slv_campfire_fuel = stv_campfire_fuel_broadcasted
    break;
    default:
        // code here
    break;
}

