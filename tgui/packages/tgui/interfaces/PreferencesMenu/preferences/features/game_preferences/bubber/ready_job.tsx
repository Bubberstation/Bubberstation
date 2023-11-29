import { CheckboxInput, FeatureToggle } from '../../base';

export const ready_job: FeatureToggle = {
  name: 'Toggle Job Readying',
  category: 'UI',
  description: 'Toggles whether your readied job shows in the pre-game.',
  component: CheckboxInput,
};
