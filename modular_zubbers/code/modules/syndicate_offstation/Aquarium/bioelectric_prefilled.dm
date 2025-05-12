//Bioelectric prefileld aquarium for Persistence

/obj/structure/aquarium/bioelec_gen/prefilled
	anchored = TRUE

/obj/structure/aquarium/bioelec_gen/prefilled/Initialize(mapload)
	. = ..()

	new /obj/item/aquarium_prop/sand(src)
	new /obj/item/aquarium_prop/seaweed(src)

	//They should last a whole shift with this much food unless
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 25)

/obj/item/fish/jumpercable/karl
	name = "Karl"
	desc = "A deadly syndicate monojumper cable saved from the horrors of Nanotrasen by the animal rights consortium. Its been given a new home as a power source for syndicate operations!"
	stable_population = 4
	random_case_rarity = FISH_RARITY_NOPE
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	fish_id_redirect_path = /obj/item/fish/jumpercable
	beauty = FISH_BEAUTY_GOOD
	compatible_types = list(/obj/item/fish/jumpercable, /obj/item/fish/jumpercable)

/obj/item/fish/jumpercable/karl/carl
	name = "Carl"

/obj/item/fish/jumpercable/karl/carly
	name = "Carly"

	compatible_types = list(/obj/item/fish/jumpercable, /obj/item/fish/jumpercable)

/obj/item/fish/jumpercable/karl/frank
	name = "Frank"


/obj/item/storage/fish_case/syndicate/persistence
	name = "ominous fish case"

/obj/item/storage/fish_case/syndicate/get_fish_type()
	return pick(/obj/item/fish/jumpercable/karl/frank, /obj/item/fish/jumpercable/karl/carly, /obj/item/fish/jumpercable/karl/carl, /obj/item/fish/jumpercable/karl)
