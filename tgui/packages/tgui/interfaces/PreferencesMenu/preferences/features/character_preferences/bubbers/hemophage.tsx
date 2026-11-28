import { CheckboxInput, type FeatureToggle } from '../../base';

export const masquerade_toggle: FeatureToggle = {
  name: 'Enable/Disable Masquerade',
  description:
    'If enabled, you will be able to eat food, albeit without nutritional value.',
  component: CheckboxInput,
};

export const pseudo_respiration_toggle: FeatureToggle = {
  name: 'Enable/Disable Pseudo-Respiration',
  description: 'If enabled, you will be able to breathe once again.',
  component: CheckboxInput,
};
