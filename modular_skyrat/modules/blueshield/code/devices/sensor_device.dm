/obj/item/sensor_device/mouse_drop_dragged(atom/over_object, mob/user)
	if(!istype(over_object, /atom/movable/screen))
		return attack_self(user)

/obj/item/sensor_device/blueshield
	name = "blueshield's handheld monitor"
	desc = "A unique model of handheld crew monitor that seems to have been customized for Executive Protection purposes."
	icon = 'modular_skyrat/modules/blueshield/icons/device.dmi'
	icon_state = "blueshield_scanner"

/obj/item/sensor_device/blueshield/attack_self(mob/user)
	GLOB.blueshield_crewmonitor.show(user,src)
