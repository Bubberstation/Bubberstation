import { CheckboxInput, FeatureToggle } from '../../base';

export const disable_dizziness: FeatureToggle = {
  name: 'Disable Dizziness',
  category: 'GAMEPLAY',
  description:
    'When enabled, dizzy effects will become blurry instead, meant as a accesibility feature for those who are sensitive to dizziness.',
  component: CheckboxInput,
};
