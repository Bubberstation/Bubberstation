import { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const health_analyzer_themes: FeatureChoiced = {
  name: 'Health Analyzer Theme',
  description:
    'This option will apply different color varriants of health analyzer gui, if you have it ON.',
  component: FeatureDropdownInput,
};
