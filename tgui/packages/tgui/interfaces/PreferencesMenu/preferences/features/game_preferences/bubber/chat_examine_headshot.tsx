import { CheckboxInput, type FeatureToggle } from '../../base';

export const chat_examine_headshot: FeatureToggle = {
  name: 'Examine chat headshots',
  category: 'GAMEPLAY',
  description: 'Shows character headshots in examine chat when available.',
  component: CheckboxInput,
};
