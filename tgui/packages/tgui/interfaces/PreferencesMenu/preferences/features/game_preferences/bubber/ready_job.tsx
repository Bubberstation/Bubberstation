import { CheckboxInput, FeatureToggle } from '../../base';

export const ready_job: FeatureToggle = {
  name: 'Toggle Job Readying',
  category: 'UI',
  description:
    'Toggles whether your highest job shows in the pre-game Job Estimation panel.',
  component: CheckboxInput,
};
