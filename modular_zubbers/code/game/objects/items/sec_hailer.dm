/obj/item/clothing/mask/gas/sechailer
	// Did the hailer get EMP'd?
	var/emped = FALSE
	var/radio_key = /obj/item/encryptionkey/headset_sec
	var/obj/item/radio/radio
	COOLDOWN_DECLARE(backup_cooldown)
	actions_types = list(/datum/action/item_action/backup, /datum/action/item_action/halt, /datum/action/item_action/adjust)

/datum/action/item_action/backup
	name = "BACKUP"

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
	if(istype(action, /datum/action/item_action/backup))
		backup()
	if(istype(action, /datum/action/item_action/halt))
		halt()
	else
		adjustmask(user)

/// Main backup UI button
/obj/item/clothing/mask/gas/sechailer/verb/backup()
	set category = "Object"
	set category = "BACKUP"
	set src in usr
	var/location = get_area_name(get_turf(src))

	if (!isliving(usr) || !can_use(usr))
		return
	if (!COOLDOWN_FINISHED(src, backup_cooldown))
		balloon_alert(usr, "On Cooldown!")
		return
	if (emped)
		balloon_alert(usr, "Backup Malfunctioning!")
	else
		COOLDOWN_START(src, backup_cooldown, 1 MINUTES)
		radio.talk_into(usr, "Backup Requested in [location]!", RADIO_CHANNEL_SECURITY)
		usr.audible_message("<font color='red' size='5'><b>BACKUP REQUESTED!</b></font>")
		balloon_alert_to_viewers("Backup Requested!", "Backup Requested!", 7)
		log_combat(usr, what_done = "has called for backup", object = src)
		playsound(usr, 'sound/misc/whistle.ogg', 50, FALSE, 4)

