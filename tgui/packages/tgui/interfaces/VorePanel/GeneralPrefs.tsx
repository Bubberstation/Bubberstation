import { useBackend } from 'tgui/backend';
import { Button, Flex, Section } from 'tgui-core/components';

import * as types from './types';

export const Preferences = (props) => {
  const { data } = useBackend<types.Data>();
  const { preferences } = data;

  return (
    <Section title="Vore Preferences">
      <Flex wrap>
        {Object.entries(preferences).map(([key, value]) => {
          const data = PREF_TYPE_MAP[key];
          if (data) {
            return (
              <Flex.Item basis="33%" key={key}>
                {data.component({ key, name: data.name, value })}
              </Flex.Item>
            );
          } else {
            return (
              <Flex.Item key={key} basis="33%">
                Unknown pref: {key}
              </Flex.Item>
            );
          }
        })}
      </Flex>
    </Section>
  );
};

export const PrefTrinary = (props: {
  key: string;
  name: string;
  value: number;
}) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button
      fluid
      icon={value === 2 ? 'star' : value === 1 ? 'star-half-alt' : 'star-o'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: (value + 1) % 3 })}
      selected={value === 2}
      tooltip={
        value === 2
          ? 'You will automatically accept vore of this type'
          : value === 1
            ? 'You will always be prompted whether you are okay with vore of this type'
            : 'You will automatically reject vore of this type'
      }
    >
      {name} - {value === 2 ? 'Always' : value === 1 ? 'Prompt' : 'Never'}
    </Button>
  );
};

export const PrefBinary = (props: {
  key: string;
  name: string;
  value: number;
}) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button
      fluid
      icon={value ? 'toggle-on' : 'toggle-off'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: !value })}
      tooltip={value ? 'Enabled' : 'Disabled'}
      selected={value}
    >
      {name} - {value ? 'Enabled' : 'Disabled'}
    </Button>
  );
};

export const PREF_TYPE_MAP = {
  prey_toggle: { component: PrefTrinary, name: 'Prey Toggle' },
  pred_toggle: { component: PrefTrinary, name: 'Pred Toggle' },
  eating_noises: { component: PrefBinary, name: 'Eating Noises' },
  digestion_noises: { component: PrefBinary, name: 'Digestion Noises' },
  belch_noises: { component: PrefBinary, name: 'Belch Noises' },
  digestion_allowed: { component: PrefBinary, name: 'Take Digestion Damage' },
  qdel_allowed: { component: PrefBinary, name: 'Deleted After Digestion' },
  absorb_allowed: { component: PrefBinary, name: 'Absorption Allowed' },
  fullscreen_overlays_allowed: {
    component: PrefBinary,
    name: 'Fullscreen Overlays',
  },
};
