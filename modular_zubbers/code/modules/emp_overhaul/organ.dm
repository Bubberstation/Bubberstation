// https://www.desmos.com/calculator/7sdtn22uda

/obj/item/bodypart/emp_act(severity)

	if(!(src.biological_state & BIO_STANDARD_JOINTED) && !prob((src.brute_dam + src.burn_dam)*2*(2/severity))) //Chance to get EMP'd is based on self bodypart damage.
		return EMP_PROTECT_ALL

	. = ..()

/obj/item/organ/emp_act(severity) //Internal organs..

	if(src.bodypart_owner && !(src.bodypart_owner.biological_state & BIO_STANDARD_JOINTED) && !prob((src.bodypart_owner.brute_dam + src.bodypart_owner.burn_dam)*2*(2/severity))) //Chance to get EMP'd is based on attached bodypart damage.
		return EMP_PROTECT_ALL

	. = ..()
