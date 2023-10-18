/obj/item/organ/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE) // Miasma on damage.
	. = ..()
	if(.)
		rot()

#define ROT_MOLES 0.1

/obj/item/organ/proc/rot()
	var/turf/open/T = get_turf(owner?.loc || src.loc)
	if(!istype(T) || T.planetary_atmos || T.return_air().return_pressure() > (WARNING_HIGH_PRESSURE - 10))
		return
	var/datum/gas_mixture/stank = new
	ADD_GAS(/datum/gas/miasma, stank.gases)
	stank.gases[/datum/gas/miasma][MOLES] = ROT_MOLES
	stank.temperature = owner?.bodytemperature | BODYTEMP_NORMAL
	T.assume_air(stank)
	T.air_update_turf(FALSE, FALSE)

#undef ROT_MOLES
