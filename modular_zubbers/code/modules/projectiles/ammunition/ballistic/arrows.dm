/datum/crafting_recipe/blunted_arrow
	name = "Arrow (Less-lethal)"
	result = /obj/item/ammo_casing/arrow/blunt
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/iron = 1,
	)
	tool_paths = list(
		/obj/item/hatchet,
	)
	category = CAT_WEAPON_AMMO
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/blunted_arrow_conversion
	name = "Blunt Arrow Conversion"
	result = /obj/item/ammo_casing/arrow/blunt
	reqs = list(
		/obj/item/ammo_casing/arrow = 1,
	)
	tool_behaviors = list(TOOL_SAW)
	category = CAT_WEAPON_AMMO
	non_craftable = TRUE
	steps = list("Smooth the arrowhead with the saw.")

/datum/crafting_recipe/taser_arrow
	name = "Arrow (Electric, Non-lethal)"
	result = /obj/item/ammo_casing/arrow/taser
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/iron = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/power_store/cell = 1,
	)
	tool_paths = list(
		/obj/item/hatchet,
	)
	category = CAT_WEAPON_AMMO
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/taser_arrow_conversion
	name = "Taser Arrow Conversion"
	result = /obj/item/ammo_casing/arrow/taser
	reqs = list(
		/obj/item/ammo_casing/arrow = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/power_store/cell = 1,
	)
	blacklist = list(
		/obj/item/ammo_casing/arrow/taser
	)
	time = 1 SECONDS
	tool_behaviors = list(TOOL_SAW)
	category = CAT_WEAPON_AMMO

/obj/item/ammo_casing/arrow/blunt
	name = "blunt arrow"
	desc = "An arrow with its head reduced to a blunt tip. Suitable for breaking bones and subduing targets without excessive physical damage. Staggers targets on impact."
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "blunt_arrow"
	projectile_type = /obj/projectile/bullet/arrow/blunt

/obj/projectile/bullet/arrow/blunt
	name = "blunt arrow"
	desc = "A blunted arrow."
	damage = 5 // ow
	stamina = 40 // its okay
	wound_bonus = 35 // will sometimes cause dislocations at close range
	gets_tribal_bonus = FALSE // technically a modern arrow + meant to be less lethal
	embed_type = null
	sharpness = NONE

/obj/projectile/bullet/arrow/blunt/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if (pierce_hit)
		return
	if (. == BULLET_ACT_BLOCK || blocked >= 100 || !isliving(target))
		return

	var/mob/living/living_target = target
	var/percent_blocked = blocked / 100

	living_target.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * (1 - percent_blocked), 10 SECONDS) // it hits really hard

/obj/item/ammo_casing/arrow/taser
	name = "taser arrow"
	desc = "An arrow, the head removed, replaced with an igniter, and hooked up to a power cell. Negligible damage, but capable of delivering a terrible electric shock.\n\
	Likely to break apart on impact. Ineffective against those insulated against electricity."
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "taser_arrow"
	reusable = FALSE
	projectile_type = /obj/projectile/bullet/arrow/taser
	harmful = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.2, /datum/material/wood = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.1)

/obj/projectile/bullet/arrow/taser
	name = "taser arrow"
	desc = "A jury-rigged taser arrow, capable of delivering a terrible electric shock, and not much else."
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "taser_arrow_projectile"
	damage = 0 // lol
	stamina = 5
	/// Staimna damage to be dealt by the shock. Separate from stamina - insulated individuals might be immune to the shock.
	var/shock_damage = 50 //stamcrit in two but any armor at all reduces it to three
	gets_tribal_bonus = FALSE // technically a modern arrow + meant to be less lethal
	embed_type = null
	sharpness = NONE

/obj/projectile/bullet/arrow/taser/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if (pierce_hit)
		return
	do_sparks(3, TRUE, src)
	if (. == BULLET_ACT_BLOCK || blocked >= 100 || !isliving(target))
		return
	var/mob/living/living_target = target
	living_target.electrocute_act(shock_damage, src, 1, SHOCK_ILLUSION|SHOCK_SUPPRESS_MESSAGE|SHOCK_NOGLOVES|SHOCK_KNOCKDOWN) // illusion so it doesnt do damage
