/obj/item/weaponcrafting/gunkit/wt550_burst
	name = "WT-550 burst-fire modification parts kit"
	desc = "A suitcase containing the necessary gun parts to modify a WT-550 into a burst-fire assault weapon."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/item/weaponcrafting/gunkit/wt550_long
	name = "WT-550 long range operations parts kit"
	desc = "A suitcase containing the necessary gun parts to construct a long range WT-550. Contains a long barrel, scope, and modified frame."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
	)

/obj/item/weaponcrafting/gunkit/simple_battle_rifle
	name = "NT-38 battle rifle simplification kit"
	desc = "A suitcase containing the necessary gun parts to remove the advanced electronics and acceleration technology from a NT-38 battle rifle, reducing performance but maximizing reliability."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
	)

/obj/item/weaponcrafting/gunkit/regal_condor
	name = "unnamed weapon parts case (viciously lethal)"
	desc = "A suitcase containing the necessary gun parts to assemble a very powerful handgun. The case itself has a foreboding aura to it."
	icon = 'modular_zubbers/icons/obj/weapons/improvised.dmi'
	icon_state = "syndikitsuitcase"

/obj/item/weaponcrafting/juggernaut_suit
	name = "advanced security suit armor plates"
	desc = "A set of incredibly dense armor plates for use in constructing the advanced security suit."
	icon = 'modular_zubbers/icons/obj/weapons/improvised.dmi'
	icon_state = "jugg_plates"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = SLOWS_WHILE_IN_HAND
	slowdown = 3
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 40,
	)
