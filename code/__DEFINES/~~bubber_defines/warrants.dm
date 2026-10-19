/// Set by a department guard. Stop and question, not an arrest order.
#define WANTED_GUARD_ALERT "Alert"
/// Death warrant. Subject is an uncontainable hostile, lethal force authorized on sight.
#define WANTED_EXECUTE "Execute"

/// Longest a stated death warrant reason may be. It goes out over the announcement system.
#define WARRANT_REASON_MAX_LENGTH 128

/// No standing to touch warrant statuses at all.
#define WARRANT_AUTH_NONE 0
/// Department guard. May set Alert, clear one, and flag persons of interest.
#define WARRANT_AUTH_GUARD 1
/// Security proper. Full standard picker plus Alert.
#define WARRANT_AUTH_SECURITY 2
/// Captain or Head of Security. Everything, including death warrants at amber+.
#define WARRANT_AUTH_COMMAND 3

/// Full status list for display, in severity order: the vanilla set with Alert slotted after Suspected and Execute at the top of the escalation.
#define WANTED_STATUSES_WITH_WARRANTS(...) list(\
	WANTED_NONE, \
	WANTED_SUSPECT, \
	WANTED_GUARD_ALERT, \
	WANTED_ARREST, \
	WANTED_EXECUTE, \
	WANTED_PRISONER, \
	WANTED_PAROLE, \
	WANTED_DISCHARGED, \
)

/// Incident categories picked when setting an Alert, so reports stay structured rather than free-text.
#define ALERT_REASON_SUSPICIOUS "Suspicious activity"
#define ALERT_REASON_TRESPASS "Trespass / ejected"
#define ALERT_REASON_VIOLENT "Violent or disruptive"
#define ALERT_REASON_CONTRABAND "Suspected contraband"
#define ALERT_REASON_ASSISTANCE "Security assistance requested"
#define ALERT_REASON_OTHER "Other"

#define ALERT_REASONS(...) list(\
	ALERT_REASON_SUSPICIOUS, \
	ALERT_REASON_TRESPASS, \
	ALERT_REASON_VIOLENT, \
	ALERT_REASON_CONTRABAND, \
	ALERT_REASON_ASSISTANCE, \
	ALERT_REASON_OTHER, \
)

/// What an emagged sechud writes into a record in place of its wearer. Admin logs still record the real person.
#define WARRANT_ANONYMOUS_REPORTERS(...) list(\
	"NOBODY", \
	"THE SYNDICATE", \
	"THE CLOWN", \
	"Ë̸̢Ŕ̷̩R̸̡̈́Ọ̴̓Ṙ̷̺", \
	"Nar'Sie", \
	"Ratvar", \
	"the Honkmother", \
	"the Supermatter", \
	"the Singularity", \
	"Central Command", \
	"Beepsky", \
	"Ian", \
	"Poly", \
	"Runtime", \
	"a space carp", \
	"several bees", \
	"a passing moth", \
	"the Blob", \
	"the vending machine", \
	"the gravity generator", \
	"the Chaplain's null rod", \
	"an anonymous tipster", \
	"YOURSELF", \
	"THE VOID", \
)
