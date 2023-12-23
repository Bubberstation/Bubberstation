import {
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureTextInput,
  FeatureShortTextInput,
} from '../../base';

export const character_ad: Feature<string> = {
  name: 'Character Advert',
  description:
    'An advertisement for your character. Give information on how to approach for those interested, for either regular and erotic roleplay.',
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

export const headshot_silicon: Feature<string> = {
  name: 'Headshot (Silicon)',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Gyazo or Discord. Renders the image underneath \
    your character preview in the examine more window.',
  component: FeatureShortTextInput,
};

export const ooc_notes_silicon: Feature<string> = {
  name: 'OOC Notes (Silicon)',
  description: 'Same as OOC notes, but for your silicon character!',
  component: FeatureTextInput,
};

export const custom_species_silicon: Feature<string> = {
  name: 'Custom Model Name',
  description:
    'The name of the module for your Silicon company, such as "Armadyne Pleasure Model."',
  component: FeatureShortTextInput,
};

export const custom_species_lore_silicon: Feature<string> = {
  name: 'Custom Model Lore',
  description:
    'Lore for your silicon, typically its company, make, model, and details regarding its creation.',
  component: FeatureTextInput,
};
