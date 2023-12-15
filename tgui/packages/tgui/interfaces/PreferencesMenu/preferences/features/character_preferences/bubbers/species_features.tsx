import { Feature, FeatureTextInput } from '../../base';

export const flavor_text_nsfw: Feature<string> = {
  name: 'Flavor Text (NSFW)',
  description:
    'A portion of your flavor text that is censored in examine. Used to store visual sexual details.',
  component: FeatureTextInput,
};

export const silicon_flavor_text_nsfw: Feature<string> = {
  name: 'Flavor Text (Silicon, NSFW)',
  description:
    'A portion of your flavor text that is stored in examine, used for Silicons. Used to store visual sexual details.',
  component: FeatureTextInput,
};
