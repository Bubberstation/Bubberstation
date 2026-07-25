// No free fall softening for everyone - but functional wings get it
/obj/item/organ/wings/functional/can_soften_fall()
	return TRUE

/obj/item/organ/wings/functional/robotic/virtual
	name = "virtualized wings"
	desc = "Using long extended projection arms, these wings produce hardlight feathers capable of producing lift"
	organ_flags = ORGAN_ROBOTIC
	sprite_accessory_override = /datum/sprite_accessory/wings/robotic/virtual
