import {
  Box,
  Button,
  Dropdown,
  Input,
  Modal,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { asArray, type RpPanelData } from './types';

type SettingsModalProps = {
  onClose: () => void;
};

export function SettingsModal(props: SettingsModalProps) {
  const { act, data } = useBackend<RpPanelData>();
  const { onClose } = props;
  const { settings } = data;
  const themes = asArray(data.themes);
  const soundpacks = asArray(data.soundpacks);
  const avatar_sizes = asArray(data.avatar_sizes);
  const fonts = asArray(data.fonts);
  const font_sizes = asArray(data.font_sizes);
  const line_spacings = asArray(data.line_spacings);
  if (!settings) {
    return null;
  }

  return (
    <Modal>
      <Section title="Settings" width="420px">
        <Stack fill vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>Theme</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={
                    themes.find((theme) => theme.id === settings.theme)?.label
                  }
                  options={themes.map((theme) => theme.label)}
                  onSelected={(label) => {
                    const match = themes.find((theme) => theme.label === label);
                    if (match) {
                      act('set_theme', { theme: match.id });
                    }
                  }}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Box bold>Sound</Box>
            <Button.Checkbox
              checked={!!settings.sound_message}
              onClick={() => act('toggle_sound', { kind: 'message' })}
            >
              Message Chime
            </Button.Checkbox>
            <Button.Checkbox
              checked={!!settings.sound_join}
              onClick={() => act('toggle_sound', { kind: 'join' })}
            >
              Participant Join Sound
            </Button.Checkbox>
            <Button.Checkbox
              checked={!!settings.sound_leave}
              onClick={() => act('toggle_sound', { kind: 'leave' })}
            >
              Participant Leave Sound
            </Button.Checkbox>
          </Stack.Item>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>Soundpack</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={
                    soundpacks.find((pack) => pack.id === settings.soundpack)
                      ?.label
                  }
                  options={soundpacks.map((pack) => pack.label)}
                  onSelected={(label) => {
                    const match = soundpacks.find((pack) => pack.label === label);
                    if (match) {
                      act('set_soundpack', { soundpack: match.id });
                    }
                  }}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <VolumeRow
            label="Message Chime Volume"
            value={settings.volume_message}
            kind="message"
          />
          <VolumeRow
            label="Join Sound Volume"
            value={settings.volume_join}
            kind="join"
          />
          <VolumeRow
            label="Leave Sound Volume"
            value={settings.volume_leave}
            kind="leave"
          />
          <Stack.Item>
            <Box bold>Log Appearance</Box>
            <Button.Checkbox
              checked={!!settings.show_avatars}
              onClick={() => act('toggle_avatars')}
            >
              Show Avatars
            </Button.Checkbox>
            <Stack mt={0.4}>
              <Stack.Item grow>Avatar Size</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={
                    avatar_sizes.find((size) => size.id === settings.avatar_size)
                      ?.label
                  }
                  options={avatar_sizes.map((size) => size.label)}
                  onSelected={(label) => {
                    const match = avatar_sizes.find((size) => size.label === label);
                    if (match) {
                      act('set_avatar_size', { size: match.id });
                    }
                  }}
                />
              </Stack.Item>
            </Stack>
            <Stack mt={0.4}>
              <Stack.Item grow>Font</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={settings.font}
                  options={fonts}
                  onSelected={(font) => act('set_font', { font })}
                />
              </Stack.Item>
            </Stack>
            <Stack mt={0.4}>
              <Stack.Item grow>Custom font</Stack.Item>
              <Stack.Item>
                <Input
                  value={settings.font}
                  onChange={(value) => act('set_font', { font: value })}
                />
              </Stack.Item>
            </Stack>
            <Stack mt={0.4}>
              <Stack.Item grow>Font Size</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={
                    font_sizes.find((size) => size.id === settings.font_size)
                      ?.label
                  }
                  options={font_sizes.map((size) => size.label)}
                  onSelected={(label) => {
                    const match = font_sizes.find((size) => size.label === label);
                    if (match) {
                      act('set_font_size', { size: match.id });
                    }
                  }}
                />
              </Stack.Item>
            </Stack>
            <Stack mt={0.4}>
              <Stack.Item grow>Line Spacing</Stack.Item>
              <Stack.Item>
                <Dropdown
                  selected={
                    line_spacings.find(
                      (spacing) => spacing.id === settings.line_spacing,
                    )?.label
                  }
                  options={line_spacings.map((spacing) => spacing.label)}
                  onSelected={(label) => {
                    const match = line_spacings.find(
                      (spacing) => spacing.label === label,
                    );
                    if (match) {
                      act('set_line_spacing', { spacing: match.id });
                    }
                  }}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button fluid onClick={onClose}>
              Close
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
    </Modal>
  );
}

type VolumeRowProps = {
  label: string;
  value: number;
  kind: string;
};

function VolumeRow(props: VolumeRowProps) {
  const { act } = useBackend<RpPanelData>();
  return (
    <Stack.Item>
      <Stack>
        <Stack.Item grow>{props.label}</Stack.Item>
        <Stack.Item>
          <NumberInput
            width="4em"
            minValue={0}
            maxValue={100}
            step={1}
            value={props.value}
            onChange={(value) =>
              act('set_volume', { kind: props.kind, volume: value })
            }
          />
        </Stack.Item>
        <Stack.Item width="3em">{props.value}%</Stack.Item>
      </Stack>
    </Stack.Item>
  );
}
