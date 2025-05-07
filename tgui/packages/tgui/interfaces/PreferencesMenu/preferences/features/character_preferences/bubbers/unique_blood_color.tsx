import { Feature, FeatureColorInput } from '../../base';

export const unique_blood_color: Feature<string> = {
  name: 'Blood color',
  component: FeatureColorInput,
};
