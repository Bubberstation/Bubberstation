// Need some sprites for a generic item that looks like it does a thing?
// Use the old GANGTOOL SPRITES!
/obj/item/patient_spawner
	name = "patient spawner"
	desc = "Use this in hand to request the airdrop of some very sick patients!"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "suspiciousphone"
	w_class = WEIGHT_CLASS_TINY

/obj/item/patient_spawner/attack_self(mob/user)
	user.visible_message("<span class='warning'>[user] activates [src]! Looks like some patients are on route!</span>")
	do_sparks(5, FALSE, get_turf(src))

	// Add additional spawners to this list to get more patients.
	var/spawners = list(
		/obj/effect/mob_spawn/human/appendicitis_patient,
		/obj/effect/mob_spawn/human/hugged_patient,
		/obj/effect/mob_spawn/human/bone_hurting_juice_patient,
		/obj/effect/mob_spawn/corpse/human/decayed_patient
	)

	var/turf/floor = get_turf(src)
	var/list/mobs = list()

	for(var/spawner_type in spawners)
		var/obj/effect/mob_spawn/mob_spawn = new spawner_type(floor)
		if(mob_spawn)
			mobs += mob_spawn.create()

	for(var/mob/living/spawned_mob in mobs)
		var/obj/structure/closet/supplypod/centcompod/pod = new()
		spawned_mob.forceMove(pod)
		new /obj/effect/pod_landingzone(floor, pod)

	qdel(src)

/obj/effect/mob_spawn/human/appendicitis_patient
	name = "Appendicitis Patient"
	outfit = /datum/outfit/job/cook

/obj/effect/mob_spawn/human/appendicitis_patient/create()
	var/mob/living/carbon/human/mob = ..()
	if(!mob)
		return null

	mob.adjustToxLoss(5)
	mob.adjustOrganLoss(ORGAN_SLOT_APPENDIX, 15)

	var/obj/item/organ/appendix/appendix = mob.get_organ_by_type(/obj/item/organ/appendix)
	if(appendix)
		appendix.inflamation_stage = 3
	return mob

/obj/effect/mob_spawn/human/hugged_patient
	name = "Infested Patient"
	outfit = /datum/outfit/centcom/death_commando/disarmed

/obj/effect/mob_spawn/human/hugged_patient/create()
	var/mob/living/mob = ..()
	new /obj/item/organ/body_egg/alien_embryo(mob)
	return mob

/obj/effect/mob_spawn/corpse/human/decayed_patient
	name = "Decayed Patient"
	outfit = /datum/outfit/job/miner/equipped/mod
	husk = TRUE

/obj/effect/mob_spawn/human/decayed_patient/create()
	var/mob/living/carbon/mob = ..()
	for(var/obj/item/organ/organ as anything in mob.organs)
		organ.apply_organ_damage(INFINITY)
	return mob

/obj/effect/mob_spawn/human/bone_hurting_juice_patient
	name = "Bone Hurting Juice Patient"
	outfit = /datum/outfit/wizardcorpse

/obj/effect/mob_spawn/human/bone_hurting_juice_patient/create()
	var/mob/living/carbon/mob = ..()

	mob.reagents.add_reagent(/datum/reagent/toxin/bonehurtingjuice, 40)

	for(var/obj/item/bodypart/bodypart as anything in mob.bodyparts)
		var/datum/wound/blunt/bone/critical/wound = new /datum/wound/blunt/bone/critical()
		wound.apply_wound(bodypart)

	return mob
