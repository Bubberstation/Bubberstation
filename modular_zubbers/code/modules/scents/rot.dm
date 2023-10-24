/obj/item/organ/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE) // Miasma on damage.
	. = ..()
	if(organ_flags & (ORGAN_VIRGIN | ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES | ORGAN_FROZEN))
		return
	if(damage >= maxHealth / 2) // Severely damaged organs emit miasma.
		rot()

#define ROT_MOLES 0.1

/obj/item/organ/proc/rot()
	var/turf/open/T = get_turf(owner?.loc || src.loc)
	if(!istype(T) || T.planetary_atmos || T.return_air().return_pressure() > (WARNING_HIGH_PRESSURE - 10))
		return
	var/datum/gas_mixture/stank = new
	if(owner)
		ADD_GAS(/datum/gas/scent/cadaverine, stank.gases)
		stank.gases[/datum/gas/scent/cadaverine][MOLES] = ROT_MOLES
	ADD_GAS(/datum/gas/scent/putrescine, stank.gases)
	stank.gases[/datum/gas/scent/putrescine][MOLES] = ROT_MOLES
	stank.temperature = owner?.bodytemperature | BODYTEMP_NORMAL
	T.assume_air(stank)
	T.air_update_turf(FALSE, FALSE)

#undef ROT_MOLES

