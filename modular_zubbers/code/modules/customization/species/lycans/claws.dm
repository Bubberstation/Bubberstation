/obj/item/mutant_hand/lycan_claw
	name = "extended claws"
	desc = "An extended set of claws, slower but more powerful, and capable of striking structures. Worse for actual combat."
	gender = PLURAL
	demolition_mod = 1.5
	armour_penetration = 10
	attack_speed = CLICK_CD_MELEE * 2
	hitsound = 'sound/items/weapons/slash.ogg'
	obj_flags = CONDUCTS_ELECTRICITY

/datum/action/extend_lycan_claws
	name = "Extend Claws"
	desc = "Extend your claws to perform powerful, stunning blows on objects and synthetics, at the cost of anti-organic performance."
	button_icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	button_icon_state = "wolverine"
	var/obj/item/mutant_hand/lycan_claw/claw

/datum/action/extend_lycan_claws/Remove(mob/remove_from)
	. = ..()

	QDEL_NULL(claw)

/datum/action/extend_lycan_claws/Destroy()
	. = ..()

	QDEL_NULL(claw)

/datum/action/extend_lycan_claws/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if (!.)
		return FALSE
	if (HAS_TRAIT(owner, TRAIT_PACIFISM))
		to_chat(owner, span_warning("You're scared of hurting someone with your elongated claws!"))
		return FALSE
	if (!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	var/obj/item/bodypart/arm/active_arm = human_owner.get_active_hand()
	if (!istype(active_arm))
		return FALSE

	if (claw)
		human_owner.balloon_alert_to_viewers("claws retracted")
		QDEL_NULL(claw)
		playsound(get_turf(human_owner), 'sound/items/tools/change_drill.ogg', 50, TRUE)
		return TRUE

	var/obj/item/existing = human_owner.get_active_held_item()
	if (!isnull(existing))
		human_owner.balloon_alert(human_owner, "hand occupied!")
		return FALSE

	claw = new /obj/item/mutant_hand/lycan_claw()
	claw.force = active_arm.unarmed_damage_high * 1.25
	claw.sharpness = active_arm.unarmed_sharpness
	human_owner.put_in_active_hand(claw, ignore_animation = TRUE)
	human_owner.balloon_alert_to_viewers("claws extended")
	playsound(get_turf(human_owner), 'sound/items/tools/change_drill.ogg', 50, TRUE)
