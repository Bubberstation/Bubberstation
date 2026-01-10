/datum/action/cooldown/spell/shapeshift/polymorph_hugbox
	name = "Wabbajack Polymorph"
	desc = "After being exposed to wabbajack magic, you now gain the permanent ability to shapeshift back and forth between your \"gifted\" transformation type."
	keep_name = TRUE

	cooldown_time = 3 MINUTES
	shared_cooldown = NONE
	text_cooldown = TRUE
	cooldown_rounding = 1

	revert_on_death = TRUE
	die_with_shapeshifted_form = TRUE

	spell_requirements = NONE

	shapeshift_type = /mob/living/basic/cockroach
	possible_shapes = list(/mob/living/basic/cockroach) // Only reason this exists is to shut linters up.
