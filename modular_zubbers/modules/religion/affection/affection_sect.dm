#define HEALED_HP_PER_FAVOR 1

/datum/religion_sect/affection
	name = "Affection God"
	quote = "A gentle touch is where true strength lies."
	desc = "Receiving affection grants you favor. Headpats, Hugs, and Tail-tugs are all fair game. \
	Interactions using the Interaction Panel also count. You can spend favor to heal people. \
	Being shown affection while in the chapel doubles the favor gained."
	tgui_icon = "heart"
	rites_list = list(
		/datum/religion_rites/upgrade_favor_gain,
		/datum/religion_rites/summon_call_necklace,
	)
	smack_chance = 0

	var/mob/living/carbon/human/last_healed = null
	var/maximum_healed_per_bless = 10
	var/favor_gain = 1
	var/favor_gain_upgrade_cost = 10
	var/chapel_gain_multiplier = 2
	var/gratitude_multiplier = 4

/datum/religion_sect/affection/on_conversion(mob/living/chap)
	. = ..()
	var/datum/component/affection_favor/comp = chap.AddComponent(/datum/component/affection_favor, src)
	if (!comp)
		message_admins("DEBUG: Failed to add component")

/datum/religion_sect/affection/sect_bless(mob/living/target, mob/living/chap)
	if(!ishuman(target))
		return BLESSING_IGNORED

	var/mob/living/carbon/human/blessed = target


	var/healing_available
	if((floor(favor / HEALED_HP_PER_FAVOR)) > maximum_healed_per_bless)
		healing_available = maximum_healed_per_bless
	else
		healing_available = floor(favor / HEALED_HP_PER_FAVOR)

	if (healing_available <= 0)
		to_chat(chap, span_red("You don't have enough favor to heal someone!"))
		return BLESSING_IGNORED

	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1)

	if(!length(hurt_limbs))
		return BLESSING_IGNORED

	for(var/obj/item/bodypart/affecting as anything in hurt_limbs)
		if (healing_available <= 0)
			break
		var/missing_brute = clamp(affecting.brute_dam, 0, healing_available)
		healing_available -= missing_brute

		var/missing_burn = clamp(affecting.burn_dam, 0, healing_available)
		healing_available -= missing_burn

		if(affecting.heal_damage(missing_brute, missing_burn))
			blessed.update_damage_overlays()
		adjust_favor(-((missing_brute + missing_burn) * HEALED_HP_PER_FAVOR), chap)

	blessed.visible_message(span_notice("[chap] heals [blessed] with the power of [GLOB.deity]!"))
	to_chat(blessed, span_boldnotice("May the power of [GLOB.deity] compel you to be healed!"))
	playsound(chap, SFX_PUNCH, 25, TRUE, -1)
	blessed.add_mood_event("blessing", /datum/mood_event/blessing)
	last_healed = target
	return BLESSING_SUCCESS


#undef HEALED_HP_PER_FAVOR
