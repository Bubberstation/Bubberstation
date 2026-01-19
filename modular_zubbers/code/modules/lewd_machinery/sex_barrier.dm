/obj/item/holosign_creator/sex
	name = "holographic sex projector"
	desc = "Despite the name, it does not project sex, however it does create a non-blocking barrier that informs those who wish to enter that there is sex inside."
	max_signs = 4
	creation_time = 10
	holosign_type = /obj/structure/holosign/sexsign
	w_class = WEIGHT_CLASS_TINY
	//The janitor sign is also purple so no need to make custom sprites here.

/obj/structure/holosign/sexsign
	name = "sex sign"
	desc = "The words flicker DON'T SEX OPEN INSIDE. I think this means that there is sex beyond this door and that you should probably not enter, unless of course you are prepared for unforeseen consequences."
	icon = 'modular_zubbers/icons/effects/sex_barrier.dmi'
	icon_state = "yes_i_spent_time_on_this"
