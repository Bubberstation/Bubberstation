/obj/item/organ/internal/lungs/cybernetic/elite
	name = "elite cybernetic lungs"
	desc = "An experimental version of the upgraded cybernetic lungs. Features maximum tolerance against heat, cold, plasma, and carbon dioxide."
	icon_state = "lungs-c-u2"

	// Slightly better than upgraded cybernetic lungs (13)
	safe_oxygen_min = 10

	// Slightly better than toxin-adapted lungs (27)
	safe_co2_max = 25
	safe_plasma_max = 25

	// Copied from cold-adapted lungs
	cold_message = "a slightly painful, though bearable, cold sensation"
	cold_level_1_threshold = 208
	cold_level_2_threshold = 200
	cold_level_3_threshold = 170

	// Copied from heat-adapted lungs
	hot_message = "a slightly painful, though bearable, warmth"
	heat_level_1_threshold = 373
	heat_level_2_threshold = 473
	heat_level_3_threshold = 523

/obj/item/organ/internal/lungs/cybernetic/tier2/recycler
	name = "recycler cybernetic lungs"
	desc = "An upgraded version of standard cybernetic lungs. Alleviates the need for oxygen by recycling it from the user's blood."

	// No oxygen requirement
	safe_oxygen_min = 0

	low_threshold_passed = span_warning("Your lungs struggle to recycle the oxygen in your blood.")
	high_threshold_passed = span_warning("You feel some sort of constriction around your chest as your lugs struggle to filter your blood.")
	now_fixed = span_warning("Your lungs seem to once again be recycling oxygen.")
	low_threshold_cleared = span_info("Your lungs start functioning normally again.")
	high_threshold_cleared = span_info("The constriction around your chest loosens as your lungs start functioning normally again.")
