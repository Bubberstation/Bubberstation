/datum/action/cooldown/spell/toggle_eye_shields
	name = "Toggle Eye Shields"
	desc = "Toggle your protective eye shields."
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas_eyeshield"
	spell_requirements = null

/datum/action/cooldown/spell/toggle_eye_shields/cast(atom/cast_on)
	. = ..()
	var/obj/item/organ/eyes/serpentid/eyes = owner?.get_organ_slot(ORGAN_SLOT_EYES)
	var/mob/living/carbon/human/human_owner = owner
	if(!eyes)
		return
	if(!eyes.eyes_shielded)
		to_chat(owner, span_notice("Nearly opaque lenses slide down to shield your eyes."))
		eyes.eyes_shielded = TRUE
		eyes.flash_protect = FLASH_PROTECTION_WELDER_SENSITIVE
		owner.overlay_fullscreen("eyeshield", /atom/movable/screen/fullscreen/blind)
		human_owner.set_eye_color("#AAAAAA")
		human_owner.dna.update_ui_block((/datum/dna_block/identity/eye_colors))
		human_owner.update_body()
	else
		to_chat(owner, span_notice("Your protective lenses retract out of the way."))
		eyes.eyes_shielded = FALSE
		eyes.flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
		owner.clear_fullscreen("eyeshield")
		human_owner.set_eye_color(sanitize_hexcolor(human_owner.client?.prefs?.read_preference(/datum/preference/color/eye_color)))
		human_owner.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
		human_owner.update_body()

/datum/action/cooldown/spell/toggle_active_camo
	name = "Toggle Active Camo"
	desc = "Toggle your active camo ability, becoming more translucent.."
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas-cloak-0"
	spell_requirements = null

/datum/action/cooldown/spell/toggle_active_camo/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/toggle_active_camo/cast(atom/target)
	. = ..()
	var/obj/item/organ/heart/serpentid/heart = owner?.get_organ_slot(ORGAN_SLOT_HEART)
	heart.toggle_camo(target)
	if(heart.camouflaged)
		update_button_state("gas-cloak-1")
	else
		update_button_state("gas-cloak-0")
