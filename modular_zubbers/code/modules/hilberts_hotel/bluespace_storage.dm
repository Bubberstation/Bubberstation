/obj/item/storage/box/bluespace
	name = "bluespace box"
	desc = "A box that stores items in a bluespace pocket dimension."
	icon = 'modular_zzplurt/icons/obj/machines/room_controller.dmi'
	icon_state = "box"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	foldable_result = null
	w_class = WEIGHT_CLASS_BULKY
	/// The controller this box was initialized at
	var/datum/weakref/origin_controller
	/// If the controller is currently in a hotel room
	var/in_hotel_room = FALSE
	/// The hotel room area
	var/area/creation_area
	/// If the box was sent to the station (required to ignore area checks)
	var/successfully_sent = FALSE
	/// The name of the person who sent the package to the station
	var/assigned_name = "Unknown"

/obj/item/storage/box/bluespace/proc/return_to_station(name)
	assigned_name = name
	atom_storage.max_slots = 7 // shrinking the box back so it wouldn't get abused
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL * 7

	name = "bluespace box ([assigned_name])"
	desc += span_info("\nThere's a red \"BLUESPACE-REACTIVE. HANDLE WITH CARE.\" sticker on it.")

	resistance_flags = FLAMMABLE // no more plot armour
	successfully_sent = TRUE
	in_hotel_room = FALSE
	update_icon()

/obj/item/storage/box/bluespace/update_icon()
	. = ..()
	cut_overlays()
	if(successfully_sent)
		add_overlay(mutable_appearance(icon, "sticker"))

/obj/item/storage/box/bluespace/attack_self(mob/user)
	if(!successfully_sent)
		return ..()
	else if(length(contents))
		return ..()
	else
		visible_message(span_danger("[src] begins rapidly shrinking!"))
		var/matrix/shrink_back = matrix()
		shrink_back.Scale(0.1,0.1)
		animate(src, 3 SECONDS, transform = shrink_back)
		addtimer(CALLBACK(src, PROC_REF(fancydelete)), 3 SECONDS)

/obj/item/storage/box/bluespace/proc/fancydelete()
	do_harmless_sparks(3, FALSE, src)
	qdel(src)

/obj/item/storage/box/bluespace/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC
	atom_storage.max_total_storage = WEIGHT_CLASS_GIGANTIC * INFINITY
	atom_storage.max_slots = INFINITY
	creation_area = get_area(src)
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/item/storage/box/bluespace/process()
	if(!creation_area)
		return
	if(!in_hotel_room)
		return

	// The INPUT box should NOT exist outside of the hotel room or the storage object
	var/area/current_area = get_area(src)
	if(current_area != creation_area)
		var/obj/machinery/room_controller/controller = origin_controller?.resolve()
		do_harmless_sparks(3, FALSE, src)
		visible_message(span_danger("[src] vanishes in a flash of light!"))
		if(controller)
			forceMove(controller)
			controller.bluespace_box = src
			controller.update_icon()
		else
			qdel(src)
