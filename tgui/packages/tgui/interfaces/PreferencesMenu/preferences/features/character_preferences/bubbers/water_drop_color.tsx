import { type Feature, FeatureColorInput } from '../../base';

export const input_dripping_color: Feature<string> = {
  name: 'Custom color',
  description: 'The color of your droplets.',
  component: FeatureColorInput,
};
