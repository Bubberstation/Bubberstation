/obj/item/clothing/under/rank/lace
	name = "lilac dress"
	desc = "A high quality lacey dress with touches of white and lilac, you feel unworthy holding it."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lilacdress"
	inhand_icon_state = "lilacdress"
	supports_variations_flags = CLOTHING_NO_VARIATION
	can_adjust = FALSE

/obj/item/clothing/shoes/heels/drag/lace
	name = "elegant heels"
	desc = "A quality pair of heels that delicately shines in the light, wearing gives you extra feminine mystique."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lilacheels"
	inhand_icon_state = "lilacheels"

/obj/item/clothing/shoes/heels/drag/lace/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/gloves/evening/lace
	name = "lace gloves"
	desc = "A pair of lace gloves, the delicate fabric trails down to cover just the top of your hand."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "lacygloves"
	inhand_icon_state = "lacygloves"

/obj/item/clothing/neck/lace_collar
	name = "heart choker"
	desc = "A delicate choker with a silver heart on the front."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "heartchoker"
	inhand_icon_state = "heartchoker"

/obj/item/clothing/glasses/trickblindfold/lace
	name = "silk blindfold"
	desc = "A blindfold made from black silk, it feels nice to the touch."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "fold"
	inhand_icon_state = "fold"

/obj/item/clothing/head/costume/hairbow
	name = "hair bow"
	desc = "A dainty hairbow that sits delicately on an individuals hair. It's tilted for maximum cuteness."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "whitebow"
	inhand_icon_state = "whitebow"

/obj/item/clothing/suit/cloak/shawl
	name = "silk shawl"
	desc = "A delicate silk shawl meant to be worn over the elbows, the fabric is delightfully soft."
	icon = 'modular_zubbers/icons/obj/clothing/lace.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/lace.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/lace_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/lace_righthand.dmi'
	icon_state = "shawl"
	inhand_icon_state = "shawl"
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = NONE
