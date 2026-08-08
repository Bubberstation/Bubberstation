// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../../base';

export const echolocation_outline: Feature<string> = {
  name: 'Echo outline color',
  component: FeatureColorInput,
};

export const echolocation_use_echo: FeatureToggle = {
  name: 'Display echo overlay',
  component: CheckboxInput,
};
