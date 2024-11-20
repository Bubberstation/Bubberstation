import { CheckboxInput, FeatureToggle } from '../../base';

export const departmental_airlock_sounds: FeatureToggle = {
  name: 'Enable departmental airlock sounds',
  category: 'SOUND',
  description: 'Enables fancy department-specific airlock sound effects.',
  component: CheckboxInput,
};
