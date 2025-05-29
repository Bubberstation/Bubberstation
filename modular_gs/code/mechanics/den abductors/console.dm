/obj/machinery/abductor/feeder_console
	name = "feeder console"
	desc = "You were into feeding enough that you managed to reverse-engineer alien technology to suit your goals, Amazing."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "console"
	density = TRUE
	team_number = 27 // 6(F) + 1(A) + 20(T) :3
	/// What pad is linked with the console?
	var/obj/machinery/abductor/pad/pad
	/// What camera console is linked with the console?
	var/obj/machinery/computer/camera_advanced/abductor/camera
	/// What abductor gizmo is linked with the console?
	var/obj/item/abductor/gizmo/gizmo
	/// The current scale linked with the console
	var/obj/structure/scale/credits/linked_scale
	/// How much of each goodie have we purchased?
	var/list/buy_counts = list()

/obj/machinery/abductor/feeder_console/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.set_machine(src)
	var/dat = ""
	dat += "<H3> FeederSoft 3000 </H3>"

	var/credits = linked_scale?.credits
	dat += "Gear Credits: [credits] <br>"
	dat += "<b>Transfer credits in exchange for supplies:</b><br>"
	for(var/goodie in subtypesof(/datum/feeders_den_goodie))
		var/datum/feeders_den_goodie/temp_goodie = new goodie()
		dat += "<a href='?src=[REF(src)];dispense=[goodie]'>[temp_goodie.name] (Cost: [temp_goodie.credit_cost])</A><br>"
		qdel(temp_goodie)

	if(pad)
		dat += "<span class='bad'>Emergency Teleporter System.</span>"
		dat += "<span class='bad'>Consider using primary observation console first.</span>"
		dat += "<a href='?src=[REF(src)];teleporter_send=1'>Activate Teleporter</A><br>"
		if(gizmo && gizmo.marked)
			dat += "<a href='?src=[REF(src)];teleporter_retrieve=1'>Retrieve Mark</A><br>"
		else
			dat += "<span class='linkOff'>Retrieve Mark</span><br>"
	else
		dat += "<span class='bad'>NO TELEPAD DETECTED</span></br>"

	var/datum/browser/popup = new(user, "computer", "Abductor Console", 400, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/abductor/feeder_console/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	if(href_list["teleporter_send"])
		TeleporterSend()
	if(href_list["dispense"])
		var/datum_path = href_list["dispense"]
		var/datum/feeders_den_goodie/goodie_datum = new datum_path()
		var/price = goodie_datum.credit_cost
		var/item_path = goodie_datum.item_to_dispense

		if(!isnull(goodie_datum.initial_stock) && buy_counts[goodie_datum.name] && (buy_counts[goodie_datum.name] >= goodie_datum.initial_stock))
			say("Unable to purchase more!")
			return FALSE

		if(!Dispense(item_path, price))
			return FALSE

		if(buy_counts[goodie_datum.name] == null)
			buy_counts[goodie_datum.name] = 0

		buy_counts[goodie_datum.name] += 1
		qdel(goodie_datum)

	updateUsrDialog()

/obj/machinery/abductor/feeder_console/proc/TeleporterRetrieve()
	if(pad && gizmo && gizmo.marked)
		pad.Retrieve(gizmo.marked)

/obj/machinery/abductor/feeder_console/proc/TeleporterSend()
	if(pad)
		pad.Send()

/obj/machinery/abductor/feeder_console/proc/SetDroppoint(turf/open/location,user)
	if(!istype(location))
		to_chat(user, "<span class='warning'>That place is not safe for the specimen.</span>")
		return

	if(pad)
		pad.teleport_target = location
		to_chat(user, "<span class='notice'>Location marked as test subject release point.</span>")

/obj/machinery/abductor/feeder_console/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/abductor/feeder_console/LateInitialize()
	if(!team_number)
		return

	for(var/obj/machinery/abductor/pad/found_pad in GLOB.machines)
		if(found_pad.team_number == team_number)
			pad = found_pad
			break

	for(var/obj/machinery/computer/camera_advanced/abductor/found_console in GLOB.machines)
		if(found_console.team_number == team_number)
			camera = found_console
			found_console.console = src

/obj/machinery/abductor/feeder_console/proc/AddGizmo(obj/item/abductor/gizmo/G)
	if(G == gizmo && G.console == src)
		return FALSE

	if(G.console)
		G.console.gizmo = null

	gizmo = G
	G.console = src
	return TRUE

/obj/machinery/abductor/feeder_console/proc/Dispense(obj/item/new_item, cost = 1)
	if(!ispath(new_item))
		return FALSE

	if(!linked_scale?.credits || linked_scale.credits < cost)
		say("Insufficent credits!")
		return FALSE

	linked_scale.credits -= cost
	say("Incoming supply!")
	var/drop_location = loc

	if(pad)
		flick("alien-pad", pad)
		drop_location = pad.loc

	new new_item(drop_location)
	return TRUE

/obj/machinery/abductor/feeder_console/attackby(obj/item/used_tool, mob/user, params)
	if(istype(used_tool, /obj/item/abductor/gizmo) && AddGizmo(used_tool))
		to_chat(user, "<span class='notice'>You link the tool to the console.</span>")
		return TRUE

	return ..()

/obj/structure/scale/credits
	name = "tracking scale"
	desc = "A upgraded scale that tracks to weight of all of those that have stepped on it. Using this will add credits to the feeder console"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = NODECONSTRUCT_1
	/// How much credits do we currently have?
	var/credits = 0
	/// How many credits are we going to reward per pound gained?
	var/credits_per_fatness = 0.25
	/// A list containing all of the people we've scanned and their maximum weight.
	var/list/scanned_people = list()
	/// What is the current team number?
	var/team_number = 27
	/// What is the maximum ammount of credits that can be gained per person?
	var/maximum_credits = 1000 // A little bit over the fattness for blob.

/obj/structure/scale/credits/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/scale/credits/attackby(obj/item/used_tool, mob/user, params)
	if(!used_tool.tool_behaviour == TOOL_WRENCH)
		return ..()

	anchored = !anchored
	to_chat(user, "<span class='notice'>You [anchored ? "secure" : "unsecure"] \the [src].</span>")
	used_tool.play_tool_sound(src)
	return TRUE

/obj/structure/scale/credits/LateInitialize()
	for(var/obj/machinery/abductor/feeder_console/found_console in GLOB.machines)
		if(found_console.team_number != team_number)
			continue

		found_console.linked_scale = src

/obj/structure/scale/credits/weighperson(mob/living/carbon/human/fatty)
	. = ..()
	if(!istype(fatty))
		return FALSE

	var/credits_to_add = min((fatty.fatness * credits_per_fatness), maximum_credits)
	var/credits_to_remove = 0
	if(scanned_people[fatty])
		if(scanned_people[fatty] >= maximum_credits)
			return TRUE

		credits_to_remove = scanned_people[fatty]
	else
		scanned_people[fatty] = 0

	var/credit_total = max((credits_to_add - credits_to_remove), 0)
	if(credit_total > 0)
		say("[credit_total] credits have been deposited into the console.")

	credits += credit_total
	scanned_people[fatty] += credit_total

	return TRUE

/obj/machinery/abductor/pad/feeder
	team_number = 27

/obj/machinery/computer/camera_advanced/abductor/feeder
	team_number = 27
	vest_mode_action = null
	vest_disguise_action = null
	check_if_abductor = FALSE

/obj/machinery/computer/camera_advanced/abductor/feeder/IsScientist(mob/living/carbon/human/H)
	return TRUE

/obj/item/abductor/gizmo/feeder
	mode = GIZMO_MARK

/obj/item/abductor/gizmo/feeder/ScientistCheck(mob/user)
	return TRUE

/obj/item/abductor/gizmo/attack_self(mob/user)
	return

/obj/item/abductor/gizmo/feeder/mark(atom/target, mob/living/user)
	if(!ishuman(target))
		return FALSE

	if(target == marked)
		to_chat(user, "<span class='notice'>You begin to teleport [target]...</span>")
		if(!do_after(user, 45 SECONDS, target = target)) // You have to be standing still for a while
			return FALSE

		console?.pad.Retrieve(marked)
		return TRUE

	if(target == user)
		marked = user
		return TRUE

	prepare(target,user)
	return TRUE

