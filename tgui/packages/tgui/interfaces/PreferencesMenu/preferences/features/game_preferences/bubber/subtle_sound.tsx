import { CheckboxInput, type FeatureToggle } from '../../base';

export const subtler_sound: FeatureToggle = {
  name: 'Toggle Subtle/r Sound',
  category: 'SOUND',
  description: 'Toggles whether you hear subtle/r emote sound effects',
  component: CheckboxInput,
};
