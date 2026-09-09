import {
  type Feature,
  FeatureNumberInput,
} from '../../base';

export const cursekin_char_slot: Feature<number> = {
  name: 'Lycan Character Slot',
  description:
    "The index of the character slot, from top to bottom, of the lycan character slot that will be used when you transform. \
    Does not use quirks, implants, or the set name. Set to a non-lycan slot to simply switch species instead of loading a slot.",
  component: FeatureNumberInput,
};
