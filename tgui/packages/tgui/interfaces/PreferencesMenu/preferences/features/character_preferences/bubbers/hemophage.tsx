import { CheckboxInput, type FeatureToggle } from '../../base';

export const masquerade_toggle: FeatureToggle = {
  name: 'Enable Masquerade',
  description:
    'If enabled, you will be able to eat food, albeit without nutritional value.',
  component: CheckboxInput,
};
