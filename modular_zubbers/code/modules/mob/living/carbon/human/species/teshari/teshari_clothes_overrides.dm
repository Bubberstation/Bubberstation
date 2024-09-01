/obj/item/storage/backpack/satchel
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/back.dmi'

/obj/item/storage/backpack/duffelbag
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/back.dmi'

/obj/item/clothing/suit/hooded/wintercoat/equipped(mob/living/user, slot)
	var/mob/living/carbon/human/teshari = user
	if(teshari.dna.species.name == "Teshari")
		var/datum/component/toggle_attached_clothing/component = src.GetComponent(/datum/component/toggle_attached_clothing)
		component.down_overlay_state_suffix = null
		component.undeployed_overlay = null
	. = ..()

