/datum/way_destination
	abstract_type = /datum/way_destination
	var/name
	var/desc
	/// Displayed on examine by a non-heretic, alongst a lot of brain damage. Starts with YOU CATCH A GLIMPSE: and ends with --!!!
	var/glimpse
	var/glimpse_heretic
	/// Displayed when the way opens fully.
	var/spawn_text

/datum/way_destination/proc/open(obj/effect/unopened_way/way, mob/living/opener)
	return

/datum/way_destination/proc/get_spawn_turfs(obj/effect/unopened_way/way, range = 1)
	RETURN_TYPE(/list/turf)

	var/list/turf/turfs = list()

	turfs += get_turf(way)

	for(var/turf/nearby_turf in oview(1, get_turf(way))) // oview, since we always add our loc to the list
		if(!nearby_turf.is_blocked_turf())
			turfs += nearby_turf

	return turfs

#define REAGENT_AMOUNT 5000

/datum/way_destination/chemical_spill
	name = "The Sea of Dreams"
	desc = "When the Bleeding King was cast down by the Gods-From-Steel, it fell to a field of yawning caverns and laid-to-dead. It continued to dream, dream, \
	its blood filling the caverns and air and eventually forming a kaleidoescopic, wintery sea of whatever you can imagine..."
	glimpse = "A YAWNING ABYSS OF WAVES AND WATER AND BLOOD AND ALGAE AND DEATH AND LIFE"
	glimpse_heretic = "The Bleeding King lies before you, eyes devoured by worms. A misty, multi-color sea lies between the way and the dead god, rays of the Light burning through..."
	spawn_text = "a torrent of liquid ejecting from it!"
	var/static/list/spawnable_chemicals = list(
		// desirable
		/datum/reagent/medicine/omnizine = 300,
		/datum/reagent/medicine/albuterol = 200,
		/datum/reagent/medicine/coagulant = 200,
		/datum/reagent/medicine/oxandrolone = 200,
		/datum/reagent/toxin/formaldehyde = 200,
		/datum/reagent/medicine/cordiolis_hepatico = 100,
		/datum/reagent/medicine/dermagen = 5,
		/datum/reagent/medicine/c2/penthrite = 200,
		/datum/reagent/drug/bath_salts = 200,
		/datum/reagent/drug/kronkaine = 200,
		/datum/reagent/drug/twitch = 50,
		/datum/reagent/drug/demoneye = 50,
		// neutral
		/datum/reagent/blood = 100,
		// bad
		/datum/reagent/lube/superlube = 50,
		/datum/reagent/lube = 200,
		/datum/reagent/ants/fire = 200, // OH GOD THE ANTS
		/datum/reagent/toxin/tetrodotoxin = 20,
		/datum/reagent/toxin/spore_burning = 5,
		/datum/reagent/phlogiston = 200,
		/datum/reagent/toxin/chloralhydrate = 200,
	)

/datum/way_destination/chemical_spill/open(obj/effect/unopened_way/way, mob/living/opener)
	var/datum/reagents/tempr = new(10000)
	tempr.add_reagent(pick_weight(spawnable_chemicals), REAGENT_AMOUNT)
	var/turf/our_turf = get_turf(way)
	our_turf.add_liquid_from_reagents(tempr, FALSE)

#undef REAGENT_AMOUNT

#define MOLS_TO_SPAWN 4000

/datum/way_destination/atmosphere
	name = "The Clouds"
	desc = "Little dares to tread the skies of the Mansus. There is little there, and what is found is quickly swept away by the Light, searing and burning. \
	And yet, in one corner, outside of the eyes of even the Owl, lies a cluster of clouds of gasses both foreign and native to the mortal and nighttime planes."
	glimpse = "A MISTY EXPANSE OF GREENREDBLUEWHITEPATTERNSZEBRASLIGHTAND DARK AND"
	glimpse_heretic = "The Light catarizes the mist before you, creating a eldritch lightshow entrancing only to you."
	spawn_text = "a whirlwind of multicolored clouds ejecting from it!"
	var/static/list/spawnable_gasses = list(
		// neutral/slightly negative
		/datum/gas/nitrous_oxide = 50,
		/datum/gas/bz = 50,
		// desirable
		/datum/gas/healium = 500,
		/datum/gas/goblin = 10, // rare asf
		/datum/gas/hypernoblium = 200,
		/datum/gas/freon = 300,
		/datum/gas/pluoxium = 300,
		/datum/gas/nitrium = 200,
		// downright bad
		/datum/gas/zauker = 300,
		/datum/gas/miasma = 400,
		/datum/gas/carbon_dioxide = 100,
	)

/datum/way_destination/atmosphere/open(obj/effect/unopened_way/way, mob/living/opener)
	var/datum/gas/picked_gas = pick_weight(spawnable_gasses)
	var/list/turf/turfs = RANGE_TURFS(1, get_turf(way))
	for (var/turf/iter_turf as anything in turfs)
		iter_turf.atmos_spawn_air("[picked_gas.id]=[MOLS_TO_SPAWN]")

#undef MOLS_TO_SPAWN

/datum/way_destination/flesh_organs
	name = "The Butchery"
	desc = "Deep in the woods, hidden by thick underbrush, is a factory producing only the finest cuts of meat in the Mansus. Those with a certain taste \
	find themselves travelling to this alcove to satisfy their more sinful tastes, and maybe pick up an extra arm or two on the way. Under the domain \
	of the brutal god-from-steel Skinweaver, spirits and other malevolent forces often stay far away."
	glimpse = "OH GOD! OH GOD!! SO MUCH BLOOD!! MEAT!! ORGANS!! EYES!! HUNG ON MEAT HOOKS!! I'M NEXT!! I'M NEXT"
	glimpse_heretic = "A smiling butcher faces the now-open way, beckoning you closer. Its flesh-soaked cleaver shines in the Light, \
	waiting to permeate your flesh and turn you into a divine meal..."
	spawn_text = "a flurry of grotesque meat, viscera, and organs ejecting from it!"
	var/static/list/potential_mob_spawns = list(
		/mob/living/basic/heretic_summon/raw_prophet/ruins = 50,
	)
	var/static/list/potential_organ_spawns = list(
		/obj/item/organ/heart/evolved = 100,
		/obj/item/organ/liver/evolved = 100,
		/obj/item/organ/lungs/evolved = 100,
		/obj/item/organ/stomach/evolved = 100,
		/obj/item/organ/ears/babbelfish = 10,
		/obj/item/organ/stomach/alien = 10,
		/obj/item/organ/eyes/alien = 10,
	)
	var/static/mobs_to_spawn = 6
	var/static/organs_to_spawn = 4

/datum/way_destination/flesh_organs/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	new /obj/effect/gibspawner/generic(get_turf(way))
	new /obj/effect/gibspawner/generic(get_turf(way))
	new /obj/effect/gibspawner/generic(get_turf(way))

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/mob/living/basic/heretic_summon/typepath = pick_weight(potential_mob_spawns)
		var/mob/living/monster = new typepath(pick(potential_locations))
		monster.faction = FACTION_HERETIC_WILD

	var/to_spawn_organs = organs_to_spawn
	while (to_spawn_organs-- > 0)
		var/obj/item/organ/typepath = pick(potential_organ_spawns)
		new typepath(get_turf(way))

/datum/way_destination/knowledgebooks
	name = "The Ascendant Conservatorium"
	desc = "Far, far high in the peaks of the Mansus, past the mountain of blades and the wormfeast, lies the forgotten and mind-forgettable \
	conservatorium. Knowledge of all kinds is gathered here by spider-spirits, to be sealed away and never read. Any interloper foolish \
	enough to trespass is immediately assailed by mirror-fiends, and those who walk too loud are snuffed out by the Watchwoman."
	glimpse = "KNOWLEDGEKNOWLEDGEKNOWLEDGEKNWO%@LE^%%&%&%!%&^^!$$!"
	glimpse_heretic = "A infinite torrent of knowledge flies through the gap in the veil, nearly blinding you with the sheer volume. You can't make \
	heads or tails of it... but the Light is everpresent, even here."
	spawn_text = "a torrent of raw knowledge and its guardians ejecting from it!"
	var/static/list/potential_book_spawns = list(
		/obj/item/book/granter/crafting_recipe/death_sandwich = 500,
		/obj/item/book/granter/crafting_recipe/trash_cannon = 500,
		/obj/item/book/granter/crafting_recipe/boneyard_notes = 500,
		/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 500,
		/obj/item/book/granter/crafting_recipe/dusting/laser_musket_prime = 500,
		/obj/item/book/granter/crafting_recipe/dusting/pipegun_prime = 500,
		/obj/item/book/granter/crafting_recipe/dusting/smoothbore_disabler_prime = 500,
		/obj/item/book/granter/crafting_recipe/fletching = 200,
		/obj/item/book/granter/crafting_recipe/donk_secret_recipe = 200,
		/obj/item/book/granter/crafting_recipe/regal_condor = 1,
	)
	var/static/mobs_to_spawn = 4
	var/static/books_to_spawn = 4
	var/static/cooling = 500

/datum/way_destination/knowledgebooks/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/mob/living/maid = new /mob/living/basic/heretic_summon/maid_in_the_mirror(pick(potential_locations))
		maid.faction = FACTION_HERETIC_WILD

	var/to_spawn_organs = books_to_spawn
	while (to_spawn_organs-- > 0)
		var/obj/typepath = pick_weight(potential_book_spawns)
		new typepath(pick(potential_locations))

	for (var/turf/target_turf as anything in potential_locations)
		var/datum/gas_mixture/enviro = target_turf.return_air()
		enviro.temperature = max(enviro.temperature - cooling, 10)
		target_turf.air_update_turf(FALSE, FALSE)

/datum/way_destination/clown_planet
	name = "The Clown Abyss"
	desc = "Deep, deep, deep, in nowhere, in the abyss, beneath the eyes of the living gods, beneath anyone and anything's perception---rests a \
	dead god. Deader, colder than anything known to man and unman. Surrounded by darkness, yellow-orange, and its eternal, undying guards, rests \
	a god of no name. Of no repute. Its only legacy... is... HONK."
	glimpse = "HOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONK"
	glimpse_heretic = "The titan-god lies before you, surrounded by its corrupt gold and guardians. They stare at you, forming a wall between \
	this thin, unwelcome incursion and their charge. There is no Light here. There was never Light here. A shiver runs down your spine as you gaze \
	into the abyss."
	spawn_text = "an ear-splitting honk paving the way for an ejection of strange gold metal and gold-clad guardians!"
	var/static/clowns_to_spawn = 6
	var/static/bananium_sheet_size = 20

/datum/way_destination/clown_planet/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = clowns_to_spawn
	while (to_spawn-- > 0)
		new /mob/living/basic/clown/clownhulk/destroyer(pick(potential_locations))

	new /obj/item/stack/sheet/mineral/bananium(get_turf(way), bananium_sheet_size)

	for(var/mob/living/honk_victim in hearers(6, way))
		if(issilicon(honk_victim))
			continue
		var/turf/victim_turf = get_turf(honk_victim)
		if(isspaceturf(victim_turf) && !victim_turf.Adjacent(way)) //Prevents getting honked in space
			continue
		if(honk_victim.soundbang_act(SOUNDBANG_NORMAL, stun_pwr = 5, damage_pwr = 15, deafen_pwr = 30)) //Ear protection will prevent these effects
			honk_victim.set_jitter_if_lower(120 SECONDS)
			to_chat(honk_victim, span_clown("HOOOOONK!"))

/datum/way_destination/anomalies
	name = "The Chaossphere"
	desc = "Deep in the mansus, past the bone-gates, behind the mueseum of glass, lies a ethereal dome of everchanging conditions. \
	Even the laws of the Mansus bend and shift in the incomprehensible chaos under the dome, bred by the Skinweaver for its own purposes. Only \
	the native and the ascended have passed through the dome and come out unscathed. And yet few wish to speak of it."
	glimpse = "YOUCANTMAKEOUTWHATYOURESEEINGYOUCANTMAKEITOUTYOUCANT*DESCRIBE*ITYOUCANTYOUCANTYOU" // yeah its utterly incomprehensible
	glimpse_heretic = "Even for a mind as trained as your own, casting your gaze into the thin way into the chaos-dome is painful. And yet - through \
	the shifting tides of chaos, thousands, thousands of universes, you catch a glimpse of it. The Light."
	spawn_text = "a pinch of chaos escaping the way before it finally shuts for good!"
	var/static/list/spawnable_anomalies = list(
		/obj/effect/anomaly/pyro = 500,
		/obj/effect/anomaly/hallucination = 500,
		/obj/effect/anomaly/dimensional = 500,
		/obj/effect/anomaly/bluespace = 300,
		/obj/effect/anomaly/ectoplasm = 200,
		/obj/effect/anomaly/bioscrambler = 100,
		/obj/effect/anomaly/flux = 50,
		/obj/effect/anomaly/bhole = 1
	)
	var/static/anomalies_to_spawn = 4

/datum/way_destination/anomalies/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = anomalies_to_spawn
	while (to_spawn-- > 0)
		var/obj/effect/anomaly/typepath = pick_weight(spawnable_anomalies)
		new typepath(pick(potential_locations), 50 SECONDS)

// bad destinations - no benefit

/datum/way_destination/heretic_mobs
	name = "The Monstersmith"
	desc = "Property of a long-dead god, the monstersmith continues its solemn duty under the charge of the new gods-from-steel. Perched \
	on the precipice of an ancient abyss, defective beasts are sent off to be eaten by the ravenous abyss-vultures, while the rest are \
	employed in a forver war - the purpose of which nobody, dead or alive, remembers."
	glimpse = "THOUSANDS OF BEASTS AND TOOLS AND MEAT AND BONE! HORRIBLE CREATURES OF RUST AND BRAIN MATTER"
	glimpse_heretic = "A vast expanse of regimented ogres, beasts, bone-ghouls expands before you, exposing thousands or millions of \
	terrible monsters. In the distance, Light-shining god-steel tools get to work repurposing the flesh of recently deceased into these monstrosities. \
	The work will continue."
	spawn_text = "a torrent of horrible beasts and monsters escaping from it before it fully shuts!"
	var/static/list/potential_mob_spawns = list(
		/mob/living/basic/heretic_summon/raw_prophet/ruins = 50,
		/mob/living/basic/heretic_summon/ash_spirit = 50,
		/mob/living/basic/heretic_summon/maid_in_the_mirror = 50,
		/mob/living/basic/heretic_summon/rust_walker = 50,
		/mob/living/basic/heretic_summon/fire_shark = 50,
		/mob/living/basic/heretic_summon/stalker = 5,
	)
	var/static/mobs_to_spawn = 7

/datum/way_destination/heretic_mobs/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/obj/effect/anomaly/typepath = pick_weight(potential_mob_spawns)
		var/mob/living/monster = new typepath(pick(potential_locations))
		monster.faction = FACTION_HERETIC_WILD

/datum/way_destination/emp
	name = "The Soulstorm"
	desc = "Those that miss the bone-gates and find themselves lost in the mansus may alternately find this maelstrom of eldritch energy. \
	Under the patronage of the Aristocrat, the soulstorm is a manifestation of despair, dread, and the soul-void of these poor souls that were lost. \
	Exceedingly dangerous. This way may not remain safe for long."
	glimpse = "PURPLE MAELSTROMS OF SCREAMING AND LIGHTING AND AN EVERGROWING PRESENCE"
	glimpse_heretic = "It's hard to look. Screaming, agonizing souls swirl in infinite circles, contorting and writing in every way imaginable. \
	In the background, the void smiles."
	spawn_text = "and just before it closes fully a strand from the soulstorm itself strikes the way, unleashing horrible energies!"

/datum/way_destination/emp/open(obj/effect/unopened_way/way, mob/living/opener)
	empulse(get_turf(way), 3, 12, emp_source = way)
