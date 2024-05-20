// https://www.desmos.com/calculator/7sdtn22uda

/obj/item/bodypart/emp_act(severity)

	if(src.biological_state & BIO_WIRED)
		if(!prob((src.get_damage() - 20)*2*(2/severity))) //Chance to get EMP'd is based on self bodypart damage.
			if(src.biological_state & BIO_JOINTED)
				return EMP_PROTECT_SELF //This will still apply the damage, but not the paralysis. Stun is still applied!
			return EMP_PROTECT_ALL

	. = ..()

/obj/item/organ/emp_act(severity) //Internal organs.

	if(src.bodypart_owner && (src.bodypart_owner.biological_state & BIO_WIRED) && !prob((src.bodypart_owner.get_damage() - 20)*2*(2/severity))) //Chance to get EMP'd is based on attached bodypart damage.
		return EMP_PROTECT_ALL

	. = ..()
