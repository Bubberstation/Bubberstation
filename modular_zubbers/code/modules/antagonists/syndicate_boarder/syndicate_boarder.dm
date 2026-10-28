/datum/antagonist/traitor/syndicate_boarder
	name = "\improper Syndicate Boarder"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator
	preview_outfit = /datum/outfit/syndicate_boarder_preview
	pref_flag = ROLE_SYNDICATE_BOARDER

/datum/antagonist/traitor/syndicate_boarder/on_gain()
	var/mob/living/carbon/human/current = owner.current
	if(iscarbon(current))
		current.apply_pref_name(/datum/preference/name/syndicate, current.client)
		current.dna.update_dna_identity()
	current.equipOutfit(infil_outfit)
	return ..()

/datum/outfit/syndicate_boarder_preview
	name = "Syndicate Boarder (Preview only)"

	back = /obj/item/mod/control/pre_equipped/empty/infiltrator/preview_only
	uniform = /obj/item/clothing/under/syndicate
	l_hand = /obj/item/shield/energy
	r_hand = /obj/item/gun/ballistic/automatic/c20r

/datum/outfit/syndicate_boarder_preview/post_equip(mob/living/carbon/human/equipped_person, visualsOnly)
	var/obj/item/shield/energy/e_shield = locate() in equipped_person.contents
	e_shield.icon_state = "[initial(e_shield.icon_state)]_on"
