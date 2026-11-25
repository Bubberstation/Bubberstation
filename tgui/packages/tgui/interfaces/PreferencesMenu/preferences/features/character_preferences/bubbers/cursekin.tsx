import { type Feature, FeatureChoiced, FeatureNumberInput, FeatureTextInput } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const cursekin_char_slot: Feature<number> = {
  name: 'Lycan Character Slot',
  description:
    'The index of the character slot, from top to bottom, of the lycan character slot that will be used when you transform. \
    Does not use implants or the set name. Set to a non-lycan slot to simply switch species instead of loading a slot.',
  component: FeatureNumberInput,
};

export const cursekin_sfx: FeatureChoiced = {
  name: 'Lycan Transformation Sfx',
  description:
    'The sfx to be used when you transform into and from your lycan form.',
  component: FeatureDropdownInput,
};

export const cursekin_transform_text: Feature<string> = {
  name: 'Lycan Transformation Text',
  description:
    'The text displayed when you transform into your lycan form. Appended with an ! at the end.',
  component: FeatureTextInput,
};

export const cursekin_detransform_text: Feature<string> = {
  name: 'Lycan Detransformation Text',
  description:
    'The text displayed when you transform out of your lycan form. Appended with an ! at the end.',
  component: FeatureTextInput,
};
