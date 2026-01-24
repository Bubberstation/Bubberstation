import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const viewport_size: FeatureChoiced = {
  name: 'Aspect Ratio (Viewport)',
  category: 'UI',
  description: 'Select your preferred viewport size.',
  component: FeatureDropdownInput,
};
