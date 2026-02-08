/datum/uplink_item/New()
	. = ..()
	if(limited_stock > 0 || limited_discount_stock > 1)
		limited_discount_stock = 1
