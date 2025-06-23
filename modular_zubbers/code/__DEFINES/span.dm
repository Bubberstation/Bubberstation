#define span_center(str) ("<span class='center'>[str]</span>")

/// A key:value pair list for spans, used in circuitry to determine the color of a message and to allow Var Editing by admins. Safest way to implement while preventing people from inputting their own spans in circuits.
GLOBAL_LIST_INIT(component_span_color_list, list(
	"Default" = "span_hear",
	"Green" = "radio",
	"Purple" = "sciradio",
	"Yellow" = "comradio",
	"Red" = "secradio",
	"Blue" = "medradio",
	"Orange" = "engradio",
	"Brown" = "suppradio",
	"Maroon" = "syndradio",
	"Pink" = "aiprivradio"
))
