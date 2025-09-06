import { Feature, FeatureChoiced, FeatureColorInput } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const input_blood_color: Feature<string> = {
  name: 'Custom color',
  description:
    'NOTE: This matches the colour to the BRIGHTEST px. So, make this slightly (about 10?) more luminescent (HSL) than you want the blood to be.',
  component: FeatureColorInput,
};

export const select_blood_color: FeatureChoiced = {
  name: 'Preset color',
  description: 'NOTE: Use the Custom option for custom color.',
  component: FeatureDropdownInput,
};
