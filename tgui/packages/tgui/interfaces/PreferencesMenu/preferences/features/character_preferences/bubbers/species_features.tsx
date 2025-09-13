import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
  FeatureTextInput,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const emote_length: FeatureChoiced = {
  name: 'Preferred Emote Length',
  category: 'ADVERT',
  description:
    'What length of emote your prefer during an RP scene, if you have one. Shows on your Character Advert.',
  component: FeatureDropdownInput,
};

export const approach_pref: FeatureChoiced = {
  name: 'Preferred Approach Method',
  category: 'ADVERT',
  description:
    'How you would like to be approached for RP scenes, if at all. Shows on your Character Advert.',
  component: FeatureDropdownInput,
};

export const furry_pref: FeatureChoiced = {
  name: 'Attraction: Furries?',
  category: 'ADVERT',
  description:
    'How, and if, you would like to engage in RP with furry characters, such as Anthromorphs, Birdfolk or Insectoids.',
  component: FeatureDropdownInput,
};

export const scalie_pref: FeatureChoiced = {
  name: 'Attraction: Scalies?',
  category: 'ADVERT',
  description:
    'How, and if, you would like to engage in RP with scalie characters, such as Lizards, Fish, or Dragons.',
  component: FeatureDropdownInput,
};

export const other_pref: FeatureChoiced = {
  name: 'Attraction: Others?',
  category: 'ADVERT',
  description:
    'How, and if, you would like to engage in RP with outlandish characters, such as Silicons, Taurs, Megafauna and Xenos.',
  component: FeatureDropdownInput,
};

export const demihuman_pref: FeatureChoiced = {
  name: 'Attraction: Demihumans?',
  category: 'ADVERT',
  description:
    'How, and if, you would like to engage in RP with demihuman characters, such as cat or dog humans, monsterfolk or demons.',
  component: FeatureDropdownInput,
};

export const human_pref: FeatureChoiced = {
  name: 'Attraction: Humans?',
  category: 'ADVERT',
  description:
    'How, and if, you would like to engage in RP wih human characters. You know what a human is.',
  component: FeatureDropdownInput,
};

export const character_ad: Feature<string> = {
  name: 'Character Advert',
  description:
    'A roleplay advert for your character. Talk about what you are looking for in terms of roleplay, and how to approach. Give specifics as much as possible.',
  component: FeatureTextInput,
};

export const attraction: FeatureChoiced = {
  name: 'Character Attraction',
  description:
    'What classifies what your character is attracted to. This is displayed in the Directory.',
  component: FeatureDropdownInput,
};

export const display_gender: FeatureChoiced = {
  name: 'Character Gender',
  description:
    'What classifies as the gender for your character. This is displayed in the Directory.',
  component: FeatureDropdownInput,
};

export const flavor_text_nsfw: Feature<string> = {
  name: 'NSFW Flavor Text',
  description:
    'The NSFW part of your flavor text. Used to store visual sexual details.',
  component: FeatureTextInput,
};

export const silicon_flavor_text_nsfw: Feature<string> = {
  name: 'Silicon NSFW Flavor Text',
  description:
    'A portion of your flavor text that is stored in examine, used for Silicons. Used to store visual sexual details.',
  component: FeatureTextInput,
};

export const headshot_silicon: Feature<string> = {
  name: 'Silicon Headshot',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, starting with \
  https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
  Renders the image underneath your character preview in the examine more window. \
  Image larger than 250x250 will be resized to 250x250. \
  Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const headshot_nsfw: Feature<string> = {
  name: 'NSFW Headshot',
  description:
    'Headshot, but for NSFW references. \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
    Renders the image underneath your character preview in the examine more window. \
    Image larger than 250x250 will be resized to 250x250. \
    Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const headshot_silicon_nsfw: Feature<string> = {
  name: 'Silicon NSFW Headshot',
  description:
    'Headshot, but for NSFW references on Silicons. \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
    Renders the image underneath your character preview in the examine more window. \
    Image larger than 250x250 will be resized to 250x250. \
    Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const ooc_notes_silicon: Feature<string> = {
  name: 'OOC Notes (Silicon)',
  description: 'Same as OOC notes, but for your silicon character!',
  component: FeatureTextInput,
};

export const custom_species_silicon: Feature<string> = {
  name: 'Silicon Model Name',
  description:
    'The name of the module for your Silicon company, such as "Armadyne Pleasure Model."',
  component: FeatureShortTextInput,
};

export const custom_species_lore_silicon: Feature<string> = {
  name: 'Silicon Model Lore',
  description:
    'Lore for your silicon, typically its company, make, model, and details regarding its creation.',
  component: FeatureTextInput,
};

export const art_ref: Feature<string> = {
  name: 'Art Reference',
  description:
    'Art Reference that others can see for your character \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List.',
  component: FeatureShortTextInput,
};

export const art_ref_nsfw: FeatureToggle = {
  name: 'Art Reference NSFW',
  description: 'Is your reference picture NSFW?',
  component: CheckboxInput,
};
