/obj/item/organ/cyberimp/arm/toolkit/surgery/cruel
	name = "morbid surgical toolset implant"
	desc = "A set of odd surgical tools hidden behind a concealed panel on the user's arm. These tools seem a bit twisted and unusual, designed more for vivisection or torture."
	icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'
	icon_state = "toolkit_surgical_cruel"
	items_to_create = list(
		/obj/item/retractor/cruel/augment,
		/obj/item/hemostat/cruel/augment,
		/obj/item/cautery/cruel/augment,
		/obj/item/surgicaldrill/cruel/augment,
		/obj/item/scalpel/cruel/augment,
		/obj/item/circular_saw/cruel/augment,
		/obj/item/surgical_drapes,
		/obj/item/bonesetter,
		/obj/item/autopsy_scanner/cruel,
	)

/obj/item/organ/cyberimp/arm/toolkit/surgery/cruel/emagged
	name = "hacked morbid surgical toolset implant"
	desc = "A set of odd surgical tools hidden behind a concealed panel on the user's arm. These tools seem a bit twisted and unusual, designed more for vivisection or torture. This set appears to be tampered with."
	items_to_create = list(
		/obj/item/retractor/cruel/augment,
		/obj/item/hemostat/cruel/augment,
		/obj/item/cautery/cruel/augment,
		/obj/item/surgicaldrill/cruel/augment,
		/obj/item/scalpel/cruel/augment,
		/obj/item/circular_saw/cruel/augment,
		/obj/item/surgical_drapes,
		/obj/item/bonesetter,
		/obj/item/autopsy_scanner/cruel,
		/obj/item/knife/combat/cyborg,
	)

