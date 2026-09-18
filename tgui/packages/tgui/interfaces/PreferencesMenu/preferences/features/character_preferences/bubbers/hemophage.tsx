import { CheckboxInput, type FeatureToggle } from '../../base';

export const masquerade_toggle: FeatureToggle = {
  name: 'Enable/Disable Masquerade',
  description:
    'If enabled, you will be able to eat food, albeit without nutritional value.',
  component: CheckboxInput,
};

export const sol_weakness_toggle: FeatureToggle = {
  name: 'Enable/Disable Sol Weakness',
  description:
    'If enabled, you will have to hide in a coffin or a closet during the day, or risk burning to a crisp.\
		Thankfully, you will also heal your wounds at half cost in a coffin.',
  component: CheckboxInput,
};

export const pseudo_respiration_toggle: FeatureToggle = {
  name: 'Enable/Disable Pseudo-Respiration',
  description: 'If enabled, you will be able to breathe once again.',
  component: CheckboxInput,
};
