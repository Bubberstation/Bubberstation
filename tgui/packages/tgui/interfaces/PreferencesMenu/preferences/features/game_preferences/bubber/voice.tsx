import { CheckboxInput, FeatureToggle } from '../../base';

export const voice_toggle: FeatureToggle = {
  name: 'Enable voices',
  category: 'SOUND',
  description: 'When enabled, hear voice chimes from other players.',
  component: CheckboxInput,
};
