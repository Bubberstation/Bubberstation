/obj/machinery/computer/arcade/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/stack/arcadeticket))
		var/obj/item/stack/arcadeticket/T = O
		T.pay_tickets()
		prizevend(user)
		to_chat(user, span_notice("You turn in 1 ticket and claim a prize from [src]!"))
		return

/obj/item/stack/arcadeticket/pay_tickets()
	amount -= 1
	if (amount <= 0)
		qdel(src)
	else
		update_appearance()
