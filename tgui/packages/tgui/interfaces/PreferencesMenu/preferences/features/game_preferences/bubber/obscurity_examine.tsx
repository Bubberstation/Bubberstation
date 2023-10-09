import { CheckboxInput, FeatureToggle } from '../../base';

export const obscurity_examine_pref: FeatureToggle = {
  name: 'Obscure examine panel',
  category: 'GAMEPLAY',
  description: 'Toggles whether your examine panel is hidden when unknown.',
  component: CheckboxInput,
};
