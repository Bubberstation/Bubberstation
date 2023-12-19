import { Feature, FeatureChoiced, FeatureDropdownInput, FeatureTextInput, FeatureShortTextInput } from '../../base';

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
