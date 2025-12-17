/// Gifts that typically contain pretty much any item in the game, except with all of the admin/debug gear filtered out.
/obj/item/gift/mostly_anything
	name = "christmas gift"
	desc = "It could be pretty much anything!"

/obj/item/gift/mostly_anything/get_gift_type(obj/item/gift/mostly_anything/present)
	var/static/list/obj/item/possible_gifts = null

	if(isnull(possible_gifts))
		possible_gifts = get_sane_item_types(/obj/item)

	var/list/filtered = list()

	for(var/type in possible_gifts)
		if(!is_blacklisted(type, present.blacklist))
			filtered += type

	if(!length(filtered))
		return null

	return pick(filtered)

/obj/item/gift/mostly_anything/proc/is_blacklisted(typepath, list/blacklist)
	for(var/blacklisted_type in blacklist)
		if(ispath(typepath, blacklisted_type))
			return TRUE
	return FALSE

/// The actual blacklist for the admin/debug gear. It goes at the bottom as it may end up getting quite long.
/obj/item/gift/mostly_anything
	var/static/list/blacklist = list(
		/datum/storage/box/debug,
		/obj/item/uplink,
		/obj/item/clothing/ears/earmuffs/debug,
		/obj/item/gps/visible_debug,
		/obj/item/clothing/glasses/meson/engine/admin,
		/obj/item/storage/bag/sheetsnatcher/debug,
		/obj/item/construction/rcd/combat/admin,
		/obj/item/disk/tech_disk/debug,
		/obj/item/flashlight/emp/debug,
		/obj/item/card/id/advanced/debug,
		/obj/item/debug/omnitool/item_spawner,
		/obj/item/borg/projectile_dampen/debug,
		/obj/item/clothing/glasses/debug,
		/obj/item/gun/magic/wand/resurrection/debug,
		/obj/item/mod/control/pre_equipped/administrative,
		/obj/item/mod/control/pre_equipped/debug,
		/obj/item/mod/control/pre_equipped/chrono,
		/obj/item/gun/energy/laser/instakill,
		/obj/item/gun/magic/wand/death,
		/obj/item/disk/nuclear,
		/obj/item/melee/energy/axe,
		/obj/item/phystool,
		/obj/item/physic_manipulation_tool/advanced,
		/obj/item/gun/magic/wand/polymorph,
		/obj/item/gun/magic/staff/chaos,
		/obj/item/gun/energy/pulse,
		/obj/item/dna_probe/carp_scanner,
		/obj/item/antag_granter,
		/obj/item/storage/box/syndie_kit/romerol,
		/obj/item/reagent_containers/cup/bottle/romerol,
		/obj/item/card/emag/battlecruiser,
		/obj/structure/fluff/paper, // So I stop getting 500 papers
		/obj/item/circuitboard, // Like above but for boards.
		/obj/item/circuit_component, // I hate these things.
	)
