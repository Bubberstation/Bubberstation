#define TURRET_ASSEMBLY_START "start"
#define TURRET_ASSEMBLY_RECEIVER "receiver"
#define TURRET_ASSEMBLY_SEC_1 "secured_receiver"
#define TURRET_ASSEMBLY_SERVO "servo"
#define TURRET_ASSEMBLY_SEC_2 "secured_servo"
#define TURRET_ASSEMBLY_SENSOR "sensor"
#define TURRET_ASSEMBLY_SEC_3 "secured_sensor"
#define TURRET_ASSEMBLY_WRAPUP "finished_assembly"

/obj/item/turret_assembly
	name = "turret plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "turret_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one seems to be for a basic outpost defense turret."
	/// modular receiver
	var/obj/item/receiver
	/// proximity sensor
	var/obj/item/sensor
	/// any stockpart servo
	var/obj/item/servo
	/// The turret being produced. Why so elaborate while everything else simple? iunno.
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/design = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	/// step tracking
	var/step = TURRET_ASSEMBLY_START

/obj/item/turret_assembly/examine(mob/user)
	. = ..()
	var/display_text
	switch(step)
		if(TURRET_ASSEMBLY_START)
			display_text = "The turret head is missing a <b>modular receiver</b>..."
		if(TURRET_ASSEMBLY_RECEIVER)
			display_text = "The turret head's connecting bolts are <b>loose</b>..."
		if(TURRET_ASSEMBLY_SEC_1)
			display_text = "It looks like it's missing a <b>servo</b>..."
		if(TURRET_ASSEMBLY_SERVO)
			display_text = "It looks like its main chassis is <b>unsecured</b>..."
		if(TURRET_ASSEMBLY_SEC_2)
			display_text = "It looks like it's missing a <b>proximity sensor</b>..."
		if(TURRET_ASSEMBLY_SENSOR)
			display_text = "The sensor seems <b>unsecured</b>..."
		if(TURRET_ASSEMBLY_SEC_3)
			display_text = "The supports' bolts seem <b>loose</b>..."
		if(TURRET_ASSEMBLY_WRAPUP)
			display_text = "The circuitboard's CPU needs to be <b>activated</b>..."
	. += span_notice(display_text)

/obj/item/turret_assembly/attackby(obj/item/part, mob/user, params)
	. = ..()
	switch(step)
		if(TURRET_ASSEMBLY_START)
			if(!istype(part, /obj/item/weaponcrafting/receiver))
				return
			if(!user.transferItemToLoc(part, src))
				balloon_alert(user, "core stuck to your hand!")
				return
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "receiver inserted")
			receiver = part
			step = TURRET_ASSEMBLY_RECEIVER

		if(TURRET_ASSEMBLY_SEC_1)
			if(istype(part, /obj/item/stock_parts/servo)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "servo stuck to your hand!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "servo added")
				servo = part
				step = TURRET_ASSEMBLY_SERVO

		if(TURRET_ASSEMBLY_SEC_2)
			if(istype(part, /obj/item/assembly/prox_sensor)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "sensor stuck to your hand!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "sensor added")
				sensor = part
				step = TURRET_ASSEMBLY_SENSOR

/obj/item/turret_assembly/multitool_act(mob/living/user, obj/item/tool)
	if(step == TURRET_ASSEMBLY_WRAPUP)
		if(tool.use_tool(src, user, 0, volume=30))
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			var/obj/item/turretling = new design(drop_location())
			qdel(src)
			user.put_in_hands(turretling)
			turretling.balloon_alert(user, "suit finished")

/obj/item/turret_assembly/wrench_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_SEC_3)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "assembly secured")
				step = TURRET_ASSEMBLY_WRAPUP
				return // Last step leads to the next step
		if(TURRET_ASSEMBLY_WRAPUP)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "assembly unsecured")
				step = TURRET_ASSEMBLY_SEC_3
				return

/obj/item/turret_assembly/screwdriver_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "receiver secured")
				step = TURRET_ASSEMBLY_SEC_1
				return //same as wrench
		if(TURRET_ASSEMBLY_SEC_1) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "receiver unsecured")
				step = TURRET_ASSEMBLY_RECEIVER
				return
		if(TURRET_ASSEMBLY_SERVO) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "servo secured")
				step = TURRET_ASSEMBLY_SEC_2
				return
		if(TURRET_ASSEMBLY_SEC_2) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "sensor unsecured")
				step = TURRET_ASSEMBLY_SERVO
				return
		if(TURRET_ASSEMBLY_SENSOR)//Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "sensor secured")
				step = TURRET_ASSEMBLY_SEC_3
				return
		if(TURRET_ASSEMBLY_SEC_3) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "sensor unsecured")
				step = TURRET_ASSEMBLY_SENSOR
				return

/obj/item/turret_assembly/crowbar_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER)
			if(tool.use_tool(src, user, 0, volume=30))
				receiver.forceMove(drop_location())
				balloon_alert(user, "receiver taken out")
				receiver = null
				step = TURRET_ASSEMBLY_START
				return
		if(TURRET_ASSEMBLY_SERVO)
			if(tool.use_tool(src, user, 0, volume=30))
				servo.forceMove(drop_location())
				balloon_alert(user, "servo removed")
				servo = null
				step = TURRET_ASSEMBLY_SEC_1
				return
		if(TURRET_ASSEMBLY_SENSOR)
			if(tool.use_tool(src, user, 0, volume=30))
				sensor.forceMove(drop_location())
				balloon_alert(user, "sensor removed")
				sensor = null
				step = TURRET_ASSEMBLY_SEC_2
				return

/obj/item/turret_assembly/Destroy()
	QDEL_NULL(receiver)
	QDEL_NULL(servo)
	QDEL_NULL(sensor)
	return ..()

/obj/item/turret_assembly/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == receiver)
		receiver = null
	if(gone == servo)
		servo = null
	if(gone == sensor)
		sensor = null

/obj/item/turret_assembly/twin_fang
	name = "twin_fang plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "twinfang_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Twin-Fang\" model of the \"Spider\" turret type."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang

/obj/item/turret_assembly/duster
	name = "duster plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "duster_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Duster\" model of the \"Emergent\" turret type."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/duster

#undef TURRET_ASSEMBLY_START
#undef TURRET_ASSEMBLY_RECEIVER
#undef TURRET_ASSEMBLY_SEC_1
#undef TURRET_ASSEMBLY_SERVO
#undef TURRET_ASSEMBLY_SEC_2
#undef TURRET_ASSEMBLY_SENSOR
#undef TURRET_ASSEMBLY_SEC_3
#undef TURRET_ASSEMBLY_WRAPUP
