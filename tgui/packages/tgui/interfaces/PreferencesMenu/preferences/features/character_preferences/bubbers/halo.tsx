import { type Feature, FeatureColorInput } from '../../base';

export const halo_color: Feature<string> = {
  name: 'Halo color',
  component: FeatureColorInput,
};
