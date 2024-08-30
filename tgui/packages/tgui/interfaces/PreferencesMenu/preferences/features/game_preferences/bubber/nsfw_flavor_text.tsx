import { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const show_flavor_text_nsfw: FeatureChoiced = {
  name: 'Flavor Text (NSFW) Visibility',
  description:
    'How you would like your NSFW flavor text to be shown. Silicons always show NSFW flavor text, unless set to "never".',
  category: 'ERP',
  component: FeatureDropdownInput,
};
