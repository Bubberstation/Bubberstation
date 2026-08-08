import { CheckboxInput, type FeatureToggle } from '../../base';

export const blooper_send: FeatureToggle = {
  name: 'Enable sending vocal bloopers',
  category: 'SOUND',
  description:
    'When enabled, plays a customizable sound effect when your character speaks.',
  component: CheckboxInput,
};

export const blooper_hear: FeatureToggle = {
  name: 'Enable hearing vocal bloopers',
  category: 'SOUND',
  description: `When enabled, allows you to hear other character's speech sounds.`,
  component: CheckboxInput,
};
