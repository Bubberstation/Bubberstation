/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to recycle materials and create more nanite mass. Needed to facilitate the repair process on a collapsed Protean; it can be installed as a module in the rig, or as an organ."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_ROCK_EATER)
	custom_premium_price = PAYCHECK_COMMAND * 2
	COOLDOWN_DECLARE(starving_message)
	/// If we're on low power mode
	var/low_power = FALSE
	/// If we're folded up into our suit
	var/folded = FALSE

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	for(var/datum/reagent/consumable/food in reagents.reagent_list) // Will only process materials
		if(istype(food, /datum/reagent/consumable/nutriment/mineral))
			continue
		food.nutriment_factor = 0

	. = ..()

	if(!istype(owner.dna.species, /datum/species/protean))
		return

	var/base_hunger = low_power ? 0.5 : 1 // Low power halves hunger, but disables healing
	hunger_modifier = folded ? 0 : base_hunger
	if(folded)
		return

	if(isnull(owner.client)) // So we dont die from afk/crashing out
		return

	if(owner.nutrition < NUTRITION_LEVEL_STARVING)
		owner.adjust_brute_loss(1, forced = TRUE)
		owner.adjust_fire_loss(1, forced = TRUE)
		if(COOLDOWN_FINISHED(src, starving_message))
			to_chat(owner, span_danger("You starving! Find some metal now!"))
			owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
			COOLDOWN_START(src, starving_message, 20 SECONDS)
		return
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)

	if(owner.nutrition < NUTRITION_LEVEL_VERY_HUNGRY)
		return
	var/healing_amount = -2
	var/health_range = owner.health / owner.maxHealth
	switch(health_range)
		if(-INFINITY to 0.3)
			healing_amount *= 1.5
		if(0.3 to 0.7)
			healing_amount *= 1 // Multiply by 1 to show that this is the default value
		if(0.7 to INFINITY)
			healing_amount *= 0.5

	if(owner.get_brute_loss() > 0)
		owner.adjust_brute_loss(healing_amount, forced = TRUE)
		owner.nutrition += healing_amount * 2.5
	if(owner.get_fire_loss() > 0)
		owner.adjust_fire_loss(healing_amount, forced = TRUE)
		owner.nutrition += healing_amount * 2.5
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume += 3
		owner.nutrition -= 9
