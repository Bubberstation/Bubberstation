/obj/item/scrap
	name = "generic scrap item"
	desc = "Some coder's bane; and YOUR profit!"
	icon = 'local/icons/obj/scrap.dmi'
	lefthand_file = 'local/icons/mob/inhands/scrap_lefthand.dmi'
	righthand_file = 'local/icons/mob/inhands/scrap_righthand.dmi'
	/// The amount of money this item'll be worth when sold. Randomized.
	/// This could probably be componentized to allow for more variety of scrap items but it's not a priority
	/// Unless you like; really want to make a shitty gun or something for this
	var/credit_cost = CARGO_CRATE_VALUE * 0.25

/obj/item/scrap/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_RESEARCH_SCANNER) || isdead(user))
		. += span_notice("It's worth [credit_cost] credits.")

/obj/item/scrap/Initialize(mapload)
	. = ..()
	credit_cost = randomize_credit_cost()

/obj/item/scrap/proc/randomize_credit_cost()
	return rand(1, 210)

// Cargo Export Datum //

/datum/export/scrap
	unit_name = "scrap"

/datum/export/stack/get_amount(obj/O)
	var/obj/item/scrap/S = O
	if(istype(S))
		return S.credit_cost
	return 0

// Spawner //

/obj/effect/spawner/random/scrap_spawner
	name = "scrap spawner"
	icon_state = "crushed_can"
	loot_subtype_path = /obj/item/scrap
	loot = list()

/obj/effect/spawner/random/scrap_spawner/two
	spawn_loot_count = 2

/obj/effect/spawner/random/scrap_spawner/four
	spawn_loot_count = 4
