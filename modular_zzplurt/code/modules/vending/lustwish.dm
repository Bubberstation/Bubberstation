#define STOCK_NIFSOFT 6

// Based on Skyrat's vending overrides
/obj/machinery/vending/dorms
	// New premium items
	zzplurt_premium = list(
		// Original software
		// This is in the PDA
		/*
		/obj/item/disk/nifsoft_uploader/dorms/hypnosis = STOCK_NIFSOFT,
		/obj/item/disk/nifsoft_uploader/shapeshifter = STOCK_NIFSOFT,
		*/

		// New software
		/obj/item/disk/nifsoft_uploader/dorms/nif_disrobe_disk = STOCK_NIFSOFT,
		/obj/item/disk/nifsoft_uploader/nif_hide_backpack_disk = STOCK_NIFSOFT,
		/obj/item/disk/nifsoft_uploader/dorms/nif_gfluid_disk = STOCK_NIFSOFT,
	)

#undef STOCK_NIFSOFT
