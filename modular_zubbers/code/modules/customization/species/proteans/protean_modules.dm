///////////Protean Modules///////////////
//Modules that only Proteans can use

/obj/item/mod/module/protean
	name = "protean module"
	desc = "Blank module for proteans"

////Protean servo module////
//Module meant to give temporary passive buffs to wearer, gives three options with diffrent effects and shared cooldowns.
/obj/item/mod/module/protean/servo
	name = "protean servo module"
	desc = "A module made for use in protean MOD suits that adds new subroutines while folded. Comes with three modes, each partially takes over MOD suit’s motor functions to enhance the wearer's general movement, performing medical duties or construction tasks. Due to high computing power demand, protean can only use this module while worn by someone else."
	icon_state = "no_baton"
	complexity = 3
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	module_type = MODULE_TOGGLE //with this the module will automaticly deactivate if it's depowered or taken off

//abilities that we'll be granting to Protean by activating the module
	var/datum/action/cooldown/protean/servo/movement/servo_movement = new /datum/action/cooldown/protean/servo/movement
	var/datum/action/cooldown/protean/servo/medical/servo_medical = new /datum/action/cooldown/protean/servo/medical
	var/datum/action/cooldown/protean/servo/engineering/servo_engineering = new /datum/action/cooldown/protean/servo/engineering

/obj/item/mod/module/protean/servo/on_activation()
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

/obj/item/mod/module/protean/servo/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = mod.core
	var/mob/living/carbon/human/protean_in_suit = protean_core?.linked_species.owner

	servo_movement.Remove(protean_in_suit) //All the cleanup
	servo_medical.Remove(protean_in_suit)
	servo_engineering.Remove(protean_in_suit)

	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo/movement)
	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo/medical)
	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo/engineer)

/////////////Protean Abilities////////////////////
//Abilities granted to Protean by the module

////Protean servo module////
/datum/action/cooldown/protean/
	background_icon_state = "bg_mod"

/datum/action/cooldown/protean/servo
	cooldown_time = 60 SECONDS
	cooldown_rounding = 1
	shared_cooldown = MOB_SHARED_COOLDOWN_1 //Using one action puts other two on cooldown
	text_cooldown = TRUE

/datum/action/cooldown/protean/servo/movement
	name = "Enchance movement"
	desc = "Aids your wearer's movement for few seconds but makes them clumsy while the effect persists!"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_electricity"

/datum/action/cooldown/protean/servo/movement/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo/movement)
	wearer.visible_message(span_warning("[protean] speeds up [wearer]'s movement!"))
	StartCooldown()

/datum/action/cooldown/protean/servo/medical
	name = "Enchance medical actions"
	desc = "Aids in your wearer's surgeries, medicicine aplications and carrying patients for moderate amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_blood"

/datum/action/cooldown/protean/servo/medical/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo/medical)
	wearer.visible_message(span_warning("[protean] assists in [wearer]'s medical actions!"))
	StartCooldown()

/datum/action/cooldown/protean/servo/engineering
	name = "Enchance building"
	desc = "Aids in your wearer's construction efforts and broader actions for moderate amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_repair"

/datum/action/cooldown/protean/servo/engineering/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo/engineer)
	wearer.visible_message(span_warning("[protean] assists in [wearer]'s construction tasks!"))
	StartCooldown()

///////////////Protean Module Effects////////////////////
//Effects generated by protean modules
#define PROTEAN_SERVO_TRAIT

////Protean servo module////
//Movement option
/atom/movable/screen/alert/status_effect/protean_servo_movement
	name = "Faster but clumsy"
	desc = "You are being aided by your MOD suit but extra speed is hard to control."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_electricity"

/datum/status_effect/protean_servo/movement
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_movement

/datum/status_effect/protean_servo/movement/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	owner.add_traits(list(TRAIT_CLUMSY),PROTEAN_SERVO_TRAIT) //main drawback to balance this particular effect out

/datum/status_effect/protean_servo/movement/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	owner.remove_traits(list(TRAIT_CLUMSY),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/movespeed_modifier/protean_servo/movement
	multiplicative_slowdown = -0.5 //movement speed modifier
	blacklisted_movetypes = (FLYING|FLOATING)

//Medical option
/atom/movable/screen/alert/status_effect/protean_servo_medical
	name = "Helping hand"
	desc = "Your MOD suit is guiding your hands to speed up surgery, applying medication or carrying patients."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_blood"

/datum/status_effect/protean_servo/medical
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_medical

/datum/status_effect/protean_servo/medical/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP, PROC_REF(servo_surgery_bonus)) //this is how we affect the surgery speed
	owner.add_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo/medical/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP)
	owner.remove_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/status_effect/protean_servo/medical/proc/servo_surgery_bonus(mob/living/carbon/_source, mob/living/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, datum/surgery_step/step, list/modifiers)
	SIGNAL_HANDLER
	modifiers[SPEED_MOD_INDEX] *= 0.5 //surgery speed modifier

//Engineering option
/atom/movable/screen/alert/status_effect/protean_servo_engineer
	name = "Adaptable grip"
	desc = "Your MOD suit's gloves are adapting their shape to better handle construction and item usage."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_repair"

/datum/status_effect/protean_servo/engineer
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_engineer

/datum/status_effect/protean_servo/engineer/on_apply()
	. = ..()
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.add_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo/engineer/on_remove()
	. = ..()
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.remove_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as protean module runs out of power"))

/datum/actionspeed_modifier/protean_servo_engineer
	multiplicative_slowdown = -0.35 //action speed modifier
