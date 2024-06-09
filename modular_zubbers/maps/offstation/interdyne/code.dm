/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/bubberstation
	prefix = "_maps/RandomRuins/IceRuins/bubberstation/"
/*------*/

/datum/map_template/ruin/icemoon/bubberstation/syndicate_base
	name = "Syndicate Ice Base"
	id = "ice-base"
	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
	suffix = "icemoon_interdyne.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/bubberstation/dauntless)
	always_place = TRUE
	ruin_type = ZTRAIT_ICE_RUINS_UNDERGROUND
