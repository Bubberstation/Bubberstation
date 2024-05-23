/obj/item/shield/big_bertha
	name = "Big Bertha"
	desc = "A shield so fat and heavy, it should block just about anything. That's why they call her Big Bertha."
	icon = 'modular_zubbers/modules/big_bertha_shield/icons/shields.dmi'
	lefthand_file = 'modular_zubbers/modules/big_bertha_shield/icons/shields_both.dmi'
	righthand_file = 'modular_zubbers/modules/big_bertha_shield/icons/shields_both.dmi'
	icon_state = "big_bertha"
	block_chance = 100
	slot_flags = null
	force = 12
	throwforce = 3
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("shoves", "bashes","berthas")
	attack_verb_simple = list("shove", "bash","bertha")
	armor_type = /datum/armor/big_bertha
	block_sound = 'sound/weapons/block_shield.ogg'
	breakable_by_damage = FALSE
	item_flags = IMMUTABLE_SLOW | SLOWS_WHILE_IN_HAND

/obj/item/shield/big_bertha/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/datum/armor/big_bertha
	melee = 100
	bullet = 100
	laser = 75
	bomb = 50
	fire = 80
	acid = 70

/datum/area_spawn_over/big_bertha
	desired_atom = /obj/item/shield/big_bertha
	target_areas = list(
		/area/station/ai_monitored/security/armory,
		/area/station/ai_monitored/security/armory/upper,
		/area/station/security/warden,
		/area/station/security/office,
	)
	over_atoms = list(
		/obj/structure/rack,
		/obj/structure/table,
		/obj/structure/closet
	)
	blacklisted_stations = list("Runtime Station", "MultiZ Debug", "Gateway Test")
