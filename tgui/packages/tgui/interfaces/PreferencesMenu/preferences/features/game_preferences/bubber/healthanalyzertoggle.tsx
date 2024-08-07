import { CheckboxInput, FeatureToggle } from '../../base';

export const health_analyzer_toggle: FeatureToggle = {
  name: 'Health Analyzer UI Toggle',
  category: 'UI',
  description:
    'This option defines if you want to use UI popup on health analyzer scans or not',
  component: CheckboxInput,
};
