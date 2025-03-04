/obj/item/organ/lungs/nitrogen
	name = "nitrogen lungs"
	desc = "A set of lungs for breathing nitrogen."
	safe_oxygen_min = 0	//Dont need oxygen
	safe_oxygen_max = 2 //But it is quite toxic
	safe_nitro_min = 4 // Atleast 4 nitrogen
	oxy_damage_type = TOX
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20

/obj/item/organ/lungs/nitrogen/vox
	name = "vox lungs"
	desc = "They're filled with dust... wow."
	icon_state = "lungs-c"

	cold_level_1_threshold = 0 // Vox should be able to breathe in cold gas without issues?
	cold_level_2_threshold = 0
	cold_level_3_threshold = 0
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/lungs/nitrogen/slime_lungs
	name = "nitrogen-based vacuole"
	desc = "Traditional slimeperson lungs. These ones run off nitrogen."
	icon_state = "lungs-plasma"

	oxy_damage_type = BRUTE
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20
