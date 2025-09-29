import {
  type Feature,
  FeatureNumberInput,
  type FeatureNumeric,
  CheckboxInput,
  type FeatureToggle,
} from '../../base';

export const no_movement: Feature<number> = {
  name: 'Immobility from weight',
  description: 'At what weight do you become immobile? 0 disables this.',
  component: FeatureNumberInput,
};

export const clumsy: Feature<number> = {
  name: 'Clumsiness from weight',
  description: 'At what weight do you become clumsy? 0 disables this.',
  component: FeatureNumberInput,
};

export const nearsighted: Feature<number> = {
  name: 'Nearsightedness from weight',
  description: 'At what weight do you become nearsighted? 0 disables this.',
  component: FeatureNumberInput,
};

export const hidden_face: Feature<number> = {
  name: 'Hidden face from weight',
  description: 'At what weight does your face become hidden? 0 disables this.',
  component: FeatureNumberInput,
};

export const mute: Feature<number> = {
  name: 'Muteness from weight',
  description: 'At what weight do you become mute? 0 disables this.',
  component: FeatureNumberInput,
};

export const immobile_arms: Feature<number> = {
  name: 'Immobile arms',
  description: 'At what weight do your arms become immobile? 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_jumpsuit: Feature<number> = {
  name: 'Jumpsuit bursting',
  description: 'At what weight does your jumpsuit burst? 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_misc: Feature<number> = {
  name: 'Other clothing bursting',
  description: 'At what weight does your non-jumpsuit clothing burst? 0 disables this.',
  component: FeatureNumberInput,
};

export const belts: Feature<number> = {
  name: 'Belts breaking',
  description: 'At what weight does your belt break? This will also cause your belt to break if your fullness exceeds stage 2. 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_back: Feature<number> = {
  name: 'Clothing back bursting',
  description: 'At what weight do you become unable to wear items on your back? 0 disables this.',
  component: FeatureNumberInput,
};

export const no_buckle: Feature<number> = {
  name: 'No buckling from weight',
  description: 'At what weight do you become immobile? 0 disables this.',
  component: FeatureNumberInput,
};

export const chair_breakage: Feature<number> = {
  name: 'Chair breaking',
  description: 'At what weight will you start breaking chairs? 0 disables this.',
  component: FeatureNumberInput,
};

export const stuckage: Feature<number> = {
  name: 'Door stuckage',
  description: 'At what weight will you start getting stuck in doors? 0 disables this.',
  component: FeatureNumberInput,
};

export const stuckage_custom: Feature<number> = {
  name: 'Custom Door stuckage chance',
  description: 'What chance do you want to get stuck in doors? Setting this to 0 will reset it to default.',
  component: FeatureNumberInput,
};