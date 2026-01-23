import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const widescreenpref: FeatureChoiced = {
  name: 'Widescreen Mode',
  category: 'UI',
  description: 'Select your preferred viewport size.',
  component: FeatureDropdownInput,
};
