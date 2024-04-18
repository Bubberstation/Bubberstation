/obj/item/clothing/mask/gas/sechailer
	// Did the hailer get EMP'd?
	var/emped = FALSE
	var/radio_key = /obj/item/encryptionkey/headset_sec
	var/obj/item/radio/radio
	COOLDOWN_DECLARE(backup_cooldown)

/datum/action/item_action/backup
	name = "Backup!"

/obj/item/clothing/mask/gas/sechailer/New()
	. = ..()
	actions_types += list(/datum/action/item_action/backup)
/// Add the Radio
/obj/item/clothing/mask/gas/sechailer/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/item/clothing/mask/gas/sechailer/Destroy()
	QDEL_NULL(radio)
	. = ..()
/// If EMP'd, become EMP'd
/obj/item/clothing/mask/gas/sechailer/emp_act(severity)
	. = ..()
	if(!emped)
		balloon_alert(src, "Backup Hailer Malfunctioning!")
		emped = TRUE
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/clothing/mask/gas/sechailer, emp_reset)), 2 MINUTES)

/// Reset EMP after 2 minutes
/obj/item/clothing/mask/gas/sechailer/proc/emp_reset()
	SIGNAL_HANDLER

	balloon_alert(src, "Backup Hailer Recalibrated")
	emped = FALSE

/obj/item/clothing/mask/gas/sechailer/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/backup))
		backup()

/// Main backup UI button
/obj/item/clothing/mask/gas/sechailer/verb/backup(mob/living/owner)
	set category = "Object"
	set category = "Backup!"
	set src in usr
	var/location = get_area_name(get_turf(src))

	if (!isliving(owner) || !can_use(owner))
		return
	if (!COOLDOWN_FINISHED(src, backup_cooldown))
		balloon_alert(owner, "On Cooldown!")
	if (emped)
		balloon_alert(owner, "Backup Malfunctioning!")
	else
		radio.talk_into(owner, "Backup Requested in [location]!", RADIO_CHANNEL_SECURITY)
		owner.audible_message("<font color='red' size='5'><b>BACKUP REQUESTED!</b></font>")
		balloon_alert_to_viewers("Backup Requested!", "Backup Requested!", 7)
		log_combat(owner, what_done = "has called for backup", object = src)
		playsound(owner, 'sound/misc/whistle.ogg', 50, FALSE, 4)

