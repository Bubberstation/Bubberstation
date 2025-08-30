/// An element to add a unique examine to something based on some conditions.
/datum/element/unique_examine
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// The special description that is triggered when desc_requirements are met. Make sure you set the correct EXAMINE_CHECK!
	var/desc = ""
	/// The requirement setting for special descriptions. See examine_defines.dm for more info.
	var/desc_requirement = EXAMINE_CHECK_NONE
	/// Optional replacement for antagonist names. Ex: Noting something due to your "Donk Co" affiliation, instead of "Syndicate" affiliation
	var/special_affiliation
	/// Everything we may want to check based on an examine check.
	/// This can be a list of JOBS, FACTIONS, SKILL CHIPS, or TRAITS, or a bitflag
	var/requirements
	/// If TRUE, those with the detective's skillchip (TRAIT_DETECTIVES_TASTE) will be able to see the description regardless.
	var/detective_sees_all = TRUE
	/// A generic title for what we are, generated for things which hint.
	var/what_are_we = "thing"

/datum/element/unique_examine/Attach(
	atom/thing,
	desc,
	desc_requirement = EXAMINE_CHECK_NONE,
	requirements,
	special_affiliation,
	// hint = TRUE will give people a hint on examine there may be more info for this item.
	// You'll want to set this to FALSE if you're using multiple elements on one item
	hint = TRUE,
	// detective_sees_all = TRUE will allow those with the detective's skillchip to see it regardless of any other checks
	detective_sees_all = TRUE,
)

	. = ..()

	if(!isatom(thing) || isarea(thing))
		return ELEMENT_INCOMPATIBLE

	// Init our vars
	src.desc_requirement = desc_requirement
	src.desc = desc
	src.requirements = requirements
	src.special_affiliation = special_affiliation
	src.detective_sees_all = detective_sees_all

	// What are we doing if we don't even have a description?
	if(isnull(desc))
		stack_trace("Unique examine element attempted to attach to something without an examine text set.")
		return ELEMENT_INCOMPATIBLE

	// If we were passed a examine check that has a requirement,
	// check to make sure we have that requirement / it's formatted correctly
	switch(desc_requirement)
		if(EXAMINE_CHECK_TRAIT, EXAMINE_CHECK_SKILLCHIP, EXAMINE_CHECK_FACTION, EXAMINE_CHECK_JOB, EXAMINE_CHECK_SPECIES)
			if(!islist(requirements))
				// All of the abose checks should have a static list supplied, even if it's one item only.
				stack_trace("Unique examine element attempted to attach to something without a proper requirements list. (Mode: [desc_requirement])")
				return ELEMENT_INCOMPATIBLE

		if(EXAMINE_CHECK_DEPARTMENT)
			if(isnull(requirements))
				// Department check should have a department bitflag set.
				stack_trace("Unique examine element attempted to attach to something without departmental bitflag. (Mode: [desc_requirement])")
				return ELEMENT_INCOMPATIBLE

		if(EXAMINE_CHECK_NONE, EXAMINE_CHECK_MINDSHIELD)
			if(!isnull(requirements))
				// Having requirements set is technically fine, as they're never read, but improper.
				stack_trace("Unique examine element attached to something with requirements passed, even though it does not need any. \
					This may be a mistake, and should be corrected. (Mode: [desc_requirement])")

	// Having hint = TRUE will register a normal examine signal to give examiners a hint additional info is present
	if(hint)
		what_are_we = get_identifier(thing)
		RegisterSignal(thing, COMSIG_ATOM_EXAMINE, .proc/on_examine)

	RegisterSignal(thing, COMSIG_ATOM_EXAMINE_MORE, .proc/on_examine_more)

/datum/element/unique_examine/Detach(atom/thing)
	. = ..()
	UnregisterSignal(thing, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_EXAMINE_MORE))

/// Signal proc for [COMSIG_ATOM_EXAMINE] to hint this thing may have more info.
/// Does not guarantee the examiner is someone who can actually access said info.
/datum/element/unique_examine/proc/on_examine(datum/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_smallnoticeital("This [what_are_we] might have additional information if you [span_bold("examine closer")].")

/// Signal proc for [COMSIG_ATOM_EXAMINE_MORE], shows the unique description of the examiner fits the bill.
/datum/element/unique_examine/proc/on_examine_more(datum/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	// "You note the following becuase x, y, and z."
	var/note_message = get_note_message(examiner)

	// Check for detective skills at the very end
	if(detective_sees_all && HAS_TRAIT(examiner, TRAIT_DETECTIVES_TASTE))
		note_message ||= "Your [span_red("suite of innate detective skills")] has given you insight here:"

	// Ghosts can see all too
	if(isobserver(examiner) && desc_requirement != EXAMINE_CHECK_NONE)
		note_message ||= "This item has addition information available to people with a certain [desc_requirement]:"

	// Did not meet any requirements, or detective skills
	if(isnull(note_message))
		return

	examine_list += span_info("<br>[note_message]<br>[desc]")

/// Gets what message is displayed to the examiner.
/// Returns a string, or null if they aren't able to see the special description.
/datum/element/unique_examine/proc/get_note_message(mob/examiner)
	switch(desc_requirement)
		// Will always show if set.
		if(EXAMINE_CHECK_NONE)
			return "Upon further scrutiny, you note the following:"

		// Checks for a mindshield present
		if(EXAMINE_CHECK_MINDSHIELD)
			if(!HAS_TRAIT(examiner, TRAIT_MINDSHIELD))
				return

			// "Your innate loyalty to Nanotrasen", not quite innate if they get implanted midround but y'know
			return "Your [span_blue(span_bold("innate loyalty to Nanotrasen"))] has given you insight here:"

		// Antag datum checks
		if(EXAMINE_CHECK_ANTAG)
			if(!examiner.mind)
				return

			for(var/datum/antagonist/antag_datum_type as anything in requirements)
				var/datum/antagonist/antag_datum = examiner.mind.has_antag_datum(antag_datum_type)
				if(!antag_datum)
					continue

				// "Your status as a secret agent" or "Your status as a traitor"
				var/antag_title = special_affiliation || antag_datum.jobban_flag || antag_datum.pref_flag
				return "Your status as a [span_red(span_bold(antag_title))] has given you insight here:"

		// Job checks by title
		if(EXAMINE_CHECK_JOB)
			if(!examiner.mind)
				return

			var/datum/job/their_job = examiner.mind.assigned_role
			if(!(their_job.type in requirements))
				return

			// "Your training as a medical doctor"
			return "Your training as a [span_bold(their_job.title)] has given you insight here:"

		// Department checks by bitflag
		if(EXAMINE_CHECK_DEPARTMENT)
			if(!examiner.mind)
				return

			// What flag do they have that fulfills our requirements?
			var/their_department = examiner.mind.assigned_role.departments_bitflags
			if(!(their_department in requirements))
				return

			// "Your job in the cargo bay"
			return "Your job [get_department(their_department)] has given you insight here:"

		// Standard faction checks
		if(EXAMINE_CHECK_FACTION)
			// What factions do they have that fulfills our requirements?
			var/list/required_factions = requirements & examiner.faction
			if(!length(required_factions))
				return

			// "Your affiliation with the Wizard Federation"
			return "Your affiliation with [get_formatted_faction(pick(required_factions))] has given you insight here:"

		// Skillchip checks
		if(EXAMINE_CHECK_SKILLCHIP)
			if(!ishuman(examiner))
				return

			var/mob/living/carbon/human/human_examiner = examiner
			var/obj/item/organ/brain/examiner_brain = human_examiner.get_organ_slot(ORGAN_SLOT_BRAIN)
			if(!examiner_brain)
				return

			for(var/obj/item/skillchip/checked_skillchip as anything in examiner_brain.skillchips)
				if(!checked_skillchip.active)
					continue
				if(!(checked_skillchip.type in requirements))
					continue

				// "Your implanted K33P-TH4T-D15K skillchip"
				return "Your implanted [span_rlooc(span_bold(checked_skillchip.name))] has given you insight here:"

		// Trait checks
		if(EXAMINE_CHECK_TRAIT)
			for(var/checked_trait in requirements)
				if(HAS_TRAIT(examiner, checked_trait))
					// "A trait you have", kinda meta-y but not sure how else to prhase it
					return "A [span_rlooc(span_bold("trait"))] you have has given you insight here:"

		// Species checks
		if(EXAMINE_CHECK_SPECIES)
			if(!iscarbon(examiner))
				return

			var/mob/living/carbon/carbon_examiner = examiner
			var/datum/species/their_species = carbon_examiner.dna?.species
			if(!their_species || !(their_species.type in requirements))
				return

			return "Being a [span_green(span_bold(their_species.name))] has given you insight here:"

/// Gets an "identifier" for items which get a hint.
/datum/element/unique_examine/proc/get_identifier(atom/thing)
	// What IS this thing anyways? Follows a very loose priority system.
	// Order matters - lower types should be lower.

	// Mobs
	if(ishuman(thing))
		return "person"
	if(isanimal_or_basicmob(thing))
		return "animal"
	if(ismob(thing))
		return "creature"

	// Items
	if(isorgan(thing))
		return "organ"
	if(isbodypart(thing))
		return "limb"
	if(isgun(thing) || ismelee(thing))
		return "weapon"
	if(isclothing(thing))
		return "clothing"
	if(isitem(thing))
		var/obj/item/item_thing = thing
		if(item_thing.tool_behaviour)
			return "tool"
		else
			return "item"

	// Machines
	if(iscomputer(thing))
		return "computer"
	if(ismachinery(thing))
		return "machine"

	// Structures
	if(isstructure(thing))
		return "structure"

	// Any object?
	if(isobj(thing))
		return "object"

	// Who knows?
	return "thing"

/// Formats some of the more common faction names into a more accurate string.
/datum/element/unique_examine/proc/get_formatted_faction(faction)
	var/faction_text = faction

	switch(faction)
		// Some role defined ones, usually granted by antag datums,
		// so you could alternatively just use those, but anyways
		if(ROLE_ALIEN)
			faction_text = span_alien("the alien hivemind")
		if(FACTION_ASHWALKER)
			faction_text = span_red("the tendril")
		if(FACTION_CARP)
			faction_text = span_green("space carp")
		if(FACTION_CULT)
			faction_text = span_cult("Nar'sie")
		if(FACTION_HERETIC)
			faction_text = span_hypnophrase("the Mansus")
		if(FACTION_PIRATE)
			faction_text = span_red("the Jolly Roger")
		if(FACTION_PLANTS)
			faction_text = span_green("nature")
		if(ROLE_SYNDICATE)
			faction_text = span_red("the Syndicate")
		if(ROLE_WIZARD)
			faction_text = span_hypnophrase("the Wizard Federation")

	return span_bold(faction_text)

/// Format a department bitflag into a string.
/datum/element/unique_examine/proc/get_department(department_bitflag)
	var/department_text = "on company time"

	if(department_bitflag & DEPARTMENT_BITFLAG_COMMAND)
		department_text = "as a member of command staff"
	else if(department_bitflag & DEPARTMENT_BITFLAG_SECURITY)
		department_text = "as a member of security force"
	else if(department_bitflag & DEPARTMENT_BITFLAG_SERVICE)
		department_text = "in the service department"
	else if(department_bitflag & DEPARTMENT_BITFLAG_CARGO)
		department_text = "in the cargo bay"
	else if(department_bitflag & DEPARTMENT_BITFLAG_ENGINEERING)
		department_text = "as one of the engineers"
	else if(department_bitflag & DEPARTMENT_BITFLAG_SCIENCE)
		department_text = "in the science team"
	else if(department_bitflag & DEPARTMENT_BITFLAG_MEDICAL)
		department_text = "in the medical field"
	else if(department_bitflag & DEPARTMENT_BITFLAG_SILICON)
		department_text = "as a silicon unit"

	return span_bold(department_text)
