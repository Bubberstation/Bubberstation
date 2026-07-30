import { type Feature, FeatureNumberInput } from '../../base';

export const hungry_quirk_level: Feature<number> = {
  name: 'Hunger rate increase',
  component: FeatureNumberInput,
};
