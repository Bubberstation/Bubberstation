import { CheckboxInput, type FeatureToggle } from '../../base';

export const resilient_traumas_permanent_traumas: FeatureToggle = {
  name: 'Permanent Traumas',
  description:
    'Brain traumas you gain will become permanent instead curable with blessed neurectomy.',
  component: CheckboxInput,
};

export const resilient_traumas_hardcore: FeatureToggle = {
  name: 'Hardcore Mode',
  description:
    'Basic traumas will only curable by neurectomy and everything else will be permanent/curable through blessed neurectomy.',
  component: CheckboxInput,
};
