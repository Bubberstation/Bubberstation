//Smites to crush someone with an anvil. First one prompts for a damage value. Second has a preset damage value and shouldn't kill if the person is healthy.
/datum/smite/crush
	name = "Crush with Anvil (Custom Damage)"

/datum/smite/crush/effect(client/user, mob/living/target)
	. = ..()
	var/hurty = tgui_input_number(user, "How much do you want them to be crushed? 120 will crit, 240 will kill! Anything more than that is extra.", "Crushing time", 120, 600, 0)
		
	var/obj/structure/reagent_anvil/crushing_thing = new /obj/structure/reagent_anvil(target.loc)
	crushing_thing.SpinAnimation(3,2)
	crushing_thing.layer = ABOVE_MOB_LAYER

	target.emote("scream")
	target.AddElement(/datum/element/squish, 30 SECONDS)
	target.Paralyze(0.05 SECONDS * hurty)
	target.Knockdown(0.1 SECONDS * hurty)
	target.apply_damage(damage = hurty, damagetype = BRUTE, blocked = 0, spread_damage = TRUE, wound_clothing = FALSE)
	
	playsound(target, 'sound/effects/splat.ogg', 50, TRUE)
	playsound(target, 'sound/effects/bang.ogg', 60, TRUE)
	if(hurty > 100)
		playsound(target, 'modular_skyrat/modules/gladiator/Clang_cut.ogg', 100, TRUE)

	target.visible_message(span_danger("[crushing_thing] crashes from above onto [target]!"))
	if(target.stat == DEAD)
		target.visible_message(span_danger("[target] is killed instantly!"))

/datum/smite/crush_preset
	name = "Crush with Anvil"

/datum/smite/crush_preset/effect(client/user, mob/living/target)
	. = ..()		
	var/obj/structure/reagent_anvil/crushing_thing = new /obj/structure/reagent_anvil(target.loc)
	crushing_thing.SpinAnimation(3,2)
	crushing_thing.layer = ABOVE_MOB_LAYER

	target.emote("scream")
	target.AddElement(/datum/element/squish, 30 SECONDS)
	target.Paralyze(6 SECONDS)
	target.Knockdown(12 SECONDS)
	target.apply_damage(damage = 120, damagetype = BRUTE, blocked = 0, spread_damage = TRUE, wound_clothing = FALSE)

	playsound(target, 'sound/effects/splat.ogg', 50, TRUE)
	playsound(target, 'sound/effects/bang.ogg', 60, TRUE)
	playsound(target, 'modular_skyrat/modules/gladiator/Clang_cut.ogg', 100, TRUE)

	target.visible_message(span_danger("[crushing_thing] crashes from above onto [target]!"))
