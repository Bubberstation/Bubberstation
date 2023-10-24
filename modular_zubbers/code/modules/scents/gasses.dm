#define GAS_SCENT "gas_scent"

/datum/gas/scent
	id = GAS_SCENT
	specific_heat = 20
	name = "strange scent"
	gas_overlay = "water_vapor_old"
	moles_visible = MOLES_GAS_VISIBLE / 4
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

#define GAS_CADAVERINE "gas_cadaverine"
/datum/gas/scent/cadaverine
	id = GAS_CADAVERINE
	name = "Cadaverine"
	dangerous = TRUE
	gas_overlay = "chem_gas_old"
