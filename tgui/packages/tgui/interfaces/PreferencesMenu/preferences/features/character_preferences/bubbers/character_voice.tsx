import { Button, Stack } from '../../../../../../components';
import {
  CheckboxInput,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureDropdownInput,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureToggle,
  FeatureValueProps,
} from '../../base';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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

export const blooper_speech: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speech_speed: FeatureNumeric = {
  name: 'Character Voice Speed',
  component: FeatureNumberInput,
};

export const blooper_speech_pitch: FeatureNumeric = {
  name: 'Character Voice Pitch',
  component: FeatureNumberInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Character Voice Range',
  component: FeatureNumberInput,
};

export const hear_sound_blooper: FeatureToggle = {
  name: 'Enable blooper hearing',
  category: 'SOUND',
  component: CheckboxInput,
};

export const send_sound_blooper: FeatureToggle = {
  name: 'Enable blooper sending',
  category: 'SOUND',
  component: CheckboxInput,
};
