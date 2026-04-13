/obj/item/clothing/glasses/hud/eyepatch
	name = "eyepatch HUD"
	desc = "A simple HUD designed to interface with optical nerves of a lost eye. This one seems busted."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	inhand_icon_state = "sunhudmed"
	can_switch_eye = TRUE	//See modular_skyrat\modules\customization\modules\clothing\glasses\glasses.dm
	actions_types = list(/datum/action/item_action/flip)


/obj/item/clothing/glasses/hud/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/eyepatch/med
	name = "medical eyepatch HUD"
	desc = "Do no harm, maybe harm has befell to you, or your poor eyeball, thankfully there's a way to continue your oath, thankfully it didn't mention sleepdarts or monkey men."
	icon_state = "medpatch"
	base_icon_state = "medpatch"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/eyepatch/med/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/medpatch)

/datum/atom_skin/medpatch
	abstract_type = /datum/atom_skin/medpatch

/datum/atom_skin/medpatch/eyepatch
	preview_name = "Eyepatch"
	new_icon_state = "medpatch"

/datum/atom_skin/medpatch/fake_blindfold
	preview_name = "Fake Blindfold"
	new_icon_state = "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson
	name = "mesons eyepatch HUD"
	desc = "For those that only want to go half insane when staring at the supermatter."
	icon_state = "mesonpatch"
	base_icon_state = "mesonpatch"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	vision_flags = SEE_TURFS
	color_cutoffs = list(5, 15, 5)
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/hud/eyepatch/meson/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mesonpatch)

/datum/atom_skin/mesonpatch
	abstract_type = /datum/atom_skin/mesonpatch

/datum/atom_skin/mesonpatch/eyepatch
	preview_name = "Eyepatch"
	new_icon_state = "mesonpatch"

/datum/atom_skin/mesonpatch/fake_blindfold
	preview_name = "Fake Blindfold"
	new_icon_state = "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic
	name = "diagnostic eyepatch HUD"
	desc = "Lost your eyeball to a rogue borg? Dare to tell a Dogborg to do it's job? Got bored? Whatever the reason, this bit of tech will help you still repair borgs, they'll never need it since they usually do it themselves, but its the thought that counts."
	icon_state = "robopatch"
	base_icon_state = "robopatch"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/robopatch)

/datum/atom_skin/robopatch
	abstract_type = /datum/atom_skin/robopatch

/datum/atom_skin/robopatch/eyepatch
	preview_name = "Eyepatch"
	new_icon_state = "robopatch"

/datum/atom_skin/robopatch/fake_blindfold
	preview_name = "Fake Blindfold"
	new_icon_state = "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci
	name = "science eyepatch HUD"
	desc = "Every few years, the aspiring mad scientist says to themselves 'I've got the castle, the evil laugh and equipment, but what I need is a look', thankfully, Dr. Galox has already covered that for you dear friend - while it doesn't do much beyond scan chemicals, what it lacks in use it makes up for in style."
	icon_state = "scipatch"
	base_icon_state = "scipatch"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

/obj/item/clothing/glasses/hud/eyepatch/sci/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/scipatch)

/datum/atom_skin/scipatch
	abstract_type = /datum/atom_skin/scipatch

/datum/atom_skin/scipatch/eyepatch
	preview_name = "Eyepatch"
	new_icon_state = "scipatch"

/datum/atom_skin/scipatch/fake_blindfold
	preview_name = "Fake Blindfold"
	new_icon_state = "scifold"

/// BLINDFOLD HUDS ///
/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "obsolete fake blindfold"
	desc = "An ornate fake blindfold, devoid of any electronics. It's belived to be originally worn by members of bygone military force that sought to protect humanity."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	base_icon_state = "obsoletefold"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/hud/eyepatch/med/blindfold
	name = "medical blindfold HUD"
	desc = "a fake blindfold with a medical HUD inside, great for helping keep a poker face when dealing with patients."
	icon_state =  "medfold"
	base_icon_state =  "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold
	name = "meson blindfold HUD"
	desc = "a fake blindfold with meson lenses inside. Doesn't shield against welding."
	icon_state =  "mesonfold"
	base_icon_state =  "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold
	name = "diagnostic blindfold HUD"
	desc = "a fake blindfold with a diagnostic HUD inside, excellent for working on androids."
	icon_state =  "robofold"
	base_icon_state =  "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold
	name = "science blindfold HUD"
	desc = "a fake blindfold with a science HUD inside, provides a way to get used to blindfolds before you eventually end up needing the real thing."
	icon_state =  "scifold"
	base_icon_state =  "scifold"
