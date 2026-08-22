import { Box, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import type { NTOSData } from '../layouts/NtosWindow';

type RetaDepartment = {
  name: string;
  actions: RetaAction[];
};

type RetaAction = {
  type: string;
  label: string;
  icon: string;
  cooldown: BooleanLike;
  disabledReason?: string;
};

type Data = {
  departments: RetaDepartment[];
} & NTOSData;

export const NtosReta = () => {
  return (
    <NtosWindow width={640} height={520}>
      <NtosWindow.Content scrollable>
        <RetaContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const RetaContent = () => {
  const { act, data } = useBackend<Data>();
  const { departments = [] } = data;

  return (
    <Section title="RETA">
      <Stack vertical fill>
        {departments.map((department) => (
          <Stack.Item key={department.name}>
            <Box
              p={0.5}
              style={{
                display: 'grid',
                gap: '0.5rem',
                gridTemplateColumns: 'minmax(7rem, 1fr) minmax(0, max-content)',
                alignItems: 'center',
              }}
            >
              <Box bold>{department.name}</Box>
              <Box
                style={{
                  display: 'flex',
                  flexWrap: 'wrap',
                  gap: '0.25rem',
                  justifyContent: 'flex-end',
                }}
              >
                {department.actions.map((action) => (
                  <Button
                    key={action.type}
                    disabled={action.cooldown || !!action.disabledReason}
                    icon={action.icon}
                    tooltip={
                      action.disabledReason
                        ? action.disabledReason
                        : action.cooldown
                        ? `${action.label} RETA is on cooldown.`
                        : `Declare ${action.label} Emergency`
                    }
                    onClick={() =>
                      act('declare', {
                        department: department.name,
                        emergencyType: action.type,
                      })
                    }
                  >
                    {action.label}
                  </Button>
                ))}
              </Box>
            </Box>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};
