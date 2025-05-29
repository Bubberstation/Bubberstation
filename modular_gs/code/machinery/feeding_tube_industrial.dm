/**
 * Contains:
 * Industrial Feeding Tube
 */

/obj/structure/disposaloutlet/industrial_feeding_tube
	name = "\improper industrial feeding tube"
	desc = "An imposing machine designed to pump an absurd amount of \"food\" down something's throat. It seems to connect to disposal pipes."
	icon = 'GainStation13/icons/obj/feeding_tube_industrial.dmi'
	icon_state = "base"
	max_integrity = 500 //Durable...
	anchored = FALSE
	/// Is it welded down?
	var/welded = FALSE
	///	Who the tube is attached to
	var/mob/living/attached
	/// Where the tube tries to dump it's stuff into
	var/output_dest
	/// It's Glogged !
	var/clogged = FALSE
	/// Are we currently pumping?
	var/pumping = FALSE
	/// Stuff we're currently trying to pump out
	var/list/pump_stuff = list()
	/// How many items we can push per-pump.
	var/pump_limit = 5


/obj/structure/disposaloutlet/industrial_feeding_tube/Initialize(mapload)
	. = ..()

	update_icon()

	if(anchored) // So it can be mapped in, attached to something.
		trunk = locate() in loc
		if(!trunk)
			return
		trunk.linked = src	// link the pipe trunk to self
		anchored = TRUE
		welded = TRUE //Make it functional

/obj/structure/disposaloutlet/industrial_feeding_tube/examine(mob/user)
	. = ..()
	if(LAZYLEN(pump_stuff))
		switch(LAZYLEN(pump_stuff))
			if(1)
				. += "It seems to have something inside"
			if(2 to 20)
				. += "It seems to have some stuff inside"
			if(21 to 50)
				. += "It seems to be rather full of stuff!"
			if(51 to 200)
				. += "<b>It's walls are bulging out with tons of stuff packed inside!!</b>"
			else
				. += "<span class='danger'>The whole machine is shuddering as it strains to contain hundreds of objects!</span>"
	if(clogged)
		. += "<span class='warning'>It seems to be clogged with stuff!</span>"


/obj/structure/disposaloutlet/industrial_feeding_tube/CheckParts(list/parts_list)
	..()
	pump_limit = 0
	for(var/obj/item/stock_parts/matter_bin/mb in contents)
		if(mb in pump_stuff) //stuff we're going to pump are not being used to build us.
			continue
		pump_limit += mb.rating * 2.5 // ~20 items per pump with 2 bluespace bins

	pump_limit = ceil(pump_limit) //Only whole numbers


/obj/structure/disposaloutlet/industrial_feeding_tube/deconstruct(disassembled)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal(loc, 5)
		new /obj/item/stack/sheet/plastic(loc, 5)
		new /obj/item/pipe/binary(loc, PIPE_STRAIGHT, NORTH)
		new /obj/item/pipe/binary(loc, PIPE_STRAIGHT, NORTH)

	if(contents) //Anything still glogged inside...
		for(var/atom/movable/AM in src)
			AM.forceMove(loc)
	qdel(src)

/obj/structure/disposaloutlet/industrial_feeding_tube/Destroy()
	if(attached)
		attached = null
	if(output_dest)
		output_dest = null

	if(LAZYLEN(contents)) // Just to be safe, lets dump everything out before it's deleted.
		for(var/atom/movable/AM in contents)
			if(istype(AM, /obj/item/stock_parts/matter_bin))
				if(AM in pump_stuff) // Unless it's one of our component parts..
					AM.forceMove(loc)
					continue
				qdel(AM)

	return ..()

/obj/structure/disposaloutlet/industrial_feeding_tube/MouseDrop(mob/living/target)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(!welded)
		to_chat(usr, "<span class='warning'>You need to weld down \the [src] before you can use it.</span>")
		return
	if(attached)
		attached.visible_message("<span class='warning'>\The [src]'s tube is removed from [attached].</span>", "<span class='warning'>The tube is removed from you.")
		detach_tube(FALSE)
		return
	if(!isliving(target))
		return

	if(iscarbon(target)) // iscarbon() so that xenos/wendigos(?) can do feeding stuff maybe. Maybe.
		var/mob/living/carbon/feedee = target

		if(HAS_TRAIT(feedee, TRAIT_TRASHCAN) || (feedee.vore_flags & FEEDING))
			var/food_dump = input(usr, "Where do you shove the tube? (cancel to just feed normally)", "Select belly") as null|anything in feedee.vore_organs
			if(food_dump && isbelly(food_dump))
				// Best to be safe with this thing. Since you can eat pretty much anythign with it...
				// Including People, Intentionally or otherwise.
				if(usr != feedee) // If someone is feeding themself, skip the prefcheck.
					var/feedeePrefCheck = alert(feedee, "[usr] is attempting to shove \the [src]'s tube into your [food_dump]! Do you want this?", "THE TUBE", "Yes!!", "No!")
					if(feedeePrefCheck != "Yes!!")
						to_chat(usr, "[feedee] doesnt want to be fed by \the [src]...")
						return

				attach_tube(feedee, food_dump) // Attach in Vore Mode
				return

		//Either we arn't attaching to vorebelly, or we arnt able to. Let's try to feed them normally!
		if(usr != feedee)
			var/feedeePrefCheck = alert(feedee, "[usr] is attempting to shove \the [src]'s tube into your mouth! Do you want this?", "THE TUBE", "Yes!!", "No!")
			if(feedeePrefCheck != "Yes!!")
				to_chat(usr, "[feedee] doesnt want to be fed by \the [src]...")
				return

		attach_tube(feedee) // Attach normally
		return

/// Attaches the tube to the target. dest defaults to the target, if dest isnt defined
/obj/structure/disposaloutlet/industrial_feeding_tube/proc/attach_tube(var/mob/living/target, var/dest = null, var/loud = TRUE)
	if(!target)
		return FALSE
	if(dest)
		output_dest = dest
	else
		output_dest = target
	attached = target

	if(loud)
		if(isbelly(output_dest))
			target.visible_message("\The [src]'s tube is shoved into [attached]!", "The tube is shoved directly into your [output_dest]!")
		else
			target.visible_message("\The [src]'s tube is shoved into [attached]!", "The tube is shoved directly into you!")

	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(check_target_dist))
	update_icon()
	face_atom(target)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/detach_tube(var/loud = TRUE)
	UnregisterSignal(attached, COMSIG_MOVABLE_MOVED)
	if(loud)
		attached.visible_message("<span class='warning'>[attached] is detached from [src].</span>")
	attached = null
	output_dest = null
	update_icon()


/obj/structure/disposaloutlet/industrial_feeding_tube/proc/check_target_dist()
	if(!attached) //oh no
		UnregisterSignal()

	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		attached.visible_message("<span class='danger'The feeding tube is yanked out of [attached]!</span>","<span class='userdanger'>The feeding hose is yanked out of you!</span>")
		detach_tube(FALSE)
		return

	face_atom(attached)

/obj/structure/disposaloutlet/industrial_feeding_tube/update_overlays()
	// A lot of this is temp. More likely than not you shouldnt see this comment as it'll be properly updated when reo PRs this.
	// Or it wont because epic fail :333
	. = ..()
	cut_overlays()

	var/mutable_appearance/tube_overlay = mutable_appearance('GainStation13/icons/obj/feeding_tube_industrial.dmi', "tube_idle")

	if(pumping)
		tube_overlay.icon_state = "tube-pump"
	else
		if(attached)
			tube_overlay.icon_state = "tube-active"
		else
			tube_overlay.icon_state = "tube-idle"

	if(welded) //if we're not welded, dont show our light on.
		add_overlay("light-[clogged ? "r" : "g"]")

	add_overlay(tube_overlay)


// expel the contents of the holder object, then delete it
// called when the holder exits the outlet
/obj/structure/disposaloutlet/industrial_feeding_tube/expel(obj/structure/disposalholder/H)
	if(H.hasmob) //Uh oh-
		playsound(src, "clang", 100)
		visible_message("<span class='danger'>\The [src] loudly clunks as something large enters it's intake!</span>")
	H.active = FALSE
	H.vent_gas(get_turf(src))
	if(clogged)
		clog(H.contents)
	else
		var/start_pumping = FALSE
		for(var/atom/movable/AM in H.contents)
			pump_stuff += AM // Get ready to pump!
			AM.forceMove(src)
			if(!pumping) //Lets start a new pump cycle if we arnt pumping. Otherwise, it'll just be added to the queue.
				start_pumping = TRUE
				pumping = TRUE
		if(start_pumping)
			pump()
	qdel(H)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/pump(repeat = TRUE, unlimited = FALSE)
	if(clogged)
		return
	var/list/this_pump = list() //What we're going to pump this cycle
	var/item_count = 0
	for(var/atom/movable/AM in pump_stuff)
		this_pump += AM // Add to the stuff we're currently pumping
		item_count++
		if(item_count > pump_limit && !unlimited) //We're pumping as much as our parts allow!
			break
	if(!pumping)
		pumping = TRUE
		playsound(src, 'GainStation13/sound/rakshasa/Corrosion3.ogg', 50, 1)
		update_icon()
		spawn(8)
			pumping = FALSE
			update_icon()
	spawn(9) //Wait for the animation to finish


		if(!output_dest || !attached) //We either arnt, or got disconnected by time stuff was about to splort out!
			spew(this_pump, TRUE)
			if(LAZYLEN(pump_stuff) && repeat)
				pump()
			return

		var/fed_something = FALSE
		// Feed Normally
		if(isliving(output_dest))
			var/list/not_food = list()
			for(var/atom/movable/AM in this_pump)
				if(istype(AM, /obj/item/reagent_containers/food/snacks))
					var/obj/item/reagent_containers/food/snacks/food = AM
					var/datum/reagents/food_reagents = food.reagents
					if(food_reagents.total_volume)
						var/food_size = food_reagents.total_volume //We're cramming the Whole Thing down your throat~

						SEND_SIGNAL(food, COMSIG_FOOD_EATEN, attached)

						// Check to see if the person is wearing a bluespace collar
						var/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/K = 0
						if(istype(attached, /mob/living/carbon/human))
							var/mob/living/carbon/human/human_eater = attached
							K = human_eater.wear_neck
						if (!(istype(K, /obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter) && K.transpose_industrial_feeding(food, food_reagents, attached))) //If wearing a BS collar, use BS proc. If not, continue as normal
							food_reagents.reaction(attached, INGEST, food_size)
							food_reagents.trans_to(attached, food_size)
							if(istype(attached, /mob/living/carbon/human))
								var/mob/living/carbon/human/human_eater = attached
								human_eater.fullness += food_size //Added industrial feeding tube's causing fullness (But ignores limits~)
							food.checkLiked(food_size, attached) //...Hopefully you like the taste.


					if(food.trash) //Lets make the trash the food's supposed to make, if it has any
						var/obj/item/trash = food.generate_trash(src)
						if(not_food)
							not_food += trash // If it's already going to get clogged, clog it more with the trash
						else
							trash.forceMove(get_turf(src)) // Otherwise move it to the tile. For convinience

					fed_something = TRUE
					pump_stuff -= food
					qdel(food) //Gulp...
					continue
				else
					not_food += AM // That's not (traditionally) edible!

			if(LAZYLEN(not_food))
				clog(not_food) // Now you've gone and clogged us...

		// Feed Voraciously
		if(isbelly(output_dest))
			var/list/inedible //Some things shouldnt be eaten...
			for(var/atom/movable/AM in this_pump)
				pump_stuff -= AM // We're putting this in. Remove it from the list.
				if(isitem(AM))
					var/obj/item/I = AM
					if(is_type_in_list(I, item_vore_blacklist))
						inedible += I
						continue

				if(isliving(AM))
					var/mob/living/cutie = AM
					if(!(cutie.vore_flags & DEVOURABLE)) //Do not eat this QT...
						inedible += cutie
						continue


				fed_something = TRUE
				AM.forceMove(output_dest)
			if(inedible)
				clog(inedible)

		// After everything, if we've pushed something, play the "rubber tube noise"
		// It's technically an evil digestion sound from a snowflake shadekin, but it makes for a good tube sound. Thanks Verkie!
		if(fed_something)
			playsound(attached.loc, 'GainStation13/sound/rakshasa/Corrosion3.ogg', rand(50,70), 1)

		if(LAZYLEN(pump_stuff) && repeat)
			pump()
		else
			pumping = FALSE
			update_icon()

/obj/structure/disposaloutlet/industrial_feeding_tube/expel_holder(obj/structure/disposalholder/H, playsound=FALSE)
	if(playsound)
		playsound(src, 'sound/machines/hiss.ogg', 25, 0, 0)

	if(!H)
		return

	spew(H.contents)

	H.vent_gas(get_turf(src))
	qdel(H)

/obj/structure/disposaloutlet/industrial_feeding_tube/attack_hand(mob/user)
	. = ..()
	if(attached)
		detach_tube()
		return

/obj/structure/disposaloutlet/industrial_feeding_tube/attackby(obj/item/I, mob/living/user, params)
	if(user.a_intent != INTENT_HELP)
		return ..()
	switch(I.tool_behaviour)
		if(TOOL_WRENCH)
			if(welded)
				to_chat(user, "<span class='warning'>\The [src] is firmly welded to the floor. Cut the floorwelds before trying to unwrench it!</span>")
				return TRUE
			var/turf/T = get_turf(src)
			if(T.intact && isfloorturf(T))
				to_chat(user, "<span class='warning'>You need to remove the floor tiles before [anchored ? "detaching" : "attaching"] \the [src]!</span>")
				return TRUE
			if(anchored)
				I.play_tool_sound(src, 100)

				anchored = FALSE
				trunk.linked = null
				trunk = null
				attached = null
				output_dest = null

				user.visible_message("<span class='notice'>[user] detaches \the [src] from the floor!</span>")
				return TRUE
			else
				var/found_trunk = FALSE
				for(var/obj/structure/disposalpipe/P in T)
					if(istype(P, /obj/structure/disposalpipe/trunk))
						var/obj/structure/disposalpipe/trunk/newtrunk = P
						if(newtrunk.linked) //Trunk is already linked to something
							continue
						found_trunk = TRUE
						trunk = newtrunk
						break
				if(!found_trunk)
					to_chat(user, "<span class='warning'>\The [src] requires a trunk underneath it in order to work!</span>")
					return

				to_chat(user, "<span class='notice'>You attach \the [src] to the trunk.</span>")
				anchored = TRUE

			I.play_tool_sound(src, 100)
			update_icon()
			return

	. = ..()

/obj/structure/disposaloutlet/industrial_feeding_tube/crowbar_act(mob/living/user, obj/item/I)
	if(!clogged)
		to_chat(user, "<span class='notice'>\The [src] doesnt seem to be clogged at the moment...")
		return TRUE
	user.visible_message("<span class='italics'>[user] starts to pry open the maintenance hatch of \the [src], attempting to unclog it...</span>")
	I.play_tool_sound(src, 100)
	if(I.use_tool(src, user, 30))
		user.visible_message("<span class='notice'>[user] pries open the maintenance hatch on \the [src], unclogging it!</span>")
		unclog()
	return TRUE


// Plungers are a thing now, why not give them the ability to unclog?
/obj/structure/disposaloutlet/industrial_feeding_tube/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	if(!clogged)
		to_chat(user, "<span class='notice'>\The [src] doesnt seem to be clogged at the moment...")
		return TRUE
	user.visible_message("<span class='italics'>[user] starts to furiously plunge the tube of \the [src], attempting to unclog it...</span>")
	//I.play_tool_sound(src, 100) I dont think plungers have a use sound...
	if(P.use_tool(src, user, 20)) //Plungers are slightly shorter because funny niche use
		user.visible_message("<span class='notice'>[user] pries open the maintenance hatch on \the [src], unclogging it!</span>")
		unclog()
	return

/obj/structure/disposaloutlet/industrial_feeding_tube/welder_act(mob/living/user, obj/item/I)
	if(!I.tool_start_check(user, amount=0))
		return
	if(anchored)
		//var/turf/T = get_turf(src)
		if(!welded)
			if(!trunk) // If we're attaching it, we need to check for the pipe we're attaching to
				to_chat(user, "<span class='danger'>\The [src] needs to be welded to a trunk.</span>")
				return TRUE
			to_chat(user, "<span class='notice'>You start welding \the [src] in place...</span>")
		else
			if(clogged) // There's junk inside!
				to_chat(user, "<span class='warning'>There's junk inside \the [src]! Clean it out before trying to remove it!</span>")
				return TRUE
			//Already welded, lets cut it free
			to_chat(user, "<span class='notice'>You start slicing the floorweld off \the [src]...</span>")

		playsound(src, 'sound/items/welder2.ogg', 100, 1)
		if(I.use_tool(src, user, 20))
			update_icon()
			playsound(src, 'sound/items/welder.ogg', 100, 1)
			if(welded)
				to_chat(user, "<span class='notice'>You slice the floorweld off [src].</span>")
				welded = FALSE
				trunk.linked = null
				return TRUE
			else
				to_chat(user, "<span class='notice'>You weld \the [src] to the floor.</span>")
				welded = TRUE
				trunk.linked = src
				return TRUE


	else
		playsound(src, 'sound/items/welder2.ogg', 100, 1)
		to_chat(user, "<span class='notice'>You begin deconstructing \the [src]</span>")
		if(I.use_tool(src, user, 30))
			playsound(src, 'sound/items/welder.ogg', 100, 1)
			deconstruct(TRUE)
	return TRUE

// Someone got stuck inside after it got clogged!
// Lets let them force their way out
/obj/structure/disposaloutlet/industrial_feeding_tube/container_resist(mob/living/user)
	if(user.stat || !clogged) //If it's not clogged, they'll be ejected soon... One way or another.
		return
	playsound(src, 'sound/effects/clang.ogg', 50)
	visible_message("\The [src] loudly clongs as something inside tries to break free!")
	if(do_after(user, 100))
		unclog()

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/clog(list/clog_junk, loud = TRUE)
	clogged = TRUE
	for(var/atom/movable/AM in clog_junk)
		if(!(AM in pump_stuff))
			pump_stuff += AM
		AM.forceMove(src)


	update_icon()
	if(loud)
		playsound(src, 'sound/machines/warning-buzzer.ogg', 50, 1)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/unclog()

	spew(pump_stuff)

	clogged = FALSE
	update_icon()

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/spew(var/list/spew_stuff, playsound = FALSE)
	var/turf/T = get_turf(src)

	if(playsound)
		playsound(src, 'sound/machines/hiss.ogg', 50, 0, 0)
	for(var/atom/movable/AM in spew_stuff)
		if(AM in pump_stuff)
			pump_stuff -= AM
		target = get_offset_target_turf(loc, rand(2)-rand(2), rand(2)-rand(2))

		AM.forceMove(T)
		AM.pipe_eject(dir)
		AM.throw_at(target, eject_range, 1)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/face_atom(atom/A) //Literally stolen from /mob. Sue me.
	if(!A || !x || !y || !A.x || !A.y )
		return
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) // Wall items are graphically shifted but on the floor
		if(A.pixel_y > 16)
			setDir(NORTH)
		else if(A.pixel_y < -16)
			setDir(SOUTH)
		else if(A.pixel_x > 16)
			setDir(EAST)
		else if(A.pixel_x < -16)
			setDir(WEST)
		return

	if(abs(dx) < abs(dy))
		if(dy > 0)
			setDir(NORTH)
		else
			setDir(SOUTH)
	else
		if(dx > 0)
			setDir(EAST)
		else
			setDir(WEST)
