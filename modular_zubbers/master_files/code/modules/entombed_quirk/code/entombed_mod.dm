/datum/mod_theme/entombed
	name = "fused"
	desc = "Circumstances have rendered this protective suit into someone's second skin. Literally."
	extended_desc = "Some great aspect of someone's past has permanently bound them to this device, for better or worse."

	default_skin = "standard"
	armor_type = /datum/armor/mod_entombed
	resistance_flags = FIRE_PROOF | ACID_PROOF // It is better to die for the Emperor than live for yourself.
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	charge_drain = DEFAULT_CHARGE_DRAIN
	slowdown_inactive = 2.5 // very slow because the quirk infers you rely on this to move/exist
	slowdown_active = 0.95
	inbuilt_modules = list(
		/obj/item/mod/module/joint_torsion/entombed
	)
	allowed_suit_storage = list(
		/obj/item/tank/internals,
		/obj/item/flashlight,
	)

/datum/armor/mod_entombed
	melee = 30
	bullet = 30
	laser = 30
	energy = 30
	bio = 100
	fire = 30
	acid = 30
	wound = 30

/obj/item/mod/module/joint_torsion/entombed
	name = "internal joint torsion adaptation"
	desc = "Your adaptation to life in this MODsuit shell allows you to ambulate in such a way that your movements recharge the suit's internal batteries slightly, but only while under the effect of gravity."
	removable = FALSE
	complexity = 0
	power_per_step = DEFAULT_CHARGE_DRAIN * 0.4

/obj/item/mod/module/plasma_stabilizer/entombed
	name = "colony-stabilized interior seal"
	desc = "Your colony has fully integrated the internal segments of your suit's plate into your skeleton, forming a hermetic seal between you and the outside world from which none of your atmosphere can escape. This is enough to allow your head to view the world with your helmet retracted."
	complexity = 0
	idle_power_cost = 0
	removable = FALSE

/obj/item/mod/control/pre_equipped/entombed
	theme = /datum/mod_theme/entombed
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity
	)

/obj/item/mod/control/pre_equipped/entombed/canStrip(mob/who)
	return TRUE //you can always try, and it'll hit doStrip below

/obj/item/mod/control/pre_equipped/entombed/doStrip(mob/who)
	// attempt to handle custom stripping behavior - if we have a storage module of some kind
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if (!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(who, span_notice("You empty out all the items from the MODsuit's storage module!"))
		who.balloon_alert(who, "emptied out MOD storage items!")
		return TRUE

	to_chat(who, span_warning("The suit seems permanently fused to their frame - you can't remove it!"))
	who.balloon_alert(who, "can't strip a fused MODsuit!")
	return ..()

/obj/item/mod/control/pre_equipped/entombed/retract(mob/user, obj/item/part)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//check to make sure we're not retracting something we shouldn't be able to
		if (tomb_quirk && tomb_quirk.deploy_locked)
			if (istype(part, /obj/item/clothing)) // make sure it's a modsuit piece and not a module, we retract those too
				if (!istype(part, /obj/item/clothing/head/mod)) // they can only retract the helmet, them's the sticks
					human_user.balloon_alert(human_user, "part is fused to you - can't retract!")
					playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
					return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/quick_deploy(mob/user)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//if we're deploy_locked, just disable this functionality entirely
		if (tomb_quirk && tomb_quirk.deploy_locked)
			human_user.balloon_alert(human_user, "you can only retract your helmet, and only manually!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/Initialize(mapload, new_theme, new_skin, new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)
