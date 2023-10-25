#define GAS_SCENT "gas_scent"
/obj/item/organ/internal/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/scent/putrescine, while_present = PROC_REF(too_much_putrescine))

/datum/gas/scent
	id = GAS_SCENT
	specific_heat = 20
	name = "strange scent"
	gas_overlay = "water_vapor_old"
	moles_visible = MOLES_GAS_VISIBLE / 2
	fusion_power = 0
	dangerous = FALSE
	rarity = 0
	purchaseable = FALSE
	base_value = 0
	desc = "A funky smell."

#define GAS_PUTRESCINE "gas_putrescine"

/datum/gas/scent/putrescine
	id = GAS_PUTRESCINE
	name = "Putrescine"
	dangerous = TRUE
	gas_overlay = "miasma_old"

/obj/item/organ/internal/lungs/proc/too_much_putrescine(mob/living/carbon/breather, datum/gas_mixture/breath, putrescine_pp, old_putrescine_pp)
	breathe_gas_volume(breath, /datum/gas/scent/putrescine)
	// Metabolize to reagent.
	if(putrescine_pp > 0.4)
		breather.reagents.add_reagent(/datum/reagent/putrescine, 5)

#define GAS_CADAVERINE "gas_cadaverine"
/datum/gas/scent/cadaverine
	id = GAS_CADAVERINE
	name = "Cadaverine"
	dangerous = TRUE
	gas_overlay = "chem_gas_old"
