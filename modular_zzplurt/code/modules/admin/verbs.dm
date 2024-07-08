ADMIN_VERB(toggle_admin_freeze, R_ADMIN, "Toggle Freeze Mob", "Freezes / unfreezes a mob's movement", ADMIN_CATEGORY_GAME, mob/living/target in world)
	target.toggle_admin_freeze(user)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Freeze Mob")

ADMIN_VERB(toggle_admin_sleep, R_ADMIN, "Toggle Sleep Mob", "Sleeps / unsleeps a mob", ADMIN_CATEGORY_GAME, mob/living/target in world)
	target.toggle_admin_sleep(user)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Sleep Mob")
