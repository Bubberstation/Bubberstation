import { Feature, FeatureColorInput } from '../../base';

export const unique_blood_color: Feature<string> = {
  name: 'Blood color',
  description:
    'Note: This matches the colour to the BRIGHTEST px. So, make this slightly (about 10?) more luminescent (HSL) than you want the blood to be.',
  component: FeatureColorInput,
};
