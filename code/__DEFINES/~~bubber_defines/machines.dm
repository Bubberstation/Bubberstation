// Reasons for delam suppression
/// player button push
#define SCRAM_TRIGGER_PUSHED "trigger_pushed"
/// integrity hit minimum
#define SCRAM_AUTO_FIRE "auto_fire"
/// admin fuckery
#define SCRAM_DIVINE_INTERVENTION "divine_intervention"
/// how long from roundstart the scram is functional
#define SCRAM_TIME_RESTRICTION (1 * 30 MINUTES)

// Export gate settings
#define EX_CARGO_TECHNICIAN (1<<0)
#define EX_CUSTOMS_AGENT (1<<1)
#define EX_QUARTERMASTER (1<<2)

DEFINE_BITFIELD(payment_mode, list(
	"EX_CARGO_TECHNICIAN" = EX_CARGO_TECHNICIAN,
	"EX_CUSTOMS_AGENT" = EX_CUSTOMS_AGENT,
	"EX_QUARTERMASTER" = EX_QUARTERMASTER,
))
