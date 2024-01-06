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

/obj/item/organ/internal/tongue/cat/tajaran
	name = "tajaran tongue"

//Tajara have the innate ability to see in the dark better than most
/obj/item/organ/internal/eyes/tajaran
	name = "tajaran eyes"
	desc = "they seem very cat like."
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE + -2 //Four flashes
	color_cutoffs = list(12, 7, 7)
