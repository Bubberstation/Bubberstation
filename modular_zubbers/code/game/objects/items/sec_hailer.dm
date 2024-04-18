/obj/item/clothing/mask/gas/sechailer
	// Did the hailer get EMP'd?
	var/emped = FALSE
	COOLDOWN_DECLARE(backup_cooldown)

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
		balloon_alert(user, "Backup Hailer Malfunctioning!")
		emped = TRUE
		AddTimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/clothing/mask/gas/sechailer), emp_reset), 2 MINUTES)

/// Reset EMP after 2 minutes
/obj/item/clothing/mask/gas/sechailer/proc/emp_reset()
	balloon_alert(user, "Backup Hailer Recalibrated")
	emped = FALSE

/obj/item/clothing/mask/gas/sechailer/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/backup))
		backup()

/obj/item/clothing/mask/gas/sechailer/verb/backup()
	set category = "Object"
	set category = "Backup!"
	set src in usr
	if (!isliving(usr) || !can_use(usr))
		return
	if (!COOLDOWN_FINISHED(src, backup_cooldown))
		balloon_alert(user, "On Cooldown!")
	if (emped)
		balloon_alert(user, "Backup Malfunctioning!")
	else
		radio.talk_into(src, "Backup Requested in [location]!")
		user.audible_message("<font color='red' size='5'><b>BACKUP REQUESTED!</b></font>")
		balloon_alert_to_viewers("Backup Requested!", "Backup Requested!", 7)
		play_sound(src, 'sound/misc/whistle.ogg', 50, FALSE, 4)

