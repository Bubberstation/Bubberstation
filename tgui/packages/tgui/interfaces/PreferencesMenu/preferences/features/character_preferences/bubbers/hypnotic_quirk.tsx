import { Feature, FeatureChoiced, FeatureShortTextInput } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const hypnotic_quirk_text: Feature<string> = {
  name: 'Hypnotic Text Examine',
  description: 'The examine text potrayed from your character in third',
  component: FeatureShortTextInput,
};

export const flashy_text: FeatureChoiced = {
  name: 'Text Color Selection',
  component: FeatureDropdownInput,
};
