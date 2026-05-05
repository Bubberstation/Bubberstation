import { CheckboxInput, FeatureToggle } from '../../base';

export const resilient_traumas_permanent_traumas: FeatureToggle = {
  name: 'Permanent Traumas',
  description:
	'Brain traumas you gain will become permanent instead curable with blessed lobotomy.',
  component: CheckboxInput,
};

export const resilient_traumas_hardcore: FeatureToggle = {
  name: 'Hardcore Mode',
  description:
	'Basic traumas will only curable by lobotomy and everything else will be permanent/curable through blessed lobotomy.',
  component: CheckboxInput,
};
