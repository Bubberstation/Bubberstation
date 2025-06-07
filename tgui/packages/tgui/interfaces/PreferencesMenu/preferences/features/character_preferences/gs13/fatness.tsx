import { Feature, FeatureNumberInput } from '../../base';

export const starting_fatness: Feature<number> = {
  name: 'Starting Fatness',
  description: 'How fat is your character when starting the round?',
  component: FeatureNumberInput,
};
