/obj/item/reagent_containers/hypospray/medipen/survival/luxury/synth
	name = "synth emergency repair medipen"
	desc = "Cutting edge bluespace technology allowed Nanotrasen to compact 60u of volume into a single medipen. Contains rare and powerful chemicals used to aid synthetic species in exploration of very hard enviroments. WARNING: DO NOT MIX WITH EPINEPHRINE OR ATROPINE."
	icon_state = "luxpen"
	inhand_icon_state = "atropen"
	base_icon_state = "luxpen"
	volume = 60
	amount_per_transfer_from_this = 60
	list_reagents = list(/datum/reagent/medicine/chimerozyme = 30, /datum/reagent/medicine/c2/penthrite = 15 , /datum/reagent/medicine/leporazine = 15)

/datum/orderable_item/consumables/luxury_pen/synth
	item_path = /obj/item/reagent_containers/hypospray/medipen/survival/luxury/synth
	cost_per_order = 750

/datum/reagent/medicine/c2/penthrite
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/chimerozyme
	name = "Chimerozyme"
	description = "A compound of special nanites, designed to restore the body in very short durations. Its capable of fixing synthetic structural damage, along with fried internal wiring. "
	ph = 4.8
	specific_heat = SPECIFIC_HEAT_PLASMA * 1.2
	reagent_state = LIQUID
	color = "#b779cc"
	taste_description = "like alive insects"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	process_flags = REAGENT_SYNTHETIC
	metabolization_rate = 0.5 // fast
	overdose_threshold = 35 // it takes a lot, if youre really messed up you CAN hit this but its unlikely

/datum/movespeed_modifier/chimerozyme
	multiplicative_slowdown = 1.5

/datum/reagent/medicine/chimerozyme/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	var/need_mob_update
	need_mob_update += affected_mob.heal_bodypart_damage(-4 * REM * seconds_per_tick, -4 * REM * seconds_per_tick, required_bodytype = BODYTYPE_ROBOTIC)
	need_mob_update += affected_mob.adjustToxLoss(-2 * REM * normalise_creation_purity() * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/chimerozyme/overdose_start(mob/living/affected_mob)
	. = ..()
	to_chat(affected_mob, span_danger("You feel like your body starts overheating, washing you with wave of unbearable pain."))
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/chimerozyme)

/datum/reagent/medicine/chimerozyme/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	holder.remove_reagent(type, 1.2 * seconds_per_tick) // decays
	var/need_mob_update
	need_mob_update += affected_mob.take_bodypart_damage(8 * REM * normalise_creation_purity() * seconds_per_tick, 8 * REM * normalise_creation_purity())
	if(need_mob_update)
		return UPDATE_MOB_HEALTH
