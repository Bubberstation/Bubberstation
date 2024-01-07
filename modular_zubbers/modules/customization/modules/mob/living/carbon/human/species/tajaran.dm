//Tajaran Bubber edit
//makes them more like Citrp's tajara aka snow cats

/datum/species/tajaran
	mutanteyes = /obj/item/organ/internal/eyes/tajaran
	//Cold resistance
	coldmod = 0.77
	heatmod = 1.15
	bodytemp_normal = BODYTEMP_NORMAL + 5 //Even more cold resistant, even more flammable
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + -20)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + -20)
	ass_image = 'icons/ass/asstajara.png'

/obj/item/organ/internal/tongue/cat/tajaran
	name = "tajaran tongue"

//Tajara have the innate ability to see in the dark better than most
/obj/item/organ/internal/eyes/tajaran
	name = "tajaran eyes"
	desc = "they seem very cat like."
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE //sorry cat gamers it's over
	color_cutoffs = list(12, 7, 7)

/datum/species/tajaran/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Fire weakness",
			SPECIES_PERK_DESC = "Tajara take longer to cool off when set on fire"
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "Bright Lights",
			SPECIES_PERK_DESC = "Tajara need an extra layer of flash protection to protect \
				themselves, such as against security officers or when welding.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "Nightvision",
			SPECIES_PERK_DESC = "Their eyes are adapted to low light, and can see in the dark better than others.",
		),
	)

	return to_add
