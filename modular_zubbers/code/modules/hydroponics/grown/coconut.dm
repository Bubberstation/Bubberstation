// Coconut
/obj/item/seeds/coconut
	name = "pack of coconut seeds"
	desc = "They're seeds that grow into coconut palm trees."
	icon = 'modular_zubbers/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-coconut"
	species = "coconut"
	plantname = "Coconut Palm Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/coconut
	lifespan = 50
	endurance = 30
	potency = 35
	growing_icon = 'modular_zubbers/icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "coconut-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/coconutmilk = 0.3)

/obj/item/reagent_containers/food/snacks/grown/coconut
	seed = /obj/item/seeds/coconut
	name = "coconut"
	desc = "Hard shell of a nut containing delicious milk inside. Perhaps try using something sharp?"
	icon = 'modular_zubbers/icons/obj/hydroponics/growing_fruits.dmi'
	icon_state = "coconut"
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	spillable = FALSE
	resistance_flags = ACID_PROOF
	volume = 150 //so it won't cut reagents despite having the capacity for them
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 5
	hitsound = 'modular_zubbers/sound/weapons/klonk.ogg'
	attack_verb = list("klonked", "donked", "bonked")
	distill_reagent = "creme_de_coconut"
	var/opened = FALSE
	var/carved = FALSE
	var/chopped = FALSE
	var/straw = FALSE
	var/fused = FALSE
	var/fusedactive = FALSE
	var/defused = FALSE

/obj/item/reagent_containers/food/snacks/grown/coconut/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	var/newvolume = 50 + round(seed.potency,10)
	if (seed.get_gene(/datum/plant_gene/trait/maxchem))
		newvolume = newvolume + 50
	volume = newvolume
	reagents.maximum_volume = newvolume
	reagents.update_total()

	transform *= TRANSFORM_USING_VARIABLE(40, 100) + 0.5 //temporary fix for size?

/obj/item/reagent_containers/food/snacks/grown/coconut/attack_self(mob/user)
	if (!opened)
		return

	if(!possible_transfer_amounts.len)
		return
	var/i=0
	for(var/A in possible_transfer_amounts)
		i++
		if(A != amount_per_transfer_from_this)
			continue
		if(i<possible_transfer_amounts.len)
			amount_per_transfer_from_this = possible_transfer_amounts[i+1]
		else
			amount_per_transfer_from_this = possible_transfer_amounts[1]
		to_chat(user, "<span class='notice'>[src]'s transfer amount is now [amount_per_transfer_from_this] units.</span>")
		return

/obj/item/reagent_containers/food/snacks/grown/coconut/attackby(obj/item/W, mob/user, params)
	//DEFUSING NADE LOGIC
	if (W.tool_behaviour == TOOL_WIRECUTTER && fused)
		user.show_message("<span class='notice'>You cut the fuse!</span>", MSG_VISUAL)
		playsound(user, W.hitsound, 50, 1, -1)
		icon_state = "coconut_carved"
		desc = "A coconut. This one's got a hole in it."
		name = "coconut"
		defused = TRUE
		fused = FALSE
		fusedactive = FALSE
		if(!seed.get_gene(/datum/plant_gene/trait/glow))
			set_light(0, 0.0)
		return
	//IGNITING NADE LOGIC
	if(!fusedactive && fused)
		var/lighting_text = W.ignition_effect(src, user)
		if(lighting_text)
			user.visible_message("<span class='warning'>[user] ignites [src]'s fuse!</span>", "<span class='userdanger'>You ignite the [src]'s fuse!</span>")
			fusedactive = TRUE
			defused = FALSE
			playsound(src, 'sound/effects/fuse.ogg', 100, 0)
			message_admins("[ADMIN_LOOKUPFLW(user)] ignited a coconut bomb for detonation at [ADMIN_VERBOSEJMP(user)] [pretty_string_from_reagent_list(reagents.reagent_list)]")
			log_game("[key_name(user)] primed a coconut grenade for detonation at [AREACOORD(user)].")
			addtimer(CALLBACK(src, .proc/prime), 5 SECONDS)
			icon_state = "coconut_grenade_active"
			desc = "RUN!"
			if(!seed.get_gene(/datum/plant_gene/trait/glow))
				light_color = "#FFCC66" //for the fuse
				set_light(3, 0.8)
			return

	//ADDING A FUSE, NADE LOGIC
	if (istype(W,/obj/item/stack/sheet/cloth) || istype(W,/obj/item/stack/sheet/durathread))
		if (carved && !straw && !fused)
			user.show_message("<span class='notice'>You add a fuse to the coconut!</span>", 1)
			W.use(1)
			fused = TRUE
			icon_state = "coconut_grenade"
			desc = "A makeshift bomb made out of a coconut. You estimate the fuse is long enough for 5 seconds."
			name = "coconut bomb"
			return
	//ADDING STRAW LOGIC
	if (istype(W,/obj/item/stack/sheet/mineral/bamboo) && opened && !straw && fused)
		user.show_message("<span class='notice'>You add a bamboo straw to the coconut!</span>", 1)
		straw = TRUE
		W.use(1)
		icon_state += "_straw"
		desc = "You can already feel like you're on a tropical vacation."
		return
	//OPENING THE NUT LOGIC
	if (!carved && !chopped)
		var/screwdrivered = W.tool_behaviour == TOOL_SCREWDRIVER
		if(screwdrivered || W.sharpness)
			user.show_message("<span class='notice'>You [screwdrivered ? "make a hole in the coconut" : "slice the coconut open"]!</span>", 1)
			carved = TRUE
			opened = TRUE
			spillable = !screwdrivered
			reagent_flags = OPENCONTAINER
			reagents.reagents_holder_flags |= OPENCONTAINER
			icon_state = screwdrivered ? "coconut_carved" : "coconut_chopped"
			desc = "A coconut. [screwdrivered ? "This one's got a hole in it" : "This one's sliced open, with all its delicious contents for your eyes to savour"]."
			playsound(user, W.hitsound, 50, 1, -1)
			return
	return ..()

/obj/item/reagent_containers/food/snacks/grown/coconut/attack(mob/living/M, mob/user, obj/target)
	if(M && user.a_intent == INTENT_HARM && !spillable)
		var/obj/item/bodypart/affecting = user.zone_selected //Find what the player is aiming at
		if (affecting == BODY_ZONE_HEAD && prob(15))
			//smash the nut open
			var/armor_block = min(90, M.run_armor_check(affecting, MELEE, null, null,armour_penetration)) // For normal attack damage
			M.apply_damage(force, BRUTE, affecting, armor_block)

			//Sound
			playsound(user, hitsound, 100, 1, -1)

			//Attack logs
			log_combat(user, M, "attacked", src)

			//Display an attack message.
			if(M != user)
				M.visible_message("<span class='danger'>[user] has cracked open a [name] on [M]'s head!</span>", \
						"<span class='userdanger'>[user] has cracked open a [name] on [M]'s head!</span>")
			else
				user.visible_message("<span class='danger'>[M] cracks open a [name] on their [M.p_them()] head!</span>", \
						"<span class='userdanger'>[M] cracks open a [name] on [M.p_their()] head!</span>")

			//The coconut breaks open so splash its reagents
			spillable = TRUE
			SplashReagents(M)

			//Lastly we remove the nut
			qdel(src)
		else
			. = ..()
		return

	if(fusedactive)
		return

	if(!opened)
		return

	if(!canconsume(M, user))
		return

	if(!reagents || !reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return

	if(user.a_intent == INTENT_HARM && spillable)
		var/R
		M.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [M]!</span>", \
						"<span class='userdanger'>[user] splashes the contents of [src] onto [M]!</span>")
		if(reagents)
			for(var/datum/reagent/A in reagents.reagent_list)
				R += A.type + " ("
				R += num2text(A.volume) + "),"
		if(isturf(target) && reagents.reagent_list.len && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
			message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
		reagents.reaction(M, TOUCH)
		log_combat(user, M, "splashed", R)
		reagents.clear_reagents()
	else
		if(M != user)
			M.visible_message("<span class='danger'>[user] attempts to feed something to [M].</span>", \
						"<span class='userdanger'>[user] attempts to feed something to you.</span>")
			if(!do_mob(user, M))
				return
			if(!reagents || !reagents.total_volume)
				return // The drink might be empty after the delay, such as by spam-feeding
			M.visible_message("<span class='danger'>[user] feeds something to [M].</span>", "<span class='userdanger'>[user] feeds something to you.</span>")
			log_combat(user, M, "fed", reagents.log_list())
		else
			to_chat(user, "<span class='notice'>You swallow a gulp of [src].</span>")
		var/fraction = min(5/reagents.total_volume, 1)
		reagents.reaction(M, INGEST, fraction)
		addtimer(CALLBACK(reagents, /datum/reagents.proc/trans_to, M, 5), 5)
		playsound(M.loc,'sound/items/drink.ogg', rand(10,50), 1)

/obj/item/reagent_containers/food/snacks/grown/coconut/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(fusedactive)
		return

	if((!proximity) || !check_allowed_items(target,target_self=1))
		return

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src] is empty!</span>")
			return

		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return

		var/trans = reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>You transfer [trans] unit\s of the solution to [target].</span>")

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='warning'>[target] is empty and can't be refilled!</span>")
			return

		if(reagents.holder_full())
			to_chat(user, "<span class='warning'>[src] is full.</span>")
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>You fill [src] with [trans] unit\s of the contents of [target].</span>")

	else if(reagents.total_volume)
		if(user.a_intent == INTENT_HARM && spillable == TRUE)
			user.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [target]!</span>", \
								"<span class='notice'>You splash the contents of [src] onto [target].</span>")
			reagents.reaction(target, TOUCH)
			reagents.clear_reagents()

/obj/item/reagent_containers/food/snacks/grown/coconut/dropped(mob/user)
	. = ..()
	transform *= TRANSFORM_USING_VARIABLE(40, 100) + 0.5 //temporary fix for size?

/obj/item/reagent_containers/food/snacks/grown/coconut/proc/prime()
	if (defused)
		return
	var/turf/T = get_turf(src)
	reagents.chem_temp = 1000
	reagents.handle_reactions()
	log_game("Coconut bomb detonation at [AREACOORD(T)], location [loc]")
	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/coconut/ex_act(severity, target, origin)
	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/coconut/deconstruct(disassembled = TRUE)
	if(!disassembled && fused)
		prime()
	if(!QDELETED(src))
		qdel(src)
