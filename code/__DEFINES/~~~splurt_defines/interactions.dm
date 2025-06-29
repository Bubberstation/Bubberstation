/// Extra interaction checks.

// A person needs to have mouth available to do this interaction
#define INTERACTION_REQUIRE_SELF_MOUTH "self_mouth"
#define INTERACTION_REQUIRE_TARGET_MOUTH "target_mouth"

// A person needs to have their top clothes removed to do this interaction
#define INTERACTION_REQUIRE_SELF_TOPLESS "self_topless"
#define INTERACTION_REQUIRE_TARGET_TOPLESS "target_topless"

// A person needs to have their bottom clothes removed to do this interaction
#define INTERACTION_REQUIRE_SELF_BOTTOMLESS "self_bottomless"
#define INTERACTION_REQUIRE_TARGET_BOTTOMLESS "target_bottomless"

// A person needs to have their feet exposed to do this interaction
#define INTERACTION_REQUIRE_SELF_FEET "self_feet"
#define INTERACTION_REQUIRE_TARGET_FEET "target_feet"

/// Climax definitions

//Climaxing genitals
#define CLIMAX_VAGINA "vagina"
#define CLIMAX_PENIS "penis"
#define CLIMAX_BOTH "both"

//Climaxing positions
#define CLIMAX_POSITION_USER "climax_user"
#define CLIMAX_POSITION_TARGET "climax_target"

//Climaxing targets (use these if you're not using organ slots)
#define CLIMAX_TARGET_MOUTH "mouth"
#define CLIMAX_TARGET_SHEATH "sheath"

// Extreme types
#define INTERACTION_EXTREME (1<<0)
#define INTERACTION_HARMFUL (1<<1) // If you use this on an interaction, add INTERACTION_EXTREME to it as well
#define INTERACTION_UNHOLY (1<<2)

// Interaction categories
#define INTERACTION_CAT_LEWD "lewd"
#define INTERACTION_CAT_EXTREME "extreme"
#define INTERACTION_CAT_HARMFUL "harmful"
#define INTERACTION_CAT_UNHOLY "unholy"

// Additional details sent to the interaction menu
#define INTERACTION_FILLS_CONTAINERS list( \
	"info" = "You can fill a container if you have it in your active hand or are pulling it", \
	"icon" = "flask", \
	"color" = "transparent" \
	)

// Interaction flags (used for logic but normally not sent to the interaction menu)
#define INTERACTION_OVERRIDE_FLUID_TRANSFER (1<<0)
