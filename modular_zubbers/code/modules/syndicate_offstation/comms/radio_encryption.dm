//encryption keys
/obj/item/encryptionkey/headset_syndicate/cybersun
	name = "cybersun radio encryption key"
	channels = list(RADIO_CHANNEL_CYBERSUN = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/headset_syndicate/interdyne
	name = "Interdyne radio encryption key"
	channels = list(RADIO_CHANNEL_INTERDYNE = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

//radios
/obj/item/radio/headset/syndicateciv
	name = "Syndicate Civilian headset"
	desc = "A bowman headset with a large red cross on the earpiece, it has a small three headed snake on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = null

/obj/item/radio/headset/syndicateciv/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/syndicateciv/staff
	keyslot = /obj/item/encryptionkey/headset_syndicate/cybersun

/obj/item/radio/headset/syndicateciv/command
	name = "Syndicate command headset"
	desc = "A commanding headset to gather your minions. Protects the ears from flashbangs."
	command = TRUE
	keyslot = /obj/item/encryptionkey/headset_syndicate/cybersun

//comms operative headset
/obj/item/radio/headset/syndicateciv/comms
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = /obj/item/encryptionkey/syndicate


