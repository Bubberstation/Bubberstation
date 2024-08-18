/obj/item/gun/syringe/rapidsyringe/safe
	name = "specimen sedation gun"
	desc = "A high-powered syringe gun, designed to sedate specimens, holds six syringes, with a weaker spring to prevent harming your specimen."

/obj/item/gun/syringe/rapidsyringe/safe/recharge_newshot()
	. = ..()
	if(!chambered || !chambered.loaded_projectile)
		return
	chambered.loaded_projectile.damage = 0
	chambered.harmful = FALSE
