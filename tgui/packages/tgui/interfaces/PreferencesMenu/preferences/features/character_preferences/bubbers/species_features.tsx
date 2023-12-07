import { Feature, FeatureChoiced, FeatureDropdownInput, FeatureTextInput } from '../../base';

export const character_ad: Feature<string> = {
  name: 'Character Ad',
  description:
    'An advertisement for your character. Give information on how to approach for those interested, for either regular and erotic roleplay.',
  component: FeatureTextInput,
};

export const attraction: FeatureChoiced = {
  name: 'Attraction',
  description: 'The attraction for your character, displayed in the Directory.',
  component: FeatureDropdownInput,
};

export const display_gender: FeatureChoiced = {
  name: 'Gender',
  description: 'The gender for your character, displayed in the Directory.',
  component: FeatureDropdownInput,
};
