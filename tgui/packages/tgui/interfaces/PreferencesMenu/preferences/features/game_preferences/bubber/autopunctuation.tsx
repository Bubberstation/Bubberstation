import { CheckboxInput, FeatureToggle } from '../../base';

export const autopunctuation: FeatureToggle = {
  name: 'Autopunctuation',
  category: 'CHAT',
  description: 'When enabled, messages lacking punctuation will have it added.',
  component: CheckboxInput,
};
