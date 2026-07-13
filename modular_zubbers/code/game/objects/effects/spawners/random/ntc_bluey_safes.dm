//Some of the fluff that can spawn in there
/obj/item/paperwork/ntc
	name = "Internal Affairs records"
	desc = "A densely compiled stack of Internal Affairs records, documenting various investigations, audits and disciplinary proceedings, extensively redacted under the authority of Central Command."

/obj/item/paperwork/blueshield
	name = "Asset Protection case records"
	desc = "A messily compiled stack of DAP records, containing incident reports, asset recovery briefings and classified paramilitary activities, with substantial portions censored and redacted. You probably shouldn't be reading this, unless you yearn for a one-way trip to Space Guantanamo."

/obj/item/reagent_containers/cup/glass/trophy
	name = "Redshield 1st Prize"
	desc = "You did good in the worst way possible."

/obj/item/toy/plush/skyrat/fox/mia/vigilant
	name = "Vigilant the Fox Plushie"
	desc = "A cute, marketable version of one of the DAP's mascots, Vigilant the Fox. She has a blue collar with a shield-shaped tag that reads DAP. Holding her makes you feel protected."

/obj/effect/spawner/random/loot/dignitary
	desc = "Glory to Nanotrasen!"
	var/spawn_additional_loot_chance = 100
	var/list/additional_loot

/obj/effect/spawner/random/loot/dignitary/Initialize(mapload)
	. = ..()
	if(additional_loot?.len && prob(spawn_additional_loot_chance))
		var/loot_to_spawn = pick_weight_recursive(additional_loot)
		var/atom/movable/spawned_loot = make_item(loc, loot_to_spawn)
		spawned_loot.setDir(dir)

/obj/effect/spawner/random/loot/dignitary/consultant
	name = "nanotrasen consultant safe spawner"
	loot = null
	additional_loot = list(
		/obj/structure/safe/abovetilefloor = 1
	)

/obj/effect/spawner/random/loot/dignitary/consultant/Initialize(mapload)
	loot = list(
		/obj/item/lighter/royal = 1,
		/obj/item/coin/antagtoken = 1,
		/obj/item/coin/gold = 1,
		/obj/item/toy/plush/slimeplushie = 1,
		/obj/item/megaphone/command = 1,
		/obj/item/book/manual/wiki/security_space_law = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 1,
		/obj/item/toy/plush/carpplushie = 1,
		/obj/item/pizzabox/margherita = 1,
		/obj/item/pizzabox/meat = 1,
		/obj/item/reagent_containers/cup/glass/bottle/applejack = 1,
		/obj/item/reagent_containers/cup/glass/bottle/lizardwine = 1,
		/obj/item/reagent_containers/cup/glass/bottle/whiskey = 1,
		/obj/item/reagent_containers/cup/glass/bottle/hcider = 1,
		/obj/item/lustwish_discount = 1,
		/obj/item/folder/ancient_paperwork = 1,
		/obj/item/reagent_containers/cup/glass/flask = 1,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/toy/plush/ghoul = 1,
		/obj/item/toy/figure/dsquad = 1,
		/obj/item/bong = 1,
		/obj/item/gun/ballistic/revolver/protector_revolver = 1,
	)
	. = ..()

	var/obj/structure/safe/loot_inside = locate(/obj/structure/safe) in loc
	if(loot_inside)
		for(var/i = 1 to 2)
			var/loot_to_spawn = pick_weight_recursive(loot)
			make_item(loot_inside, loot_to_spawn)

	make_item(loot_inside, /obj/item/paperwork/ntc)

/obj/effect/spawner/random/loot/dignitary/blueshield
	name = "blueshield safe spawner"
	loot = null
	additional_loot = list(
		/obj/structure/safe/abovetilefloor = 1
	)

/obj/effect/spawner/random/loot/dignitary/blueshield/Initialize(mapload)
	loot = list(
		/obj/item/coin/antagtoken = 1,
		/obj/item/coin/gold = 1,
		/obj/item/holocigarette/masvedishcigar = 1,
		/obj/item/megaphone/command = 1,
		/obj/item/toy/plush/horse = 1,
		/obj/item/book/manual/wiki/security_space_law/weighted = 1,
		/obj/item/storage/medkit/emergency = 1,
		/obj/item/storage/fancy/donut_box = 1,
		/obj/item/radio = 1,
		/obj/item/clothing/erp_leash = 1,
		/obj/item/reagent_containers/cup/glass/bottle/lizardwine = 1,
		/obj/item/reagent_containers/cup/glass/bottle/whiskey = 1,
		/obj/item/reagent_containers/cup/glass/bottle/hcider = 1,
		/obj/item/reagent_containers/cup/glass/bottle/vodka = 1,
		/obj/item/reagent_containers/cup/glass/flask = 1,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/toy/figure/dsquad = 1,
		/obj/item/toy/figure/captain = 1,
		/obj/item/toy/figure/syndie = 1,
		/obj/item/toy/plush/skyrat/fox/mia/vigilant = 1,
		/obj/item/reagent_containers/cup/glass/trophy = 1,
	)
	. = ..()

	var/obj/structure/safe/loot_inside = locate(/obj/structure/safe) in loc
	if(loot_inside)
		for(var/i = 1 to 2)
			var/loot_to_spawn = pick_weight_recursive(loot)
			make_item(loot_inside, loot_to_spawn)

	make_item(loot_inside, /obj/item/paperwork/blueshield)
