import { Feature, FeatureChoiced, FeatureShortTextInput } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const hypnotic_quirk_text: Feature<string> = {
  name: 'Hypnotic Text Examine',
  description:
    'The examine text portrayed from your character. Use third person (Their, He, She, etc)',
  component: FeatureShortTextInput,
};

export const flashy_text: FeatureChoiced = {
  name: 'Text Color Selection',
  component: FeatureDropdownInput,
};
