#define DEFAULT_NIFSOFT_COOLDOWN 5 SECONDS

///The base NIFSoft
/datum/nifsoft
	///What is the name of the NIFSoft?
	var/name = "Generic NIFsoft"
	///What is the name of the program when looking at the program from inside of a NIF? This is good if you want to mask a NIFSoft's name.
	var/program_name
	///A description of what the program does. This is used when looking at programs in the NIF, along with installing them from the store.
	var/program_desc = "This program does stuff!"
	//What NIF does this program belong to?
	var/datum/weakref/parent_nif
	///Who is the NIF currently linked to?
	var/mob/living/carbon/human/linked_mob
	///How much does the program cost to buy in credits?
	var/purchase_price = 300
	///What catagory is the NIFSoft under?
	var/buying_category = NIFSOFT_CATEGORY_GENERAL

	///Can the program be installed with other instances of itself?
	var/single_install = TRUE
	///Is the program mutually exclusive with another program?
	var/list/mutually_exclusive_programs = list()

	///Does the program have an active mode?
	var/active_mode = FALSE
	///Is the program active?
	var/active = FALSE
	///Does the what power cost does the program have while active?
	var/active_cost = 0
	///What is the power cost to activate the program?
	var/activation_cost = 0
	///Does the NIFSoft have a cooldown?
	var/cooldown = FALSE
	///Is the NIFSoft currently on cooldown?
	var/on_cooldown = FALSE
	///How long is the cooldown for?
	var/cooldown_duration = DEFAULT_NIFSOFT_COOLDOWN
	///What NIF models can this software be installed on?
	var/list/compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif)

/datum/nifsoft/New(obj/item/organ/internal/cyberimp/brain/nif/recepient_nif)
	. = ..()

	compatible_nifs += /obj/item/organ/internal/cyberimp/brain/nif/debug
	program_name = name

	if(!recepient_nif.install_nifsoft(src))
		qdel(src)


/datum/nifsoft/Destroy()
	if(active)
		activate()

	if(!parent_nif)
		return ..()

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	installed_nif.loaded_nifsofts.Remove(src)
	parent_nif = null

	return ..()

/// Activates the parent NIFSoft
/datum/nifsoft/proc/activate()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif

	if(installed_nif.broken)
		installed_nif.balloon_alert(installed_nif.linked_mob, "your NIF is broken")
		return FALSE

	if(cooldown && on_cooldown)
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is currently on cooldown.")
		return FALSE

	if(active)
		active = FALSE
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is no longer running")
		installed_nif.power_usage -= active_cost
		return TRUE

	if(!installed_nif.change_power_level(activation_cost))
		return FALSE

	if(active_mode)
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is now running")
		installed_nif.power_usage += active_cost
		active = TRUE

	if(cooldown)
		addtimer(CALLBACK(src, .proc/remove_cooldown), cooldown_duration)
		on_cooldown = TRUE

	return TRUE

///Refunds the activation cost of a NIFSoft.
/datum/nifsoft/proc/refund_activation_cost()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	installed_nif.change_power_level(-activation_cost)

///Removes the cooldown from a NIFSoft
/datum/nifsoft/proc/remove_cooldown()
	on_cooldown = FALSE

///Restores the name of the NIFSoft to default.
/datum/nifsoft/proc/restore_name()
	program_name = initial(name)

///How does the NIFSoft react if the user is EMP'ed?
/datum/nifsoft/proc/on_emp(emp_severity)
	if(active)
		activate()

	var/list/random_characters = list("#","!","%","^","*","$","@","^","A","b","c","D","F","W","H","Y","z","U","O","o")
	var/scrambled_name = "!"

	for(var/i in 1 to length(program_name))
		scrambled_name += pick(random_characters)

	program_name = scrambled_name
	addtimer(CALLBACK(src, .proc/restore_name), 60 SECONDS)

/// A disk that can upload NIFSofts to a recpient with a NIFSoft installed.
/obj/item/disk/nifsoft_uploader
	name = "Generic NIFSoft datadisk"
	desc = "A datadisk that can be used to upload a loaded NIFSoft to the user's NIF"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/disks.dmi'
	icon_state = "base_disk"
	///What NIFSoft is currently loaded in?
	var/datum/nifsoft/loaded_nifsoft = /datum/nifsoft
	///Is the datadisk reusable?
	var/reusable = FALSE

/obj/item/disk/nifsoft_uploader/Initialize()
	. = ..()

	name = "[initial(loaded_nifsoft.name)] datadisk"

/obj/item/disk/nifsoft_uploader/examine(mob/user)
	. = ..()

	var/nifsoft_desc = initial(loaded_nifsoft.program_desc)

	if(nifsoft_desc)
		. += span_cyan("Program description: [nifsoft_desc]")


/// Attempts to install the NIFSoft on the disk to the target
/obj/item/disk/nifsoft_uploader/proc/attempt_software_install(mob/living/carbon/human/target)
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = target.getorgan(/obj/item/organ/internal/cyberimp/brain/nif)

	if(!ishuman(target) || !installed_nif)
		return FALSE

	var/datum/nifsoft/installed_nifsoft = new loaded_nifsoft(installed_nif)

	if(!installed_nifsoft.parent_nif)
		balloon_alert(target, "installation failed")
		return FALSE

	if(!reusable)
		qdel(src)

/obj/item/disk/nifsoft_uploader/attack_self(mob/user, modifiers)
	attempt_software_install(user)

/obj/item/disk/nifsoft_uploader/attack(mob/living/mob, mob/living/user, params)
	if(mob != user && !do_after(user, 5 SECONDS, mob))
		balloon_alert(user, "installation failed")
		return FALSE

	attempt_software_install(mob)

#undef DEFAULT_NIFSOFT_COOLDOWN
