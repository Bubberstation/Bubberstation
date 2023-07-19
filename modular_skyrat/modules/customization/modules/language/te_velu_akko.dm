/datum/language/akulan
    name = "Te Velu Akko"
    desc = "Translating from 'The Song of The King' this Azulean language is known for its rapid learning pace, featuring hard consonants followed by soft vowel strings. \
It has an underwater component emphasizing physical proximity, pitch variations, high-frequency sounds, and clicking. "


    key = "Z"
    flags = TONGUELESS_SPEECH
    space_chance = 70
    // Syllables derived from the Maori language.
    syllables = list (
        "ā", "ē", "ī", "ō", "a", "e", "i", "o", "u", "ha", "he", "hi", "ho", "hu", "ka", "ke", "ki", "ko", "ku", "ma", "me", "mi", "mo", "mu", "na", "ne", "ni", "no", "nu",
        "nga", "nge", "ngi", "ngo", "ngu", "pa", "pe", "pi", "po", "pu", "ra", "re", "ri", "ro", "ru", "ta", "te", "ti", "to", "tu", "wa", "we", "wi", "wo", "wu", "wha", "whe", "whi",
    )
    icon_state = "azulean"
    icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
    default_priority = 94
