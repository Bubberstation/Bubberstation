/obj/item/nanite_injector
	name = "nanite injector (FOR TESTING)"
	desc = "Injects nanites into the user."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_zubbers/code/modules/nanites/icons/nanite_devices.dmi'
	icon_state = "nanite_remote"

/obj/item/nanite_injector/attack_self(mob/user)
	user.AddComponent(/datum/component/nanites, 150)
