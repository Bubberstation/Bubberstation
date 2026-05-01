/datum/augment_item/implant
	category = AUGMENT_CATEGORY_IMPLANTS

/datum/augment_item/implant/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return
	var/obj/item/organ/new_organ = new path()
	new_organ.Insert(H,FALSE,FALSE)

//BRAIN IMPLANTS
/datum/augment_item/implant/brain
	slot = AUGMENT_SLOT_BRAIN_IMPLANT

//CHEST IMPLANTS
/datum/augment_item/implant/chest
	slot = AUGMENT_SLOT_CHEST_IMPLANT

/datum/augment_item/implant/chest/wound_scanner
	name = "Chest Internal Wound Analyzer"
	cost = 1
	path = /obj/item/organ/cyberimp/chest/wound_scanner

/datum/augment_item/implant/chest/nutrimentpump
	name = "Standard Nutriment Pump" // The STANDARD pump. Only gets you to 35% nutrition. You still need to eat ACTUAL food to be rid of the negative moodlet
	cost = 2
	path = /obj/item/organ/cyberimp/chest/nutriment

//LEFT ARM IMPLANTS
/datum/augment_item/implant/l_arm
	slot = AUGMENT_SLOT_LEFT_ARM_IMPLANT

/datum/augment_item/implant/l_arm/power_cord
	name = "Left Synth Charging Implant"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/left_arm

/datum/augment_item/implant/l_arm/razor_claws
	name = "Left Razor Claws"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm

/datum/augment_item/implant/l_arm/rope
	name = "Left Climbing Hook"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/rope/left_arm

/datum/augment_item/implant/l_arm/toolkit/lighter
	name = "Left Lighter Implant"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/lighter/left_arm

/datum/augment_item/implant/l_arm/toolkit/seclite
	name = "Left Arm Seclite"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/seclite/left_arm

/datum/augment_item/implant/l_arm/toolkit/penfour
	name = "Left Four Color Pen"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/penfour/left_arm

/datum/augment_item/implant/l_arm/toolkit/tape_recorder
	name = "Left Tape Recorder"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/tape_recorder/left_arm

//RIGHT ARM IMPLANTS
/datum/augment_item/implant/r_arm
	slot = AUGMENT_SLOT_RIGHT_ARM_IMPLANT

/datum/augment_item/implant/r_arm/power_cord
	name = "Right Synth Charging Implant"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/right_arm

/datum/augment_item/implant/r_arm/razor_claws
	name = "Right Razor Claws"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm

/datum/augment_item/implant/r_arm/rope
	name = "Right Climbing Hook"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/rope/right_arm

/datum/augment_item/implant/r_arm/toolkit/lighter
	name = "Right Lighter Implant"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/lighter/right_arm

/datum/augment_item/implant/r_arm/toolkit/seclite
	name = "Right Arm Seclite"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/seclite/right_arm

/datum/augment_item/implant/r_arm/toolkit/penfour
	name = "Right Four Color Pen"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/penfour/right_arm

/datum/augment_item/implant/r_arm/toolkit/tape_recorder
	name = "Right Tape Recorder"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/tape_recorder/right_arm

//EYES IMPLANTS
/datum/augment_item/implant/eyes
	slot = AUGMENT_SLOT_EYES_IMPLANT

/datum/augment_item/implant/eyes/civhud
	name = "Civilian HUD Implant"
	cost = 2
	path = /obj/item/organ/cyberimp/eyes/hud/civilian

/datum/augment_item/implant/eyes/civhudinvis
	name = "Civilian HUD Implant (Invisible)"
	cost = 2
	path = /obj/item/organ/cyberimp/eyes/hud/civilian/invisible

//MOUTH IMPLANTS
/datum/augment_item/implant/mouth
	slot = AUGMENT_SLOT_MOUTH_IMPLANT

/datum/augment_item/implant/mouth/breathing_tube
	name = "Breathing Tube"
	cost = 2
	path = /obj/item/organ/cyberimp/mouth/breathing_tube
