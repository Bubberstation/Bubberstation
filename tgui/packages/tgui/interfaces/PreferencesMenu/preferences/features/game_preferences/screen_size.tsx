import { CheckboxInput, type FeatureToggle } from '../base';

// BUBBER EDIT START - Replaced with choiced dropdown in bubber/screen.tsx
/*
export const widescreenpref: FeatureToggle = {
  name: 'Enable widescreen',
  category: 'UI',
  component: CheckboxInput,
};
*/
// BUBBER EDIT END

export const fullscreen_mode: FeatureToggle = {
  name: 'Toggle Fullscreen',
  category: 'UI',
  description: 'Toggles Fullscreen for the game, can also be toggled with F11.',
  component: CheckboxInput,
};
