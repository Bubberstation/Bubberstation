// For plushmium
/mob/living/basic/pet/plush
	name = "plushie"
	desc = "A living plushie!"
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	icon_living = "debug"
	icon_dead = "debug"
	gold_core_spawnable = NO_SPAWN
	mob_biotypes = MOB_ORGANIC
	butcher_results = list(/obj/item/toy/plush = 1)

	verb_say = "squeaks"
	verb_ask = "squeaks inquisitively"
	verb_exclaim = "squeaks intensely"
	verb_yell = "squeaks intensely"

	response_help_simple = "pet"
	response_help_continuous = "pets"
	response_disarm_simple = "gently shove"
	response_disarm_continuous = "gently shoves"
	response_harm_simple = "hit"
	response_harm_continuous = "hits"

	speed = 0
	pass_flags = PASSTABLE | PASSSTRUCTURE | PASSMOB

	maxHealth = 50
	health = 50
	melee_damage_type = STAMINA
	melee_damage_lower = 0
	melee_damage_upper = 1
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	death_message = "lets out a faint squeak as the glint in its eyes disappears"

	attack_sound = 'sound/items/weapons/bite.ogg'

	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	pressure_resistance = 200

	ai_controller = /datum/ai_controller/basic_controller/simple

	faction = list("neutral")

	mob_size = MOB_SIZE_TINY
	can_be_held = TRUE

//shell that lets people turn into the plush or poll for ghosts
/obj/item/toy/plushie_shell
	name = "Plushie Shell"
	desc = "A plushie. Its eyes seem to be staring right back at you. Something isn't quite right."
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	var/obj/item/toy/plush/stored_plush = null

//attacking yourself transfers your mind into the plush!
/obj/item/toy/plushie_shell/attack_self(mob/user)
	if(user.mind)
		var/safety = (tgui_alert(user, "The plushie is staring back at you intensely, it seems cursed! (Permanently become a plushie)", "Hugging this is a bad idea.", list("Hug it!", "Cancel")))
		if(safety == "Cancel" || !in_range(src, user))
			return
		to_chat(user, span_userdanger("You hug the strange plushie. You fool."))

		//setup the mob
		var/mob/living/basic/pet/plush/new_plushie = new /mob/living/basic/pet/plush(user.loc)
		new_plushie.icon = src.icon
		new_plushie.icon_living = src.icon_state
		new_plushie.icon_dead = src.icon_state
		new_plushie.icon_state = src.icon_state
		new_plushie.name = src.name

		//make the mob sentient
		user.mind.transfer_to(new_plushie)

		//add sounds to mob
		new_plushie.AddComponent(/datum/component/squeak, stored_plush.squeak_override)
		if(length(stored_plush.squeak_override) > 0)
			new_plushie.attack_sound = stored_plush.squeak_override[1]
			new_plushie.attacked_sound = stored_plush.squeak_override[1]

		//take care of the user's old body and the old shell
		user.dust(drop_items = TRUE)
		qdel(src)

//low regen over time
/mob/living/basic/pet/plush/Life()
	if(stat)
		return
	if(health < maxHealth)
		heal_overall_damage(5) //Decent life regen, they're not able to hurt anyone so this shouldn't be an issue (butterbear for reference has 10 regen)
