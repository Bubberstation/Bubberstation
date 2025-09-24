import {
  type Feature,
  FeatureNumberInput,
  type FeatureNumeric,
  CheckboxInput,
  type FeatureToggle,
} from '../../base';

export const starting_fatness: Feature<number> = {
  name: 'Starting Fatness',
  description: 'How fat is your character when starting the round?',
  component: FeatureNumberInput,
};

export const weight_gain_rate: FeatureNumeric = {
  name: 'Weight Gain Rate',
  description: 'How quickly do you get fat?',
  component: FeatureNumberInput,
};

export const weight_loss_rate: FeatureNumeric = {
  name: 'Weight Loss Rate',
  description: 'How quickly do you lose fat?',
  component: FeatureNumberInput,
};

export const max_weight: Feature<number> = {
  name: 'Maximum Weight',
  description:
    'What is the maximum weight we want our character to be at? 0 means there will be no weight cap.',
  component: FeatureNumberInput,
};


export const weight_gain_persistent: FeatureToggle = {
  name: 'Persistent weight',
  description: 'Endround/cryo weight becomes your new start weight.',
  component: CheckboxInput,
};

export const weight_gain_permanent: FeatureToggle = {
  name: 'Permanent weight',
  description: 'Persists between round, hard to remove.',
  component: CheckboxInput,
};