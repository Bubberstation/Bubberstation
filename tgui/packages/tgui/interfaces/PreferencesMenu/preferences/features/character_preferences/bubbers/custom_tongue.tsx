import { type Feature, FeatureShortTextInput } from '../../base';

export const custom_tongue_ask: Feature<string> = {
  name: 'Ask?',
  description: 'Automated Ask say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_tongue_exclaim: Feature<string> = {
  name: 'Exclaim!',
  description: 'Automated Exclaim say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_tongue_whisper: Feature<string> = {
  name: 'whisper',
  description: 'Automated Whisper say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_tongue_yell: Feature<string> = {
  name: 'Yell!!',
  description: 'Automated Yell say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_tongue_say: Feature<string> = {
  name: 'Say.',
  description: 'Automated Say say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};
