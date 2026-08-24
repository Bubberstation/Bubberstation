import {
  CheckboxInput,
  type Feature,
  FeatureSliderInput,
  type FeatureToggle,
} from '../../base';

// Names share the "Limb Transparency" prefix so the panel (which sorts secondary features
// alphabetically by name) keeps them grouped together, toggle first.
export const limb_alpha_per_limb: FeatureToggle = {
  name: 'Limb Transparency',
  description:
    'Reveals the per-limb transparency sliders for your arms and legs. While off, those limbs stay fully opaque.',
  component: CheckboxInput,
};

export const limb_alpha_head: Feature<number> = {
  name: 'Limb Transparency: Head',
  description:
    'How opaque your head is. 0 is fully invisible while worn; dropped limbs stay faintly visible so they can be picked up.',
  component: FeatureSliderInput,
};

export const limb_alpha_chest: Feature<number> = {
  name: 'Limb Transparency: Chest',
  description:
    'How opaque your chest is. 0 is fully invisible while worn; dropped limbs stay faintly visible so they can be picked up.',
  component: FeatureSliderInput,
};

export const limb_alpha_l_arm: Feature<number> = {
  name: 'Limb Transparency: Left Arm',
  description: 'How opaque your left arm is.',
  component: FeatureSliderInput,
};

export const limb_alpha_r_arm: Feature<number> = {
  name: 'Limb Transparency: Right Arm',
  description: 'How opaque your right arm is.',
  component: FeatureSliderInput,
};

export const limb_alpha_l_leg: Feature<number> = {
  name: 'Limb Transparency: Left Leg',
  description: 'How opaque your left leg is.',
  component: FeatureSliderInput,
};

export const limb_alpha_r_leg: Feature<number> = {
  name: 'Limb Transparency: Right Leg',
  description: 'How opaque your right leg is.',
  component: FeatureSliderInput,
};
