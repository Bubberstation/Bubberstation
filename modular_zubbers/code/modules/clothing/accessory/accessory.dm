/obj/item/clothing/accessory/pocketwatch
	name = "pocket watch"
	desc = "A fancy gold pocket watch, inspired by the popular Uair brand of Carota. Open me, you fool. Open the light and summon me and receive my majesty."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/pocketwatch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Speak with a hypnotic whisper", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)


/obj/item/clothing/accessory/pocketwatch/examine(mob/user)
	. = ..()
	. += span_info("The current CST (local) time is: [station_time_timestamp()].")
	. += span_info("The current TCT (galactic) time is: [time2text(world.realtime, "hh:mm:ss")].")

/obj/item/storage/backpack/kanken //Donor item for LT3
	name = "kånken backpack"
	desc = "Classic Swedish design in hard-wearing vinylon fabric with a zip that opens the entire main compartment. Featuring a small front pocket, simple shoulder straps and handles at the top, it's made for a lifetime of use."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	icon_state = "technician"
	inhand_icon_state = "technician"

/obj/item/clothing/accessory/fake/medal
	name = "plastic medal"
	desc = "Yeah nice try buddy. They won't record this one. Especially since it reads 'youre winnar!!'. Alt-Click to reskin!"
	unique_reskin = list(
			"Bronze" = "bronze",
			"Bronze Heart" = "bronze_heart",
			"Silver" = "silver",
			"Gold" = "gold",
			"Plasma" = "plasma",
			"Cargo" = "cargo",
			"Paperwork" = "medal_paperwork",
			"Medical Second Class" = "med_medal",
			"Medical First Class" = "med_medal2",
			"Atmosian" = "elderatmosian",
			"Emergency Service - General" = "emergencyservices",
			"Emergency Service - Engineering" = "emergencyservices_engi",
			"Emergency Service - Medical" = "emergencyservices_med"
	)
// Pride Pin Over-ride
/obj/item/clothing/accessory/pride
    icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
    worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

    unique_reskin  = list(
    "Rainbow Pride" = "pride",
    "Bisexual Pride" = "pride_bi",
    "Pansexual Pride" = "pride_pan",
    "Asexual Pride" = "pride_ace",
    "Non-binary Pride" = "pride_enby",
    "Transgender Pride" = "pride_trans",
    "Intersex Pride" = "pride_intersex",
    "Lesbian Pride" = "pride_lesbian",
    "Man-Loving-Man / Gay Pride" = "pride_mlm",
    "Genderfluid Pride" = "pride_genderfluid",
    "Genderqueer Pride" = "pride_genderqueer",
    "Aromantic Pride" = "pride_aromantic",
)
