import { useBackend } from '../backend';
import { Input, Section, Stack } from '../components';
import { NtosWindow } from '../layouts';
import { NTOSData } from '../layouts/NtosWindow';

type Data = {
  id_owner: string;
  id_rank: string;
} & NTOSData;

export const NtosSelfServe = (props) => {
  const { act, data } = useBackend<Data>();
  const { authenticatedUser, has_id } = data;

  return (
    <NtosWindow width={500} height={670}>
      <NtosWindow.Content scrollable>
        <Stack>
          <Stack.Item width="100%">
            <SelfServePage />
          </Stack.Item>
        </Stack>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const SelfServePage = (props) => {
  const { act, data } = useBackend<Data>();
  const { authenticatedUser, id_rank, id_owner, has_id, authIDName } = data;

  return (
    <Section title="ID Card">
      <Stack wrap="wrap">
        <Stack.Item width="100%" mt={1} ml={0}>
          has_id: {has_id || 'no'}
        </Stack.Item>
        <Stack.Item width="100%" mt={1} ml={0}>
          authenticatedUser: {authenticatedUser || '-----'}
        </Stack.Item>
        <Stack.Item width="100%" mt={1} ml={0}>
          authIDName: {authIDName || '-----'}
        </Stack.Item>
        <Stack.Item width="100%" mt={1} ml={0}>
          id_owner: {id_owner || '-----'}
        </Stack.Item>
        <Stack.Item width="100%" mt={1} ml={0}>
          id_rank: {id_rank || '-----'}
        </Stack.Item>
      </Stack>
      {!(has_id && authenticatedUser) && (
        <Stack>
          <Stack.Item align="center">Assignment:</Stack.Item>
          <Stack.Item grow={1} ml={1}>
            <Input
              fluid
              mt={1}
              value={id_rank}
              onChange={(e, value) =>
                act('PRG_assign', {
                  assignment: value,
                })
              }
            />
          </Stack.Item>
        </Stack>
      )}
    </Section>
  );
};
