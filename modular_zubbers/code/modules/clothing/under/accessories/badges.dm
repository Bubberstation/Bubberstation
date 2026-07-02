/obj/item/clothing/accessory/dogtag/unique_blood
	name = "Blood dogtag"
	desc = "A dogtag with a listing of blood properties."

/obj/item/clothing/accessory/dogtag/unique_blood/Initialize(mapload, blood_type, color_string)
	. = ..()
	if(color_string && blood_type)
		display = span_notice("\"Hi! My blood is [blood_type] despite being [color_string]!\"")
	else
		display = span_notice("The dogtag is all scratched up.")

/obj/item/clothing/accessory/medal/gold/
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/accessories_teshari.dmi'
