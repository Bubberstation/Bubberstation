///Upstream edits
//Sizecode
#undef BODY_SIZE_MAX
#undef BODY_SIZE_MIN

#define BODY_SIZE_MAX CONFIG_GET(number/body_size_max)
#define BODY_SIZE_MIN CONFIG_GET(number/body_size_min)

//sex
#define ORGAN_SLOT_BUTT "butt"
#define ORGAN_SLOT_BELLY "belly"
//arachnid organ slots

///arachnid organ slots
#define ORGAN_SLOT_EXTERNAL_MANDIBLES "mandibles"
#define ORGAN_SLOT_EXTERNAL_SPINNERET "spinneret"
#define ORGAN_SLOT_EXTERNAL_SPIDER_LEGS "spider_legs"

#define BUTT_MIN_SIZE 1
#define BUTT_MAX_SIZE 8
