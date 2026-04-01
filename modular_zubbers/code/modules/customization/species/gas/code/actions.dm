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
	desc = "Toggle your active camo ability, becoming more translucent."
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

/datum/action/cooldown/spell/toggle_threat_display
	name = "Toggle Threat Display"
	desc = "Toggle your threat display, letting your enemies know that you are ready for a fight!"
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas-threat"
	spell_requirements = null

/datum/species/gas
	var/displaying_threat = FALSE
	var/image/threat_overlay

/datum/action/cooldown/spell/toggle_threat_display/cast(atom/target)
	. = ..()
	if(!isgas(owner))
		return
	var/mob/living/carbon/human/snake_owner = owner
	var/datum/species/gas/gas_species = snake_owner.dna.species
	if(owner.incapacitated)
		to_chat(owner, span_warning("You can't do a threat display in your current state."))
		return
	if(gas_species.displaying_threat == FALSE)
		gas_species.threat_overlay = image('modular_skyrat/modules/bodyparts/icons/serpentid_parts_greyscale.dmi', "threat", MOB_LAYER)
		var/message = tgui_alert(owner, "Would you like to show a scary message?", "Be Scary", list("Yes", "No", "Cancel"))
		if(message == "Cancel")
			return
		else if(message == "Yes")
			owner.visible_message(span_warning("\The [owner]'s skin shifts to a deep red colour with dark chevrons running down in an almost hypnotic \
				pattern. Standing tall, [owner.p_they()] strikes, sharp spikes aimed at those threatening [owner.p_them()], claws whooshing through the air past them."))
		playsound(owner.loc, 'modular_skyrat/modules/emotes/sound/emotes/angryserpentid.ogg', 60, 0)
		gas_species.displaying_threat = TRUE
		snake_owner.add_overlay(gas_species.threat_overlay)
	else
		snake_owner.cut_overlay(gas_species.threat_overlay)
		gas_species.displaying_threat = FALSE
