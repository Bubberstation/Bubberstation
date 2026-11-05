import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../../base';

export const custom_shading_toggle: FeatureToggle = {
  name: 'Custom Shading',
  description:
    'Pick the color your body shades toward in its shadows, instead of a darker version of your base color. Applies to your body, tail, ears and other parts that use your body colors.',
  component: CheckboxInput,
};

export const custom_shading_color: Feature<string> = {
  name: 'Custom Shading Color',
  description:
    'The color the darkest parts of your sprite fade to. Black looks the same as having Custom Shading off.',
  component: FeatureColorInput,
};
