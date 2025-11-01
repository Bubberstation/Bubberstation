
/obj/item/rbmk_upgrade
	name = "\improper RB-MK2 software upgrade disk"
	desc = "It seems to be empty. Good fucking job, coders."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "datadisk2"

/obj/item/rbmk_upgrade/proc/apply_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

/obj/item/rbmk_upgrade/proc/can_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

//machine handles it.
/obj/machinery/power/rbmk2/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(istype(tool,/obj/item/rbmk_upgrade))
		var/obj/item/rbmk_upgrade/upgrade_disk = tool
		if(upgrade_disk.can_upgrade(src))
			upgrade_disk.apply_upgrade(src)
			balloon_alert(user, "upgraded!")
		else
			balloon_alert(user, "can't upgrade!")
		return TRUE


	. = ..()


//Auto Vent
/obj/item/rbmk_upgrade/auto_vent
	name = "\improper RB-MK2 software upgrade disk - auto vent"
	desc = "A disk that allows you to install an upgrade into the RB-MK that automatically controls vent usage to maximize power gain at all temperature setups."

/obj/item/rbmk_upgrade/auto_vent/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.auto_vent_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/auto_vent/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.auto_vent_upgrade

//Safeties
/obj/item/rbmk_upgrade/safeties
	name = "\improper RB-MK2 software upgrade disk - safeties optimization"
	desc = "A disk that allows you to install an upgrade into the RB-MK that effectively decreases the safeties threshold from 75% to 95%, preventing premature ejectulation."

/obj/item/rbmk_upgrade/safeties/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.safeties_upgrade = TRUE
	machine.RefreshParts()
	return TRUE

/obj/item/rbmk_upgrade/safeties/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.safeties_upgrade

//Overclock
/obj/item/rbmk_upgrade/overclock
	name = "\improper RB-MK2 software upgrade disk - overclock"
	desc = "A disk that allows you to install an upgrade into the RB-MK that enables overlocking of the reactor."

/obj/item/rbmk_upgrade/overclock/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.overclocked_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/overclock/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.overclocked_upgrade




