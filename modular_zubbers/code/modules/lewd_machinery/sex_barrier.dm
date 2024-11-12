/obj/item/holosign_creator/sex
	name = "holographic sex projector"
	desc = "Despite the name, it does not project sex, however it does create a non-blocking barrier that informs those who wish to enter that there is sex inside."
	max_signs = 4
	creation_time = 10
	holosign_type = /obj/structure/holosign/barrier/atmos/sex
	//The janitor sign is also purple so no need to make custom sprites here.

/obj/structure/holosign/barrier/atmos/sex
	name = "sex barrier"
	desc = "The words flicker: DON'T SEX OPEN INSIDE. I think this means that there is sex beyond this door and that you should probably not enter, unless of course you are prepared for unforeseen consequences.\n\nThe holographic warning reads: Barriers work best when they are used correctly every time you perform engineering. Even one act of engineering without using a barrier can result in unplanned atmospheric consequences. If your barrier breaks or becomes dislodged during engineering, or if you forget or are unable to use it, you may want to consider emergency atmospherics containment."
	icon = 'modular_zubbers/icons/effects/sex_barrier.dmi'
	icon_state = "yes_i_spent_time_on_this"
	max_integrity = 150
