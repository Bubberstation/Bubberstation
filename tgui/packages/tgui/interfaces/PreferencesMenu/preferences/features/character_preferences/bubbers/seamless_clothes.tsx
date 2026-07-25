import {
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const seamless_heel_type: FeatureChoiced = {
  name: 'Heel Type',
  component: FeatureDropdownInput,
};

export const seamless_shoe_color: Feature<string> = {
  name: 'Shoe Colour',
  component: FeatureColorInput,
};
