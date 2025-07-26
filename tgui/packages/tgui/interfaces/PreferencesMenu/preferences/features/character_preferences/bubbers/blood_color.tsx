import {
  CheckboxInput,
  Feature,
  FeatureColorInput,
  FeatureToggle,
} from '../../base';

export const custom_blood_color: FeatureToggle = {
  name: 'Custom Blood Color Enable',
  component: CheckboxInput,
};

export const blood_color: Feature<string> = {
  name: 'Custom Blood Color',
  component: FeatureColorInput,
};
