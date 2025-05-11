/datum/crafting_recipe/drakecloak_bleached
	name = "Bleached Ash Drake Armour"
	result = /obj/item/clothing/suit/hooded/cloak/drake/bleached
	reqs = list(/obj/item/clothing/suit/hooded/cloak/drake = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/bonesuit_bleached
	name = "Bleached Bone Armor"
	result = /obj/item/clothing/suit/armor/bone/bleached
	reqs = list(/obj/item/clothing/suit/armor/bone = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/skullhelm_bleached
	name = "Bleached Skull"
	result = /obj/item/clothing/head/helmet/skull/bleached
	reqs = list(/obj/item/clothing/head/helmet/skull = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/drakecloak_ochre
	name = "Ochre Ash Drake Armour"
	result = /obj/item/clothing/suit/hooded/cloak/drake
	reqs = list(/obj/item/clothing/suit/hooded/cloak/drake/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/bonesuit_ochre
	name = "ochre Bone Armor"
	result = /obj/item/clothing/suit/armor/bone
	reqs = list(/obj/item/clothing/suit/armor/bone/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/skullhelm_ochre
	name = "Ochre Skull"
	result = /obj/item/clothing/head/helmet/skull
	reqs = list(/obj/item/clothing/head/helmet/skull/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/modulator_gasmask
	name = "Voice Modulator Gasmask"
	result = /obj/item/clothing/mask/gas/modulator
	reqs = list(/obj/item/clothing/mask/gas = 1,
				/obj/item/assembly/voice = 1,
				/obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_MULTITOOL)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/modulator_gasmask/New()
	..()
	blacklist += subtypesof(/obj/item/clothing/mask/gas)

/datum/crafting_recipe/berserker_reskin
	name = "Marked One Grafting"
	result = /obj/item/clothing/suit/hooded/berserker/gladiator
	reqs = list(/obj/item/clothing/suit/hooded/berserker = 1,
				/obj/item/stack/ore/glass/basalt = 5,
				/obj/item/stack/ore/titanium =5)
	time = 5 SECONDS
	category = CAT_CLOTHING
