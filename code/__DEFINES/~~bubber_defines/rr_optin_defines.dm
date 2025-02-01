#define RR_OPT_IN_STRING "Yes"
#define RR_OPT_OUT_STRING "No"

/// Assoc list of stringified opt_in_## define to the front-end string to show users as a representation of the setting.
GLOBAL_LIST_INIT(rr_opt_in_strings, list(
	"1" = RR_OPT_IN_STRING,
	"0" = RR_OPT_OUT_STRING,
))

/// Assoc list of stringified opt_in_## define to the color associated with it.
GLOBAL_LIST_INIT(rr_opt_in_colors, list(
	RR_OPT_IN_STRING = COLOR_RED,
	RR_OPT_OUT_STRING = COLOR_EMERALD
))
