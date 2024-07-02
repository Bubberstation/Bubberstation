/datum/reagent/medicine/monkeydone
	name = "Monkeydone"
	description = "Accelerates genetic growth in monkeys, and converts them into what passes as a humanoid. While it is based off of Mutadone, it does not actually fix genetic defects."
	color = "#88A384"
	taste_description = "salt"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	purity = REAGENT_STANDARD_PURITY
	inverse_chem_val = 0.5
	inverse_chem = /datum/reagent/consumable/monkey_energy

/datum/reagent/medicine/monkeydone/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if (!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/human_mob = affected_mob
	if (ismonkey(human_mob))
		human_mob.dna.remove_mutation(/datum/mutation/human/race)
