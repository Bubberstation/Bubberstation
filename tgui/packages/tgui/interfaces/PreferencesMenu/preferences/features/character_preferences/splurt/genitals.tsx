import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const scaled_appearance: FeatureToggle = {
  name: 'Scaled Appearance',
  description: 'Make your character use a sharp or fuzzy appearance.',
  component: CheckboxInput,
};

export const feature_butt: Feature<string> = {
  name: 'Butt Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const butt_skin_tone: FeatureToggle = {
  name: 'Butt uses Skin Tone',
  component: CheckboxInput,
};

export const butt_skin_color: FeatureToggle = {
  name: 'Butt uses Skin Color',
  component: CheckboxInput,
};

export const butt_color: Feature<string[]> = {
  name: 'Butt Color',
  component: FeatureTriColorInput,
};

export const butt_emissive: Feature<boolean[]> = {
  name: 'Butt Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const butt_size: FeatureNumeric = {
  name: 'Butt Size',
  component: FeatureNumberInput,
};

export const anus_skin_tone: FeatureToggle = {
  name: 'Anus uses Skin Tone',
  component: CheckboxInput,
};

export const anus_skin_color: FeatureToggle = {
  name: 'Anus uses Skin Color',
  component: CheckboxInput,
};

export const anus_color: Feature<string[]> = {
  name: 'Anus Color',
  component: FeatureTriColorInput,
};

export const anus_emissive: Feature<boolean[]> = {
  name: 'Anus Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const feature_belly: Feature<string> = {
  name: 'Belly Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const belly_size: FeatureNumeric = {
  name: 'Belly Size',
  component: FeatureNumberInput,
};

export const belly_skin_tone: FeatureToggle = {
  name: 'Belly uses Skin Tone',
  component: CheckboxInput,
};

export const belly_skin_color: FeatureToggle = {
  name: 'Belly uses Skin Color',
  component: CheckboxInput,
};

export const belly_color: Feature<string[]> = {
  name: 'Belly Color',
  component: FeatureTriColorInput,
};

export const belly_emissive: Feature<boolean[]> = {
  name: 'Belly Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const erp_status_pref_extm: FeatureChoiced = {
  name: 'Extreme ERP verbs',
  component: FeatureDropdownInput,
};

export const erp_status_pref_extmharm: FeatureChoiced = {
  name: 'Harmful ERP verbs',
  component: FeatureDropdownInput,
};

export const erp_status_pref_unholy: FeatureChoiced = {
  name: 'Unholy ERP verbs',
  component: FeatureDropdownInput,
};

export const erp_lust_tolerance_pref: FeatureNumeric = {
  name: 'Lust tolerance multiplier',
  description:
    'Set your lust tolerance multiplier. \n(0.5 = half tolerance, 2 = double tolerance)',
  component: FeatureNumberInput,
};

export const erp_sexual_potency_pref: FeatureNumeric = {
  name: 'Sexual potency multiplier',
  description:
    'Set your sexual potency multiplier. \n(0.5 = half potency, 2 = double potency)',
  component: FeatureNumberInput,
};
