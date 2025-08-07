import { type Feature, FeatureSliderInput } from '../../base';

export const sound_emote: Feature<number> = {
  name: 'Emote sound volume',
  category: 'SOUND',
  description: 'Volume of audible emotes.',
  component: FeatureSliderInput,
};
