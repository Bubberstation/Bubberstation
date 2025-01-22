import { Feature, FeatureShortTextInput } from '../../base';

export const nameless_quirk_name: Feature<string> = {
  name: 'Prefix Name',
  description:
    'Example: (Prefix) #1334. Leave blank to default to job title. Minimum 3 characters.',
  component: FeatureShortTextInput,
};
