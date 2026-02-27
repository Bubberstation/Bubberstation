import { Button, Stack } from 'tgui-core/components';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = props as FeatureValueProps<
    string,
    string,
    FeatureChoicedServerData
  > & {
    act: (action: string) => void;
  };

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_choice: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speed: FeatureNumeric = {
  name: 'Character Voice Speed %',
  description: 'Lower number, slower voice. Higher number, faster voice.',
  component: FeatureSliderInput,
};

export const blooper_pitch: FeatureNumeric = {
  name: 'Character Voice Pitch %',
  description: 'Lower number, deeper pitch. Higher number, higher pitch.',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Character Voice Range %',
  description:
    'Lower number, less pitch range. Higher number, more pitch range.',
  component: FeatureSliderInput,
};
