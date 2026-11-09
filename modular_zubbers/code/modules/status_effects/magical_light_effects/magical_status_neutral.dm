/datum/status_effect/magical_light/fake_rad
	id = "magical_light_fake_rad"
	duration = 6 MINUTES
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = null
	special_description = "a harmless effect similar to irradiation"

/datum/status_effect/magical_light/fake_rad/on_apply()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	human_owner.throw_alert(ALERT_IRRADIATED, /atom/movable/screen/alert/irradiated)
	human_owner.add_filter("rad_glow", 2, list("type" = "outline", "color" = "#39ff1430", "size" = 2))
	var/filter = human_owner.get_filter("rad_glow")
	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)
	return TRUE

/datum/status_effect/magical_light/fake_rad/on_remove()
	if(owner.GetComponent(/datum/component/irradiated) || !ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	human_owner.remove_filter("rad_glow")
	human_owner.clear_alert(ALERT_IRRADIATED)

/datum/status_effect/magical_light/eye_glow
	id = "magical_light_eye_glow"
	duration = 1 MINUTES
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/magical_light
	special_description = "a glowing effect on one's retina"
	var/obj/item/flashlight/eyelight/eye

/datum/status_effect/magical_light/eye_glow/on_apply()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	eye = new /obj/item/flashlight/eyelight()
	eye.set_light_on(TRUE)
	eye.forceMove(human_owner)
	eye.update_brightness(human_owner)
	return TRUE

/datum/status_effect/magical_light/eye_glow/on_remove()
	eye.set_light_on(FALSE)
	eye.update_brightness(owner)
	QDEL_NULL(eye)
