// Sponsored by Zubberstation, ported from Nova Sector
import {
  CheckboxInput,
  createDropdownInput,
  Feature,
  FeatureShortTextInput,
  FeatureToggle,
} from '../../base';

export const entombed_deploy_lock: FeatureToggle = {
  name: 'MODsuit Stays Deployed (Soft DNR)',
  description:
    'Prevents anyone from retracting any of your MODsuit, except your helmet. Even you. WARNING: this may make you extremely difficult to revive, and can be considered a soft DNR. Choose wisely.',
  component: CheckboxInput,
};

export const entombed_skin: Feature<Number> = {
  name: 'MODsuit Skin',

  component: createDropdownInput({
    0: 'Standard',
    1: 'Civilian',
    2: 'Advanced',
    3: 'Atmospheric',
    4: 'Corpsman',
    5: 'Cosmohonk',
    6: 'Engineering',
    7: 'Loader',
    8: 'Interdyne',
    9: 'Medical',
    10: 'Mining',
    11: 'Prototype',
    12: 'Security',
  }),
};

export const entombed_mod_name: Feature<string> = {
  name: 'MODsuit Control Unit Name',
  component: FeatureShortTextInput,
};

export const entombed_mod_desc: Feature<string> = {
  name: 'MODsuit Control Unit Description',
  component: FeatureShortTextInput,
};

export const entombed_mod_prefix: Feature<string> = {
  name: 'MODsuit Deployed Prefix',
  description:
    "This is appended to any deployed pieces of MODsuit gear, like the chest, helmet, etc. The default is 'fused' - try to use an adjective, if you can.",
  component: FeatureShortTextInput,
};
