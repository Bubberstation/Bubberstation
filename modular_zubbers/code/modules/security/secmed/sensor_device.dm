/obj/item/sensor_device/secmed
	name = "security medic's handheld monitor"
	desc = "A unique model of the handheld crew monitors that seems to have been customized for security medics."
	icon = 'modular_zubbers/icons/obj/scanner.dmi'
	icon_state = "secmed_crewmonitor"

/obj/item/sensor_device/secmed/attack_self(mob/user)
	GLOB.secmed_crewmonitor.show(user,src)
