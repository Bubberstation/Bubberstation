import { type Feature, FeatureShortTextInput } from '../../base';

export const custom_speech_modifier_ask: Feature<string> = {
  name: 'Custom Speech Modifier: Ask?',
  description: 'Automated Ask say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_speech_modifier_exclaim: Feature<string> = {
  name: 'Custom Speech Modifier: Exclaim!',
  description: 'Automated Exclaim say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_speech_modifier_whisper: Feature<string> = {
  name: 'Custom Speech Modifier: whisper',
  description: 'Automated Whisper say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_speech_modifier_yell: Feature<string> = {
  name: 'Custom Speech Modifier: Yell!!',
  description: 'Automated Yell say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};

export const custom_speech_modifier_say: Feature<string> = {
  name: 'Custom Speech Modifier: Say.',
  description: 'Automated Say say modifier. A-Z Only, no spaces.',
  component: FeatureShortTextInput,
};
