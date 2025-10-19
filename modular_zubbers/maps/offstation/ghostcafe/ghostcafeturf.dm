/turf/open/fakelava
	name = "lava"
	desc = "Go on. Step in it. Maybe you'll be like some sort of Lava based Jesus."
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	var/mask_icon = 'icons/turf/floors.dmi'
	var/mask_state = "lava-lightmask"
	var/fish_source_type = /datum/fish_source/lavaland
	icon_state = "lava"
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_LAVA
	light_on = FALSE

/turf/open/floor/plating/vox
	name = "nitrogen-filled plating"
	desc = "Vox box certified."
	initial_gas_mix = "n2=104;TEMP=293.15"

/turf/open/indestructible/bathroom
	icon = 'modular_skyrat/modules/ghostcafe/icons/floors.dmi';
	icon_state = "titanium_blue_old";
	name = "bathroom floor"
	footstep = FOOTSTEP_FLOOR
	tiled_dirt = FALSE

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
	tiled_dirt = FALSE
