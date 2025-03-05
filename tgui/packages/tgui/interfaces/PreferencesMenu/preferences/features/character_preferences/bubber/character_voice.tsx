import { Button, Stack } from 'tgui-core/components';

import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureSliderInput,
  FeatureToggle,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData> & {
    act: (action: string, value?: unknown) => void;
  },
) => {
  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            props.act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Character Voice Range',
  description:
    '[0.1 - 0.8] Lower number, less range. Higher number, more range.',
  component: FeatureNumberInput,
};

export const blooper_speech: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speech_speed: FeatureNumeric = {
  name: 'Character Voice Speed',
  description:
    '[2 - 16] Lower number, faster speed. Higher number, slower voice.',
  component: FeatureNumberInput,
};

export const blooper_speech_pitch: FeatureNumeric = {
  name: 'Character Voice Pitch',
  description:
    '[0.4 - 2] Lower number, deeper pitch. Higher number, higher pitch.',
  component: FeatureNumberInput,
};

export const hear_sound_blooper: FeatureToggle = {
  name: 'Enable Vocal Bark hearing',
  category: 'SOUND',
  component: CheckboxInput,
};

export const sound_blooper_volume: Feature<number> = {
  name: 'Vocal Bark Volume',
  category: 'SOUND',
  description: 'The volume that the Vocal Barks sounds will play at.',
  component: FeatureSliderInput,
};

export const send_sound_blooper: FeatureToggle = {
  name: 'Enable Vocal Bark sending',
  category: 'SOUND',
  component: CheckboxInput,
};
