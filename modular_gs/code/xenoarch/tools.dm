/obj/item/xenoarch
	name = "Parent Xenoarch"
	desc = "Debug. Parent Clean"
	icon = 'GainStation13/code/xenoarch/tools.dmi'

/obj/item/xenoarch/Initialize()
	..()

/obj/item/xenoarch/clean/hammer
	name = "Parent hammer"
	desc = "Debug. Parent Hammer."
	var/cleandepth = 15
	var/cleanspeed = 15
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')

/obj/item/xenoarch/clean/hammer/cm1
	name = "mining hammer cm1"
	desc = "removes 1cm of material."
	icon_state = "pick1"
	cleandepth = 1
	cleanspeed = 5

/obj/item/xenoarch/clean/hammer/cm2
	name = "mining hammer cm2"
	desc = "removes 2cm of material."
	icon_state = "pick2"
	cleandepth = 2
	cleanspeed = 10

/obj/item/xenoarch/clean/hammer/cm3
	name = "mining hammer cm3"
	desc = "removes 3cm of material."
	icon_state = "pick3"
	cleandepth = 3
	cleanspeed = 15

/obj/item/xenoarch/clean/hammer/cm4
	name = "mining hammer cm4"
	desc = "removes 4cm of material."
	icon_state = "pick4"
	cleandepth = 4
	cleanspeed = 20

/obj/item/xenoarch/clean/hammer/cm5
	name = "mining hammer cm5"
	desc = "removes 5cm of material."
	icon_state = "pick5"
	cleandepth = 5
	cleanspeed = 25

/obj/item/xenoarch/clean/hammer/cm6
	name = "mining hammer cm6"
	desc = "removes 6cm of material."
	icon_state = "pick6"
	cleandepth = 6
	cleanspeed = 30

/obj/item/xenoarch/clean/hammer/cm15
	name = "mining hammer cm15"
	desc = "removes 15cm of material."
	icon_state = "pick_hand"
	cleandepth = 15
	cleanspeed = 75

/obj/item/xenoarch/clean/hammer/advanced
	name = "advanced hammer"
	desc = "Removes a custom amount of debris."
	icon_state = "advpick"
	cleandepth = 30
	cleanspeed = 30
	usesound = 'sound/weapons/drill.ogg'

/obj/item/xenoarch/clean/hammer/advanced/attack_self(mob/living/carbon/user)
	var/depthchoice = input(user, "What depth would you like to mine with? (1-30)", "Change Dig Depth") as null|num
	if(depthchoice && (depthchoice > 0 && depthchoice <= 30))
		cleandepth = depthchoice
		cleanspeed = depthchoice
		desc = "Removes a custom amount of debris. It will dig [cleandepth] centimeters."
		to_chat(user, "<span class='notice'>You set the dig depth of the hammer to [cleandepth] centimeters.</span>")
//

/obj/item/xenoarch/clean/brush
	name = "mining brush"
	desc = "cleans off the remaining debris."
	icon_state = "pick_brush"
	var/brushspeed = 100
	usesound = 'sound/items/towelwipe.ogg'

/obj/item/xenoarch/clean/brush/basic
	brushspeed = 50

/obj/item/xenoarch/clean/brush/adv
	name = "advanced mining brush"
	icon_state = "advbrush"
	brushspeed = 10

//

/obj/item/xenoarch/help/scanner
	name = "mining scanner"
	desc = "Inaccurately scans a rock's depths."
	icon_state = "scanner"
	usesound = 'sound/machines/chime.ogg'

/obj/item/xenoarch/help/scanneradv
	name = "advanced mining scanner"
	desc = "Accurately scans a rock's depths."
	icon_state = "adv_scanner"
	usesound = 'sound/machines/chime.ogg'

/obj/item/xenoarch/help/measuring
	name = "measuring tape"
	desc = "Measures how far a rock has been dug into."
	icon_state = "measuring"
	usesound = 'sound/items/poster_ripped.ogg'

/obj/item/xenoarch/help/research
	name = "research analyzer"
	desc = "Deconstructs artifacts for research."
	icon_state = "researchscanner"
	usesound = 'sound/weapons/resonator_blast.ogg'

/obj/item/xenoarch/help/plant
	name = "fossil seed extractor"
	desc = "Takes flora fossils and extracts the prehistoric seeds."
	icon_state = "plantscanner"
	usesound = 'sound/weapons/resonator_blast.ogg'

// Eventually, make it work on afterattack(atom/target, mob/user , proximity)
// I dont want to take more time currently though.
// Would have to create a list and then check if the item is in the list.

/obj/item/xenoarch/help/cargo
	name = "dimensional cargo scanner"
	desc = "teleports items to be sold."
	icon_state = "cargoscanner"
	usesound = 'sound/weapons/resonator_blast.ogg'

/obj/item/xenoarch/help/cargo/afterattack(atom/target, mob/user , proximity)
	if(!proximity)
		return
	var/export_categories = EXPORT_CARGO
	if(!istype(target,/obj/item))
		return
	var/datum/export_report/ex = new
	if(!do_after(user,300,target=target))
		to_chat(user,"You need to stand still to export items.")
		return
	export_item_and_contents(target, export_categories , dry_run = FALSE, external_report = ex)
	for(var/datum/export/E in ex.total_amount)
		var/export_text = E.total_printout(ex)
		if(!export_text)
			continue

		var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(D)
			D.adjust_money(ex.total_value[E])

	to_chat(user,"You sell the [target].")



// Storage: Belt and Locker and Bag

/obj/item/storage/bag/strangerock
	name = "strange rock bag"
	desc = "A bag for strange rocks."
	icon = 'GainStation13/code/xenoarch/tools.dmi'
	icon_state = "rockbag"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/mob/listeningTo
	var/range = null

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/obj/item/storage/bag/strangerock/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.allow_quick_empty = TRUE
	STR.max_combined_w_class = 200
	STR.max_items = 10
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/strangerock))


/obj/item/storage/bag/strangerock/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/Pickup_rocks)
	listeningTo = user

/obj/item/storage/bag/strangerock/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/strangerock/proc/Pickup_rocks(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message("<span class='notice'>[user] scoops up the rocks beneath [user.p_them()].</span>", \
			"<span class='notice'>You scoop up the rocks beneath you with your [name].</span>")
	spam_protection = FALSE

/obj/item/storage/bag/strangerockadv
	name = "bluespace strange rock bag"
	desc = "A bag for strange rocks."
	icon = 'GainStation13/code/xenoarch/tools.dmi'
	icon_state = "rockbagadv"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/mob/listeningTo
	var/range = null

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/obj/item/storage/bag/strangerockadv/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.allow_quick_empty = TRUE
	STR.max_combined_w_class = 1000
	STR.max_items = 50
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/strangerock))

/obj/item/storage/bag/strangerockadv/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/Pickup_rocks)
	listeningTo = user

/obj/item/storage/bag/strangerockadv/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/strangerockadv/proc/Pickup_rocks(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message("<span class='notice'>[user] scoops up the rocks beneath [user.p_them()].</span>", \
			"<span class='notice'>You scoop up the rocks beneath you with your [name].</span>")
	spam_protection = FALSE

//

/obj/item/storage/belt/xenoarch
	name = "xenoarchaeologist belt"
	desc = "used to store your tools for xenoarchaeology."
	icon = 'GainStation13/code/xenoarch/tools.dmi'
	icon_state = "miningbelt"

/obj/item/storage/belt/xenoarch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/xenoarch/help,
		/obj/item/xenoarch/clean,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/gps
		))
	STR.can_hold = can_hold
	STR.max_items = 12
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 200

/obj/item/storage/belt/xenoarch/full/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/help/scanner(src)
	new /obj/item/xenoarch/clean/brush/basic(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/gps(src)
	return

/obj/structure/closet/wardrobe/xenoarch
	name = "xenoarchaeologist wardrobe"
	icon_state = "science"
	icon_door = "science"

/obj/structure/closet/wardrobe/xenoarch/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/help/scanner(src)
	new /obj/item/xenoarch/clean/brush/basic(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/pickaxe(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/gps(src)
	new /obj/item/storage/belt/xenoarch(src)
	new /obj/item/storage/bag/strangerock(src)
	return

//

//Research WEB

/datum/techweb_node/xenoarchtools
	id = "xenoarchtools"
	display_name = "Xenoarchaeology Tools"
	description = "Xenoarchaeology tools that are used for xenoarchaeology, who knew."
	prereq_ids = list("base")
	design_ids = list("hammercm1","hammercm2","hammercm3","hammercm4","hammercm5","hammercm6","hammercm15","hammerbrush","xenoscanner","xenomeasure","xenobelt","xenorockback")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 750)

/datum/techweb_node/portxenoarch
	id = "portxenoarch"
	display_name = "Portable Xenoarchaeology Tools"
	description = "Tools for extracting seeds, and for getting some research points."
	prereq_ids = list("xenoarchtools")
	design_ids = list("xenoresearch","xenoplant")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

/datum/techweb_node/advportcargo
	id = "advportcargo"
	display_name = "Advanced Cargo Technology"
	description = "A tool for selling stuff not through a shuttle. Careful with its use."
	prereq_ids = list("portxenoarch")
	design_ids = list("advcargoscanner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/advxenoarch
	id = "advxenoarch"
	display_name = "Advanced Xenoarchaeology Tools"
	description = "Tools that can make your excavation and recovering of artifacts easier."
	prereq_ids = list("xenoarchtools")
	design_ids = list("advxenoscanner","hammercmadv","hammerbrushadv","xenorockbackadv")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

//Research DESIGNS

/datum/design/hammercm1
	name = "Hammer cm1"
	desc = "A hammer that destroys 1 cm of debris."
	id = "hammercm1"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm1
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm2
	name = "Hammer cm2"
	desc = "A hammer that destroys 2 cm of debris."
	id = "hammercm2"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm2
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm3
	name = "Hammer cm3"
	desc = "A hammer that destroys 3 cm of debris."
	id = "hammercm3"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm3
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm4
	name = "Hammer cm4"
	desc = "A hammer that destroys 4 cm of debris."
	id = "hammercm4"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm4
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm5
	name = "Hammer cm5"
	desc = "A hammer that destroys 5 cm of debris."
	id = "hammercm5"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm5
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm6
	name = "Hammer cm6"
	desc = "A hammer that destroys 6 cm of debris."
	id = "hammercm6"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm6
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercm15
	name = "Hammer cm15"
	desc = "A hammer that destroys 15 cm of debris."
	id = "hammercm15"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/hammer/cm15
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hammercmadv
	name = "Advanced Hammer"
	desc = "A hammer that destroys up to 30 cm of debris."
	id = "hammercmadv"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1500)
	build_path = /obj/item/xenoarch/clean/hammer/advanced
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/cleanbrush
	name = "Brush"
	desc = "A brush that cleans debris."
	id = "hammerbrush"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/clean/brush/basic
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/cleanbrushadv
	name = "Advanced Brush"
	desc = "A brush that cleans debris."
	id = "hammerbrushadv"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1500)
	build_path = /obj/item/xenoarch/clean/brush/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

// Designs for tools

/datum/design/xenoscanner
	name = "Mining Scanner"
	desc = "A tool that scans depths of rocks."
	id = "xenoscanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/help/scanner
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/advxenoscanner
	name = "Advanced Mining Scanner"
	desc = "A tool that scans depths of rocks."
	id = "advxenoscanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1500)
	build_path = /obj/item/xenoarch/help/scanneradv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenomeasure
	name = "Measuring Tape"
	desc = "A tool to measure the dug depth of rocks."
	id = "xenomeasure"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/help/measuring
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenoresearch
	name = "Research Scanner"
	desc = "A tool used to get research points from artifacts."
	id = "xenoresearch"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1000)
	build_path = /obj/item/xenoarch/help/research
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenoplant
	name = "Fossil Seed Extractor"
	desc = "A tool to extract the seeds from prehistoric fossils."
	id = "xenoplant"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1000)
	build_path = /obj/item/xenoarch/help/plant
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/advcargoscanner
	name = "Cargo Scanner"
	desc = "A tool used to sell items, virtually."
	id = "advcargoscanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 1000, /datum/material/bluespace = 1000)
	build_path = /obj/item/xenoarch/help/cargo
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/xenobelt
	name = "Xenoarchaeology Belt"
	desc = "A belt used to store some xenoarch tools."
	id = "xenobelt"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/storage/belt/xenoarch
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenorockback
	name = "Xenoarchaeology Strange Rock Bag"
	desc = "A bag used to store 10 strange rocks."
	id = "xenorockback"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/storage/bag/strangerock
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenorockbackadv
	name = "Xenoarchaeology Bluespace Strange Rock Bag"
	desc = "A bluespace bag used to store 50 strange rocks."
	id = "xenorockbackadv"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 2000, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/strangerockadv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/obj/item/paper/fluff/stations/lavaland/xenoarch
	name = "xenoarchaeology notice"
	info = "<b><i>XENOARCHAEOLOGY GUIDE</i></b><br><br>So you want to figure out xenoarchaeology? Well, it's easy to learn and can be 'fun' to pick up!<br><br>First, make sure you mine some rocks and find those weird, strange rocks that are occasionally found.<br>Then, bring them back safely to the facility, or somewhere... ANYWHERE really. Just be cautious of onlookers!<br>Next, take your depth scanner and scan the sucker.<br><br>It'll have a base depth and a safe depth. These depths are important:<br><br>1) Base depth is the deepest the relic can be within the rock.<br>2) Safe depth is the depth from the base depth that is the earliest it will appear FROM the base depth.<br><br>Essentially, take the base depth and subtract the safe depth from it. Mine to this point and start to brush brush brush!<br>For example: You get a rock that has a base depth of 30 and a safe depth of 10. How deep should you mine?<br><br>You should mine to 20, and then start brushing away. Eventually you'll get the relic!<br><br>Hopefully this helps! If not well... I don't know what to tell you.<br><br>Peace!<br><i><b>Kobe Ivanov</b></i>,<br>P-A Xenoarchaeologist"
