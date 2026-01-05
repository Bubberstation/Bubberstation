/turf/open/lava/fake
	name = "lava"
	desc = "Go on. Step in it. Maybe you'll be like some sort of Lava based Jesus."
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	lava_damage = 0
	lava_firestacks = 0
	temperature_damage = 0
	slowdown = 0
	immunity_trait = TRAIT_GHOSTROLE
	immunity_resistance_flags = LAVA_PROOF
	var/give_turf_traits = list(TRAIT_TURF_IGNORE_SLOWDOWN, TRAIT_LAVA_STOPPED, TRAIT_IMMERSE_STOPPED)

/turf/open/floor/plating/vox
	name = "nitrogen-filled plating"
	desc = "Vox box certified."
	initial_gas_mix = "n2=104;TEMP=293.15"

/turf/open/indestructible/bathroom
	icon = 'modular_skyrat/modules/ghostcafe/icons/floors.dmi';
	icon_state = "titanium_blue_old";
	name = "bathroom floor"
	footstep = FOOTSTEP_FLOOR
	tiled_turf = FALSE

/turf/open/indestructible/carpet
	desc = "It's really cozy! Great for soft paws!";
	icon = 'modular_skyrat/modules/ghostcafe/icons/carpet_royalblack.dmi';
	icon_state = "carpet";
	name = "soft carpet"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE

/turf/open/water/hot_spring/cafe
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
