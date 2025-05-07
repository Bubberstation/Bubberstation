import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const preset_blood_color: Feature<boolean> = {
  name: 'Toggle to use presets',
  component: CheckboxInput,
};

export const input_blood_color: Feature<string> = {
  name: 'Blood color',
  description:
    'NOTE: This matches the colour to the BRIGHTEST px. So, make this slightly (about 10?) more luminescent (HSL) than you want the blood to be.',
  component: FeatureColorInput,
};

export const select_blood_color: FeatureChoiced = {
  name: 'Blood color',
  component: FeatureDropdownInput,
};
