/////////Protean servo module////////
//Module meant to give temporary passive buffs to wearer, gives three options with diffrent effects and shared cooldowns.

/obj/item/mod/module/protean_servo
	name = "protean MOD servo module"
	desc = "A module made for use in protean MOD suits that adds new subroutines while folded. Comes with three modes, each partially takes over MOD suit’s motor functions to enhance the wearer's general movement, performing medical duties or construction tasks. Due to high computing power demand, protean can only use this module while worn by someone else."
	icon_state = "no_baton"
	complexity = 3
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	module_type = MODULE_TOGGLE //with this the module will automaticly deactivate if it's depowered or taken off

//abilities that we'll be granting to Protean by activating the module
	var/datum/action/cooldown/protean_servo/movement/servo_movement = new /datum/action/cooldown/protean_servo/movement
	var/datum/action/cooldown/protean_servo/medical/servo_medical = new /datum/action/cooldown/protean_servo/medical
	var/datum/action/cooldown/protean_servo/engineering/servo_engineering = new /datum/action/cooldown/protean_servo/engineering

/obj/item/mod/module/protean_servo/on_activation()
	. = ..()

	var/obj/item/mod/core/protean/protean_core = mod.core
	var/mob/living/carbon/human/protean_in_suit = protean_core.linked_species.owner

	if(protean_in_suit == mod.wearer) //Protean cant benefit from module they're suposed to be powering
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(mod.wearer, span_warning("[src] needs someone else as the wearer, it can't be used on a protean."))
		deactivate()
		return

	servo_movement.Grant(protean_in_suit)
	servo_medical.Grant(protean_in_suit)
	servo_engineering.Grant(protean_in_suit)

/obj/item/mod/module/protean_servo/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = mod.core
	var/mob/living/carbon/human/protean_in_suit = protean_core?.linked_species.owner

	servo_movement.Remove(protean_in_suit) //All the cleanup, since module deactivates once out of power, this will remove granted abilities
	servo_medical.Remove(protean_in_suit)
	servo_engineering.Remove(protean_in_suit)

	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_movement)
	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_medical)
	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_engineer)

////Protean servo module: Abilities////
//The abilities we give to protean once module is active

/datum/action/cooldown/protean_servo
	background_icon_state = "bg_mod"
	cooldown_time = 60 SECONDS
	cooldown_rounding = 1
	shared_cooldown = MOB_SHARED_COOLDOWN_1 //Using one action puts other two on cooldown
	text_cooldown = TRUE

/datum/action/cooldown/protean_servo/movement
	name = "Enhance movement"
	desc = "Aids your wearer's movement for few seconds but restrains their hands and makes them easier to get grabbed"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_electricity"

/datum/action/cooldown/protean_servo/movement/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_movement)
	wearer.visible_message(span_warning("[protean] speeds up [wearer]'s movement!"))
	StartCooldown()

/datum/action/cooldown/protean_servo/medical
	name = "Enhance medical actions"
	desc = "Aids in your wearer's surgeries, medicicine aplications and carrying patients for moderate amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_blood"

/datum/action/cooldown/protean_servo/medical/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_medical)
	wearer.visible_message(span_warning("[protean] assists in [wearer]'s medical actions!"))
	StartCooldown()

/datum/action/cooldown/protean_servo/engineering
	name = "Enhance building"
	desc = "Aids in your wearer's construction efforts and broader actions for moderate amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_repair"

/datum/action/cooldown/protean_servo/engineering/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_engineer)
	wearer.visible_message(span_warning("[protean] assists in [wearer]'s construction tasks!"))
	StartCooldown()

////Protean servo module: Status Effects////
//Status effects that are granted to wearer

/atom/movable/screen/alert/status_effect/protean_servo_movement
	name = "Faster but clumsy"
	desc = "Your MOD is making you faster but also easier to grab and unable to use hands."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_electricity"

/datum/status_effect/protean_servo_movement
	id = "protean_servo_movement"
	duration = 7 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_movement

/datum/status_effect/protean_servo_movement/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	for(var/obj/item/thing in owner.held_items)
		ADD_TRAIT(thing, TRAIT_NODROP, PROTEAN_SERVO_TRAIT) //to prevent items droping out of wearer's hands
		RegisterSignals(thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED), PROC_REF(clear_servo_trait)) //In case you somehow drop it anyway
	owner.add_traits(list(TRAIT_RESTRAINED),PROTEAN_SERVO_TRAIT) //main drawback to balance out this particular effect

/datum/status_effect/protean_servo_movement/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	owner.remove_traits(list(TRAIT_RESTRAINED),PROTEAN_SERVO_TRAIT)
	for(var/obj/item/thing in owner.held_items)
		clear_servo_trait(thing)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/status_effect/protean_servo_movement/proc/clear_servo_trait(obj/item/thing, ...)
	SIGNAL_HANDLER
	REMOVE_TRAIT(thing, TRAIT_NODROP, PROTEAN_SERVO_TRAIT)
	UnregisterSignal(thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED))

/datum/movespeed_modifier/protean_servo/movement
	multiplicative_slowdown = -0.4 //movement speed modifier
	blacklisted_movetypes = (FLYING|FLOATING)

//Medical option
/atom/movable/screen/alert/status_effect/protean_servo_medical
	name = "Helping hand"
	desc = "Your MOD suit is guiding your hands to speed up surgery, applying medication or carrying patients."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_blood"

/datum/status_effect/protean_servo_medical
	id = "protean_servo_medical"
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_medical

/datum/status_effect/protean_servo_medical/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP, PROC_REF(servo_surgery_bonus)) //this is how we affect the surgery speed
	owner.add_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo_medical/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP)
	owner.remove_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/status_effect/protean_servo_medical/proc/servo_surgery_bonus(mob/living/carbon/_source, mob/living/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, datum/surgery_step/step, list/modifiers)
	SIGNAL_HANDLER
	modifiers[SPEED_MOD_INDEX] *= 0.5 //surgery speed modifier

//Engineering option
/atom/movable/screen/alert/status_effect/protean_servo_engineer
	name = "Adaptable grip"
	desc = "Your MOD suit's gloves are adapting their shape to better handle construction and item usage."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_repair"

/datum/status_effect/protean_servo_engineer
	id = "protean_servo_engineer"
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_engineer

/datum/status_effect/protean_servo_engineer/on_apply()
	. = ..()
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.add_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo_engineer/on_remove()
	. = ..()
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.remove_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/actionspeed_modifier/protean_servo_engineer
	multiplicative_slowdown = -0.35 //action speed modifier


