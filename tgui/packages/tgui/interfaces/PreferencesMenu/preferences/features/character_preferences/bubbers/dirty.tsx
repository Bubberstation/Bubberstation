import { FeatureColorInput, FeatureTextInput, type Feature } from '../../base';

export const dirty_quirk_color: Feature<string> = {
  name: 'Dirt Color',
  component: FeatureColorInput,
};

export const dirty_quirk_text: Feature<string> = {
  name: 'Flavor text',
  description:
    'Displayed when you are dirty.',
  component: FeatureTextInput,
};
