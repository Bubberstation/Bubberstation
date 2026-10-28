/obj/item/organ/wings/robotic/virtual
	name = "virtualized wings"
	desc = "Using long extended projection arms, these wings produce hardlight feathers capable of producing lift"
	organ_flags = ORGAN_ROBOTIC
	sprite_accessory_override = /datum/sprite_accessory/wings/robotic/virtual

// No free fall softening for everyone
/obj/item/organ/wings/can_soften_fall()
	return FALSE
