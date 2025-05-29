/obj/item/seeds/lipoplant
	name = "pack of adipolipus"
	desc = "These seeds grow into a foreign plant."
	species = "adipolipus"
	plantname = "Adipolipus"
	product = /obj/item/reagent_containers/food/snacks/grown/lipofruit
	lifespan = 30
	potency = 20
	maturation = 8
	production = 5
	yield = 1
	reagents_add = list(/datum/reagent/consumable/lipoifier = 0.05)
	icon = 'GainStation13/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-lipo"
	growing_icon = 'GainStation13/icons/obj/hydroponics/growing.dmi'
	icon_grow = "lipo-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "lipo-dead" // Same for the dead icon
	icon_harvest = "lipo-harvest"

/obj/item/reagent_containers/food/snacks/grown/lipofruit
	seed = /obj/item/seeds/lipoplant
	name = "lipofruit"
	desc = "A foreign fruit with an hard shell. Perhaps something sharp could open it?"
	icon = 'GainStation13/icons/obj/hydroponics/harvest.dmi'
	icon_state = "lipo_nut"
	item_state = "lipo_nut"
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	spillable = FALSE
	resistance_flags = ACID_PROOF
	volume = 150 //so it won't cut reagents despite having the capacity for them
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 5
	hitsound = 'sound/weapons/klonk.ogg'
	attack_verb = list("klonked", "donked", "bonked")
	distill_reagent = "creme_de_coconut"
	var/opened = FALSE

/obj/item/reagent_containers/food/snacks/grown/lipofruit/attackby(obj/item/W, mob/user, params)
	if(!opened && W.sharpness)
		user.show_message("<span class='notice'>You slice the fruit open!</span>", 1)
		opened = TRUE
		spillable = TRUE
		reagent_flags = OPENCONTAINER
		reagents.reagents_holder_flags |= OPENCONTAINER
		icon_state = "lipo_nutcut_full"
		desc = "A foreign fruit with an hard shell, the liquid inside looks very inviting."
		playsound(user, W.hitsound, 50, 1, -1)
		return
	return ..()

/obj/item/reagent_containers/food/snacks/grown/lipofruit/attack(mob/living/M, mob/user, obj/target)
	if(!opened)
		return
	if(!canconsume(M, user))
		return
	if(!reagents || !reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return

	if(user.a_intent == INTENT_HARM && spillable)
		var/R
		M.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [M]!</span>",
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
			M.visible_message("<span class='danger'>[user] attempts to feed something to [M].</span>",
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
		addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), M, 5), 5)
		playsound(M.loc,'sound/items/drink.ogg', rand(10,50), 1)
	if(!reagents || reagents.total_volume)
		icon_state = "lipo_nutcut_empty"
		desc = "A foreign fruit with an hard shell."

/obj/item/reagent_containers/food/snacks/grown/lipofruit/afterattack(obj/target, mob/user, proximity)
	. = ..()
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
	if(reagents && reagents.total_volume && opened)
		icon_state = "lipo_nutcut_full"
		desc = "A foreign fruit with an hard shell, the liquid inside looks very inviting."

