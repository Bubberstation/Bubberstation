import { CheckboxInput, FeatureToggle } from '../../base';

export const be_intern: FeatureToggle = {
  name: 'Be Tagged As Intern',
  category: 'GAMEPLAY',
  description:
    'Toggles whether you will be tagged as an intern in jobs where you have low playtime.',
  component: CheckboxInput,
};
