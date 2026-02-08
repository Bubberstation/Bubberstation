import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const footstep_sound: FeatureChoiced = {
  name: 'Footstep Sound',
  description: 'The type of sound you will make when you walk around barefoot.',
  component: FeatureDropdownInput,
};
