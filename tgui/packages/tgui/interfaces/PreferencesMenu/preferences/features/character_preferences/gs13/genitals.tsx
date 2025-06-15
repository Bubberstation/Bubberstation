import {
  CheckboxInput,
  Feature,
  FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

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
