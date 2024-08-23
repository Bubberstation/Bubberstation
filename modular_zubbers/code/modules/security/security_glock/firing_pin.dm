/obj/item/firing_pin/alert_level/blue
	name = "alert level firing pin"
	desired_minimium_alert = SEC_LEVEL_BLUE
	desc = "A small authentication device, to be inserted into a firearm receiver to allow operation. This one is configured to only fire on blue alert or higher."
	fail_message = "incorrect alert level!"

/obj/item/firing_pin/alert_level/pin_auth(mob/living/user)
	return (SSsecurity_level.current_security_level.number_level >= desired_minimium_alert)
