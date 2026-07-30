/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp
	name = "\improper NT22-HCS 'Enforcer' case"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ntusp(src)
	new /obj/item/ammo_box/magazine/recharge/ntusp(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5
	name = "\improper NT22-HCS-MP 'Lancer' case"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield
	name = "\improper DAP NT22-HCS-MP 'Lancer' case"
	desc = "A thick gun case with foam inserts laid out to fit a weapon, magazines, and gear securely. On the top is a silver plaque, emblazoned with the symbol of a shield with D.A.P. written on it in bold."

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5/laser(src)
	new /obj/item/suppressor(src)
	new /obj/item/paper/fluff/ntmp5_message(src)

/obj/item/paper/fluff/ntmp5_message
	name = "message from a friend"
	default_raw_text = {"Agent,
<br>
This station is worse than what they put in the reports. You'll figure it quickly enough, if you haven't already.
Well, someone in the DAP thought it'd best you went in properly equipped. Consider it a courtesy.
This is a Lancer, a NT22-HCS-MP. .22HL, battery-fed. Two of the magazines shoot less-than-lethal projectiles. The red one, well, let's just say they're a fair bit more lethal.
You'll also find a suppressor in there. I'm sure it speaks for itself.
Stay sharp.
<br>
-*A Friend in Asset Protection*"}
