/obj/item/clothing/accessory/newbie_badge
	name = "\improper Shoshinsha Badge"
	desc = "A shiny enamel pin typically attached onto the uniform of new employees at the Bubber sector of Nanotrasen."
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/accessories.dmi'
	icon_state = "shoshinsha_badge"

/obj/item/clothing/accessory/newbie_badge/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(ishuman(user) && !isnull(user.client) && user.client.get_exp_living(pure_numeric = TRUE) < CONFIG_GET(number/newbie_hours_threshold) * 60)
		var/mob/living/carbon/human/human_equipper = user
		human_equipper.newbie_hud_set_badge()

/obj/item/clothing/accessory/newbie_badge/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_equipper = user
		human_equipper.newbie_hud_set_badge()

/mob/living/carbon/human/proc/newbie_hud_set_badge()
	var/obj/item/clothing/under/undershirt = w_uniform
	if(!istype(undershirt))
		set_hud_image_inactive(NEWBIE_HUD)
		return

	set_hud_image_active(NEWBIE_HUD)
	if(is_path_in_list(/obj/item/clothing/accessory/newbie_badge, undershirt.attached_accessories))
		set_hud_image_state(NEWBIE_HUD, "shoshinsha_badge")
	else
		set_hud_image_state(NEWBIE_HUD, "hudfan_no")

/datum/atom_hud/data/human/newbie_hud
	hud_icons = list(NEWBIE_HUD)

/mob/living/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NEWBIE_NOTICER, INNATE_TRAIT)

/datum/job/after_spawn(mob/living/spawned, client/player_client)
	. = ..(spawned, player_client)
	var/mob/living/carbon/human/human_spawned = spawned
	if(!istype(spawned))
		return

	var/obj/item/clothing/under/underclothing = human_spawned.w_uniform
	if(istype(underclothing) && player_client.get_exp_living(pure_numeric = TRUE) < CONFIG_GET(number/newbie_hours_threshold) * 60)
		underclothing.attach_accessory(SSwardrobe.provide_type(/obj/item/clothing/accessory/newbie_badge, spawned))
