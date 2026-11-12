/atom/movable/screen/wire_priest
	icon = 'modular_zubbers/icons/hud/wirepriest_eye.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/wire_priest/MouseEntered(location,control,params)
	. = ..()
	openToolTip(usr,src,params,title = name,content = desc)

/atom/movable/screen/wire_priest/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/wire_priest/spawn_core
	name = "Deploy core"
	desc = "Places down the wireweed core, and you with it."
	icon_state = "summon"
	screen_loc = "CENTER:0,SOUTH:5"

/atom/movable/screen/wire_priest/spawn_core/Click()
	if(!is_wirepriest_eye(usr))
		return FALSE
	var/mob/eye/wire_priest/priest = usr
	priest.spawn_core_and_priest()
