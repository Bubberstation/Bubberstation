// In vorecode, they're defined at code/_helpers/global_lists_vr.dm but we dont have that path at all, and I dont think it's a very good
// path for a global lists file when there's code/_global_vars/lists as a directory. Im just putting this here for now. -Reo

//Blacklist to exclude items from object ingestion. Digestion blacklist located in digest_act_vr.dm
var/global/list/item_vore_blacklist = list(
		/obj/item/hand_tele,
		//obj/item/weapon/card/id/gold/captain/spare, //Hugbox
		/obj/item/gun,
		/obj/item/pinpointer,
		/obj/item/clothing/shoes/magboots,
		/obj/item/areaeditor/blueprints,
		/obj/item/clothing/head/helmet/space,
		/obj/item/disk/nuclear
		//obj/item/clothing/suit/storage/hooded/wintercoat/roiz //You fluff decrease
		)

var/global/list/edible_trash = list(
				///obj/item/broken_device,				//Doesnt exist
				/obj/item/clothing/neck/petcollar,
				///obj/item/device/communicator,		// Doesnt exist
				/obj/item/clothing/mask,
				/obj/item/clothing/glasses,
				/obj/item/clothing/gloves,
				/obj/item/clothing/head,
				/obj/item/clothing/shoes,
				/obj/item/aicard, //Repathed from /obj/item/device/aicard
				/obj/item/flashlight,
				/obj/item/mmi/posibrain,
				/obj/item/paicard,
				/obj/item/pda,
				/obj/item/radio/headset,
				///obj/item/device/starcaster_news,		//Doesnt exist
				///obj/item/inflatable/torn,			//Doesnt exist
				/obj/item/organ,
				/obj/item/stack/sheet/cardboard,
				/obj/item/toy,
				/obj/item/trash,
				///obj/item/weapon/digestion_remains,	// No former cuties (yet?)
				/obj/item/grown/bananapeel,
				///obj/item/weapon/bone,				// Doesnt exist
				/obj/item/broken_bottle,
				/obj/item/card/emagfake,
				/obj/item/cigbutt,
				/obj/item/circuitboard,
				/obj/item/clipboard,
				/obj/item/grown/corncob,
				/obj/item/dice,
				/obj/item/match,	//Repathed from /obj/item/weapon/flame
				/obj/item/lighter,	//Added since they dont share a path of /flame anymore.
				/obj/item/light,
				/obj/item/lipstick,
				/obj/item/shard,
				/obj/item/newspaper,
				/obj/item/paper,
				/obj/item/paperplane,
				/obj/item/pen,
				/obj/item/photo,
				/obj/item/reagent_containers/food,
				/obj/item/reagent_containers/rag,
				/obj/item/soap,
				/obj/item/stack/spacecash,
				/obj/item/storage/box/matches,
				///obj/item/storage/box/wings,	//Doesnt exist
				/obj/item/storage/fancy/candle_box,
				/obj/item/storage/fancy/cigarettes,
				/obj/item/storage/crayons,
				/obj/item/storage/fancy/egg_box,
				/obj/item/storage/wallet,
				///obj/item/weapon/storage/vore_egg,	//Doesnt exist
				///obj/item/weapon/bikehorn/tinytether,	//Doesnt exist
				///obj/item/capture_crystal,			//Still doesnt exist.
				/obj/item/kitchen,
				/obj/item/storage/box/mre,
				///obj/item/storage/mrebag,				//Doesnt exist
				///obj/item/weapon/storage/fancy/crackers,	//Doesnt exist
				///obj/item/weapon/storage/fancy/heartbox,	//Doesnt exist
				///obj/item/pizzavoucher,				//Doesnt exist. Probably should, actually
				/obj/item/pizzabox,
				/obj/item/seeds,
				///obj/item/clothing/accessory/choker,	//Doesnt exist
				/obj/item/clothing/accessory/medal,
				/obj/item/clothing/neck/tie,
				/obj/item/clothing/neck/scarf,
				///obj/item/clothing/accessory/bracelet,	//Doesnt exist
				///obj/item/clothing/accessory/locket,	//Doesnt exist
				/obj/item/storage/book/bible,
				/obj/item/bikehorn,
				//obj/item/inflatable/door/torn,	//Doesnt exist
				/obj/item/reagent_containers/rag/towel,	//Repath from /obj/item/towel
				/obj/item/folder,
				/obj/item/clipboard,
				/obj/item/coin,
				/obj/item/clothing/ears
				)
