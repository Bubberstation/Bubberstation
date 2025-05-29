/datum/mutation/human/radfat
	name = "Radiotrophic Metabolism"
	desc = "A mutation that causes the user to be immune to the adverse effects of radiations, but causes sudden cell multiplication with increased strength under irradiation."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You crave the taste of... radiation?</span>"
	text_lose_indication = "<span class='notice'>You no longer desire the taste of radiation...</span>"
	difficulty = 14
	instability = 30
	power_coeff = 1

	var/FATCAP = 100

/datum/mutation/human/radfat/on_life()
	. = ..()
	var/fat_add = 1
	var/pwr = GET_MUTATION_POWER(src)
	if(owner.radiation > 0)
		fat_add += round(owner.radiation * (0.10 * pwr))
		owner.radiation -= round(owner.radiation * 0.05) + 1
		if(fat_add > (FATCAP * pwr))
			fat_add = (FATCAP * pwr)
	owner.adjust_fatness(fat_add, FATTENING_TYPE_RADIATIONS)

/datum/mutation/human/radfat/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_RADRESONANCE, src)

/datum/mutation/human/radfat/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_RADRESONANCE, src)

/obj/item/dnainjector/antiradfat
	name = "\improper DNA injector (Anti-Radiotrophic Metabolism)"
	desc = "The green kills."
	remove_mutations = list(RADFAT)

/obj/item/dnainjector/radfat
	name = "\improper DNA injector (Radiotrophic Metabolism)"
	desc = "Nuclear fallout protection at an heavy price."
	add_mutations = list(RADFAT)
