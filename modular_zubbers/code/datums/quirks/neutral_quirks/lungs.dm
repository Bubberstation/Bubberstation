/datum/quirk/equipping/lungs
	abstract_parent_type = /datum/quirk/equipping/lungs
	icon = FA_ICON_LUNGS
	var/old_lungs = null
	var/lungs_typepath = /obj/item/organ/lungs
	stored_items = list(/obj/item/clothing/accessory/breathing = list(ITEM_SLOT_BACK))
	var/breath_type = "oxygen"

/datum/quirk/equipping/lungs/add(client/client_source)
	var/mob/living/carbon/human/carbon_holder = quirk_holder
	if (!istype(carbon_holder) || !lungs_typepath)
		return
	var/obj/item/organ/lungs/current_lungs = carbon_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if (istype(current_lungs, lungs_typepath))
		return
	old_lungs = current_lungs?.type
	var/obj/item/organ/lungs/lungs_added = new lungs_typepath
	lungs_added.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	carbon_holder.dna.species.mutantlungs = lungs_typepath

/datum/quirk/equipping/lungs/remove()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!istype(carbon_holder) || isnull(old_lungs))
		return
	var/obj/item/organ/lungs/new_lungs = new old_lungs
	new_lungs.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	carbon_holder.dna.species.mutantlungs = initial(carbon_holder.dna.species.mutantlungs)

/datum/quirk/equipping/lungs/on_equip_item(obj/item/equipped, success)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (!istype(equipped, /obj/item/clothing/accessory/breathing))
		return
	var/obj/item/clothing/accessory/breathing/acc = equipped
	acc.breath_type = breath_type
	if(!istype(human_holder))
		return
	var/obj/item/clothing/under/worn_uniform = human_holder.w_uniform
	if(!istype(worn_uniform))
		return
	worn_uniform.attach_accessory(acc, human_holder, attach_message = FALSE)

/obj/item/clothing/accessory/breathing
	name = "breathing dogtag"
	desc = "Dogtag that lists what you breathe."
	icon_state = "allergy"
	above_suit = FALSE
	minimize_when_attached = TRUE
	attachment_slot = CHEST
	var/breath_type

/obj/item/clothing/accessory/breathing/examine(mob/user)
	. = ..()
	. += "The dogtag reads: I breathe [breath_type]."

/obj/item/clothing/accessory/breathing/accessory_equipped(obj/item/clothing/under/uniform, user)
	. = ..()
	RegisterSignal(uniform, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/obj/item/clothing/accessory/breathing/accessory_dropped(obj/item/clothing/under/uniform, user)
	. = ..()
	UnregisterSignal(uniform, COMSIG_ATOM_EXAMINE)

/obj/item/clothing/accessory/breathing/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += "The dogtag reads: I breathe [breath_type]."

/datum/quirk/equipping/lungs/nitrogen
	name = "Nitrogen Breather"
	desc = "You breathe nitrogen, even if you might not normally breathe it. Oxygen is poisonous."
	icon = FA_ICON_BIOHAZARD
	medical_record_text = "Patient can only breathe nitrogen."
	gain_text = "<span class='danger'>You suddenly have a hard time breathing anything but nitrogen."
	lose_text = "<span class='notice'>You suddenly feel like you aren't bound to nitrogen anymore."
	value = 0
	forced_items = list(
		/obj/item/clothing/mask/breath = list(ITEM_SLOT_MASK),
		/obj/item/tank/internals/nitrogen/belt/full = list(ITEM_SLOT_HANDS, ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET))
	lungs_typepath = /obj/item/organ/lungs/nitrogen
	breath_type = "nitrogen"

/datum/quirk/equipping/lungs/nitrogen/add(client/client_source)
	if(isjellyperson(quirk_holder))
		lungs_typepath = /obj/item/organ/lungs/nitrogen/slime_lungs
	. = ..()

/datum/quirk/equipping/lungs/nitrogen/on_equip_item(obj/item/equipped, success)
	. = ..()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!success || !istype(carbon_holder) || !istype(equipped, /obj/item/tank/internals))
		return
	carbon_holder.internal = equipped

