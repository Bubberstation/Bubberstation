import { Box, Button, Modal, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { RpPanelData } from './types';

const PREF_LABELS: Record<string, string> = {
  erp_status: 'ERP',
  erp_status_nc: 'Noncon',
  erp_status_v: 'Vore',
  erp_status_hypno: 'Hypnosis',
  erp_status_mechanics: 'Mechanics',
};

const VISIBILITY_OPTIONS = [
  { id: 1, label: 'Never Show' },
  { id: 2, label: 'Hidden by Clothes' },
  { id: 3, label: 'Always Show' },
];

type ManageSelfModalProps = {
  onClose: () => void;
};

export function ManageSelfModal(props: ManageSelfModalProps) {
  const { act, data } = useBackend<RpPanelData>();
  const { onClose } = props;
  const { self } = data;

  return (
    <Modal>
        <Section title="Manage Self" width="640px" scrollable height={46}>
        {self.show_erp ? (
          <>
            {Object.entries(PREF_LABELS).map(([key, label]) => {
              const pref = self.prefs[key];
              if (!pref) {
                return null;
              }
              return (
                <Box key={key} mb={1}>
                  <Box bold mb={0.3}>
                    {label}
                  </Box>
                  {(pref.options || []).map((option) => (
                    <Button
                      key={option}
                      m={0.2}
                      color={pref.value === option ? 'good' : 'default'}
                      onClick={() =>
                        act('set_self_preference', {
                          pref_type: key,
                          pref_value: option,
                        })
                      }
                    >
                      {option}
                    </Button>
                  ))}
                </Box>
              );
            })}
            <Box bold mb={0.3}>
              Genital Visibility
            </Box>
            {(self.genitals || []).map((genital) => (
              <Stack key={genital.slot} mb={0.3}>
                <Stack.Item width="7em">{genital.name}</Stack.Item>
                {VISIBILITY_OPTIONS.map((option) => (
                  <Stack.Item key={option.id}>
                    <Button
                      color={
                        genital.visibility === option.id ? 'good' : 'default'
                      }
                      onClick={() =>
                        act('set_genital_visibility', {
                          slot: genital.slot,
                          visibility: option.id,
                        })
                      }
                    >
                      {option.label}
                    </Button>
                  </Stack.Item>
                ))}
              </Stack>
            ))}
          </>
        ) : (
          <Box color="label" mb={1}>
            NSFW options are hidden while ERP preferences are off.
          </Box>
        )}
        <Box bold mb={0.3}>
          Underwear Visibility
        </Box>
        <Button.Checkbox
          checked={!!self.underwear?.underwear}
          onClick={() => act('toggle_underwear', { kind: 'underwear' })}
        >
          Hide Underwear
        </Button.Checkbox>
        <Button.Checkbox
          checked={!!self.underwear?.bra}
          onClick={() => act('toggle_underwear', { kind: 'bra' })}
        >
          Hide Bra
        </Button.Checkbox>
        <Button.Checkbox
          checked={!!self.underwear?.undershirt}
          onClick={() => act('toggle_underwear', { kind: 'undershirt' })}
        >
          Hide Undershirt
        </Button.Checkbox>
        <Button.Checkbox
          checked={!!self.underwear?.socks}
          onClick={() => act('toggle_underwear', { kind: 'socks' })}
        >
          Hide Socks
        </Button.Checkbox>
        <Button fluid mt={1} onClick={onClose}>
          Close
        </Button>
      </Section>
    </Modal>
  );
}
