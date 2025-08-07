// THIS IS A SKYRAT UI FILE
import {
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const pet_owner: FeatureChoiced = {
  name: 'Pet Type',
  component: FeatureDropdownInput,
};

export const pet_name: Feature<string> = {
  name: 'Pet Name',
  description:
    "If blank, will use the mob's default name. For example, 'axolotl' or 'chinchilla'.",
  component: FeatureShortTextInput,
};

export const pet_desc: Feature<string> = {
  name: 'Pet Description',
  description: "If blank, will use the mob's default description.",
  component: FeatureShortTextInput,
};
