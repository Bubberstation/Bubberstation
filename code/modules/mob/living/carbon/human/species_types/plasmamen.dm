/datum/species/plasmaman
	name = "\improper Plasmaman"
	plural_form = "Plasmamen"
	id = SPECIES_PLASMAMAN
	sexes = TRUE//ZUBBER EDIT, SEX WILL BE REAL
	meat = /obj/item/stack/sheet/mineral/plasma
	species_traits = list(
		NOTRANSSTING,
	)
	// plasmemes get hard to wound since they only need a severe bone wound to dismember, but unlike skellies, they can't pop their bones back into place
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_NOBLOOD,
		TRAIT_NO_DEBRAIN_OVERLAY,
	)

	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	inherent_respiration_type = RESPIRATION_PLASMA
	mutantlungs = /obj/item/organ/internal/lungs/plasmaman
	mutanttongue = /obj/item/organ/internal/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/internal/liver/plasmaman
	mutantstomach = /obj/item/organ/internal/stomach/bone/plasmaman
	mutantappendix = null
	mutantheart = null
	burnmod = 1.5
	heatmod = 1.5
	brutemod = 1.5
	payday_modifier = 0.75
	breathid = GAS_PLASMA
	disliked_food = FRUIT | CLOTH
	liked_food = VEGETABLES
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	species_cookie = /obj/item/reagent_containers/condiment/milk
	outfit_important_for_life = /datum/outfit/plasmaman
	species_language_holder = /datum/language_holder/skeleton

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/plasmaman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/plasmaman,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/plasmaman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/plasmaman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/plasmaman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/plasmaman,
	)

	// Body temperature for Plasmen is much lower human as they can handle colder environments
	bodytemp_normal = (BODYTEMP_NORMAL - 40)
	// The minimum amount they stabilize per tick is reduced making hot areas harder to deal with
	bodytemp_autorecovery_min = 2
	// They are hurt at hot temps faster as it is harder to hold their form
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 20) // about 40C
	// This effects how fast body temp stabilizes, also if cold resit is lost on the mob
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 50) // about -50c

	ass_image = 'icons/ass/assplasma.png'

	/// If the bones themselves are burning clothes won't help you much
	var/internal_fire = FALSE

/datum/species/plasmaman/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.set_safe_hunger_level()

/datum/species/plasmaman/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	var/atmos_sealed = TRUE
	if(HAS_TRAIT(H, TRAIT_NOFIRE))
		atmos_sealed = FALSE
	else if(!isclothing(H.wear_suit) || !(H.wear_suit.clothing_flags & STOPSPRESSUREDAMAGE))
		atmos_sealed = FALSE
	else if(!HAS_TRAIT(H, TRAIT_NOSELFIGNITION_HEAD_ONLY) && (!isclothing(H.head) || !(H.head.clothing_flags & STOPSPRESSUREDAMAGE)))
		atmos_sealed = FALSE

	var/flammable_limb = FALSE
	for(var/obj/item/bodypart/found_bodypart as anything in H.bodyparts)//If any plasma based limb is found the plasmaman will attempt to autoignite
		if(IS_ORGANIC_LIMB(found_bodypart) && found_bodypart.limb_id == SPECIES_PLASMAMAN) //Allows for "donated" limbs and augmented limbs to prevent autoignition
			flammable_limb = TRUE
			break

	if(!flammable_limb && !H.on_fire) //Allows their suit to attempt to autoextinguish if augged and on fire
		return

	var/can_burn = FALSE
	if(!isclothing(H.w_uniform) || !(H.w_uniform.clothing_flags & PLASMAMAN_PREVENT_IGNITION))
		can_burn = TRUE
	else if(!isclothing(H.gloves))
		can_burn = TRUE
	else if(!HAS_TRAIT(H, TRAIT_NOSELFIGNITION_HEAD_ONLY) && (!isclothing(H.head) || !(H.head.clothing_flags & PLASMAMAN_PREVENT_IGNITION)))
		can_burn = TRUE

	if(!atmos_sealed && can_burn)
		var/datum/gas_mixture/environment = H.loc.return_air()
		if(environment?.total_moles())
			if(environment.gases[/datum/gas/hypernoblium] && (environment.gases[/datum/gas/hypernoblium][MOLES]) >= 5)
				if(H.on_fire && H.fire_stacks > 0)
					H.adjust_fire_stacks(-10 * seconds_per_tick)
			else if(!HAS_TRAIT(H, TRAIT_NOFIRE))
				if(environment.gases[/datum/gas/oxygen] && (environment.gases[/datum/gas/oxygen][MOLES]) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.25 * seconds_per_tick)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message(span_danger("[H]'s body reacts with the atmosphere and bursts into flames!"),span_userdanger("Your body reacts with the atmosphere and bursts into flame!"))
					H.ignite_mob()
					internal_fire = TRUE

	else if(H.fire_stacks)
		var/obj/item/clothing/under/plasmaman/P = H.w_uniform
		if(istype(P))
			P.Extinguish(H)
			internal_fire = FALSE
	else
		internal_fire = FALSE

	H.update_fire()

/datum/species/plasmaman/handle_fire(mob/living/carbon/human/H, seconds_per_tick, times_fired, no_protection = FALSE)
	if(internal_fire)
		no_protection = TRUE
	. = ..()

/datum/species/plasmaman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.plasmaman_outfit)
		equipping.equipOutfit(job.plasmaman_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/plasmaman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_plasmaman_name()

	var/randname = plasmaman_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/plasmaman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(istype(chem, /datum/reagent/toxin/plasma) || istype(chem, /datum/reagent/toxin/hot_ice))
		for(var/i in H.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_xadone(4 * REM * seconds_per_tick) // plasmamen use plasma to reform their bones or whatever
		return FALSE // do normal metabolism

	if(istype(chem, /datum/reagent/toxin/bonehurtingjuice))
		H.adjustStaminaLoss(7.5 * REM * seconds_per_tick, 0)
		H.adjustBruteLoss(0.5 * REM * seconds_per_tick, 0)
		if(SPT_PROB(10, seconds_per_tick))
			switch(rand(1, 3))
				if(1)
					H.say(pick("oof.", "ouch.", "my bones.", "oof ouch.", "oof ouch my bones."), forced = /datum/reagent/toxin/bonehurtingjuice)
				if(2)
					H.manual_emote(pick("oofs silently.", "looks like [H.p_their()] bones hurt.", "grimaces, as though [H.p_their()] bones hurt."))
				if(3)
					to_chat(H, span_warning("Your bones hurt!"))
		if(chem.overdosed)
			if(SPT_PROB(2, seconds_per_tick) && iscarbon(H)) //big oof
				var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) //God help you if the same limb gets picked twice quickly.
				var/obj/item/bodypart/bp = H.get_bodypart(selected_part) //We're so sorry skeletons, you're so misunderstood
				if(bp)
					playsound(H, get_sfx(SFX_DESECRATION), 50, TRUE, -1) //You just want to socialize
					H.visible_message(span_warning("[H] rattles loudly and flails around!!"), span_danger("Your bones hurt so much that your missing muscles spasm!!"))
					H.say("OOF!!", forced=/datum/reagent/toxin/bonehurtingjuice)
					bp.receive_damage(200, 0, 0) //But I don't think we should
				else
					to_chat(H, span_warning("Your missing arm aches from wherever you left it."))
					H.emote("sigh")
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return TRUE

	if(istype(chem, /datum/reagent/gunpowder))
		H.set_timed_status_effect(15 SECONDS * seconds_per_tick, /datum/status_effect/drugginess)
		if(H.get_timed_status_effect_duration(/datum/status_effect/hallucination) / 10 < chem.volume)
			H.adjust_hallucinations(2.5 SECONDS * seconds_per_tick)
		// Do normal metabolism
		return FALSE
	if(chem.type == /datum/reagent/consumable/milk)
		if(chem.volume > 50)
			H.reagents.remove_reagent(chem.type, chem.volume - 5)
			to_chat(H, span_warning("The excess milk is dripping off your bones!"))
		H.heal_bodypart_damage(2.5 * REM * seconds_per_tick)

		for(var/datum/wound/iter_wound as anything in H.all_wounds)
			iter_wound.on_xadone(1 * REM * seconds_per_tick)
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return FALSE

/datum/species/plasmaman/get_scream_sound(mob/living/carbon/human)
	return pick(
		'sound/voice/plasmaman/plasmeme_scream_1.ogg',
		'sound/voice/plasmaman/plasmeme_scream_2.ogg',
		'sound/voice/plasmaman/plasmeme_scream_3.ogg',
	)

/datum/species/plasmaman/get_species_description()
	return "Born on the Moon of Freyja, \
	the first iterations of Plasmamen swam through plasma oceans and rivers as small bacteria, \
	before Nanotrasen arrived and began their plasma research. \
	Since then, Plasmamen have been uplifted by the corporation and exist \
	as a still strange and largely not understood colony of bacterial fungus and pure plasma."


/datum/species/plasmaman/get_species_lore()
	return list(
		"Lore written by Mef",
		
		"Origins",
		"The origins of the Plasmamen start on the Ice-Moon of Freyja. \
		Plasmamen were tiny little specks of bacterial fungus that swam through the rivers and seas of plasma, \
		the brains of these bacterias very primal and underdeveloped, however, comparatively to other bacteria like it, \
		they had far surpassed them in neural and brain development, \
		have extremely rudimentary and simple thoughts.",

		"When Nanotrasen had arrived on the Ice Moon, \
		they had begun study on the plasma oceans and rivers that ran throughout the snow-covered planet, \
		soon finding these rudimentary bacterial beings that persisted in the plasma oceans, \
		feeding off of plasma and, as described by the scientists overseeing the project:",

		"\"Pointlessly floating in and sustaining off of Plasma. \
		Their ability to ‘think’ can largely be attributed to how little they have to do to survive, \
		their evolution to think in the most basic form most likely comes from evolution not needing to invest in their survival, \
		rather develop their brains to entertain themselves.\"",
		"- Freyja Research Director, Konrei En’leik.",

		"After some consideration, \
		Nanotrasen attempted to experiment with these life-forms \
		in an attempt to uplift these bacterial life-forms into a far more advanced species, \
		which these experiments were greatly successful, creating the first Plasmaman sometime in the early 2400’s.",

		"Anatomy and Neural Developments",
		"The way the researchers formed the Plasmamen was by taking massive populations \
		of the Plasma bacteria and forcing them to colonize, \
		which resulted in these bacteria forming neural links to each other until they formed into an actual being, \
		as one of these bacterias had far from advanced intelligence, however when they were linked together with other Plasma bacterias, \
		they were able to form extremely coherent thoughts and reached human-level intelligence.",

		"Nanotrasen had engineered efficient and economically viable suits for the plasmamen \
		to wear outside of containment and they began teaching these newly created people \
		languages, concepts, thoughts, and primarily, Nanotrasen. \
		This resulted in the majority of early Plasmamen being suited for labor work and having \
		gracious and positive opinions on Nanotrasen, however as more and more Plasmamen were created, \
		outside influences allowed for different ideals and ideologies to enter into circulation inside of Plasmamen communities.",

		"Procreation from the Plasma bacteria occurred through mitosis at random points when they grew large enough, \
		splitting and creating a new bacteria that would float away and continue the same life, \
		however as Plasmamen were colonized into a full being, they were unable to procreate through mitosis, \
		however, colonized Plasmamen are able to reproduce sexually with another Plasmaman and form spores that grow into millions of bacteria that can be colonized into a Plasmaman, \
		somewhat similar to that of some Fungi.",

		"While plasma bacteria is considered a bacteria, \
		Plasmamen are colonies of these bacteria that form and create sophisticated neural links with each other, \
		and bizarrely switch classifications to become a species of Fungi as their reproduction cycle matches that of a Fungus, \
		they are not autotrophs, they grow like many other fungi, and they even display bioluminescence in their eyes, \
		which are formed within their skeletal frame in its eye sockets as conditioned by the Scientists working on them.",

		"\"Plasmamanifcation\"",
		"Plasmamanification is a comedic term for whenever someone is forced into the plasma-waters \
		and their body is forcibly changed to be that of a Plasmaman. \
		These types of Plasmamen are usually considered necrotic, however they are able to retain partial, \
		or in rare cases, full memories of their time before Plasmamanification.",

		"This is typically done on valuable dead people to restart their functions so that they may continue \
		to provide their services to Nanotrasen, however accidental Plasmamanfiication can occur. \
		In the case of those that are already deceased, their brain activity can decay and aid to the loss of memories, \
		with the worst cases being total amnesia, however those that are forced to be Plasmamen \
		as they are still alive are able to retain their memories.",

		"The process is near-instant and extremely painful, \
		as the concentration of Plasma bacteria is so extreme within the waters that the moment much of the person’s \
		skin is vaporized and their nerves exposed, millions of bacterial plasma connect and form neural connections to the person, \
		essentially restarting their vital functions if already dead and causing an extreme an unnatural change if they were still alive.",

		"Due to the neural activity of the Plasma bacteria, there are often extreme shifts in who the person becomes after plasmamanification, \
		with some Plasmamen even identifying completely differently after they are re-created. \
		This is usually because as the Plasma bacteria connects to the nervous system they rapidly transmit and receive different concepts, \
		ideals, ideas, and traits, causing the person to experience a brief explosion of thought and they remain forever changed.",

		"Though it is often hard to tell, there are ways of seeing between a born-Plasmoid and a forced-Plasmoid, \
		often in the nervous system, which still partially resembles that of their former species’ nervous system. \
		These Plasmamen are usually given more leeway in returning to their jobs, \
		as their experience (if they retain it) would end up being wasted in being forced into the chaste of other Plasmamen. \
		These Plasmamen usually do not take normal Plasmaman naming conventions and usually retain their old names or come up with a new name for themselves.",

		"Later History and \"Culture\"",
		"After Plasmamen began to be integrating into society and spreading throughout the known universe \
		as versatile and cheap workers, Plasmamen were able to develop deviations from the basic \
		Nanotrasen standard culture Plasmamen were adopted into, \
		becoming variables that largely formed into whatever and whichever community they were joined into, \
		even taking self-hating stances in far more negative communities.",

		"In Nanotrasen, Plasmamen are taught respect and absolute loyalty to the corporation. \
		Their ability to easily survive in space and other harsh environments with far fewer accommodations \
		than a regular organic being would need has given them a reputation as robust workers, \
		and a somewhat close kinship to synthetic and robotic creatures as they were typically working on projects together.",

		"Plasmaman naming conventions have gone through 3 general phases, \
		the original names being that of numbers based on their order of creation. \
		However, as more plasmamen were created, the more standard and most popular naming convention was adopted, \
		being \"X Roman Numeral\", X usually being anything from planets, periodic elements, things, etc. \
		This naming convention usually was by family and lineage, so for example, Neon XIIX would be the 18th member of the Neon family, \
		though this wasn’t only the case as many Plasmamen possessed this naming convention for other reasons.",

		"The final, and newest naming convention that some younger Plasmamen, \
		and often times Plasmamen isolated from their original culture, \
		is to adopt the naming convention of those that they assimilate to, with some Plasmamen assimilating into \
		Sol, Lizard, and even Xeno communities and adopting their naming conventions.",

		"In the Modern day, Plasmamen have had a few generations and integrated nicely into the societies they persist in, \
		though still facing the struggle of climbing into higher ranks in society, \
		typically working in hard labor and jobs that Nanotrasen wouldn’t wanna waste organic lives and organic complaints in, \
		as Plasmamen don’t usually complain because they were never really taught they could.",
	)

/datum/species/plasmaman/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "user-shield",
			SPECIES_PERK_NAME = "Protected",
			SPECIES_PERK_DESC = "Plasmamen are immune to radiation, poisons, and most diseases.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Wound Resistance",
			SPECIES_PERK_DESC = "Plasmamen have higher tolerance for damage that would wound others.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "Plasma Healing",
			SPECIES_PERK_DESC = "Plasmamen can heal wounds by consuming plasma.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hard-hat",
			SPECIES_PERK_NAME = "Protective Helmet",
			SPECIES_PERK_DESC = "Plasmamen's helmets provide them shielding from the flashes of welding, as well as an inbuilt flashlight.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Living Torch",
			SPECIES_PERK_DESC = "Plasmamen instantly ignite when their body makes contact with oxygen.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "Complex Biology",
			SPECIES_PERK_DESC = "Plasmamen take specialized medical knowledge to be \
				treated. Do not expect speedy revival, if you are lucky enough to get \
				one at all.",
		),
	)

	return to_add
