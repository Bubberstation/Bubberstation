import { CheckboxInput, type FeatureToggle } from '../../base';

export const random_heirloom_toggle: FeatureToggle = {
  name: 'Enable Random Heirlooms',
  description:
    'If enabled, you will recieve random heirlooms instead of being to mark your own.',
  component: CheckboxInput,
};
