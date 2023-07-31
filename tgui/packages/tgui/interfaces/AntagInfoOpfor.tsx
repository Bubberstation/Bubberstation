import { Section, Stack, Button } from '../components';
import { Window } from '../layouts';
import { useBackend } from '../backend';

export const AntagInfoOpfor = (props, context) => {
  const { act } = useBackend(context);
  return (
    <Window width={620} height={250}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              {'You are an OPFOR candidate!'}
            </Stack.Item>
            {
              'You are encouraged to OPFOR to perform an antagonistic action in some form.'
            }
            {
              'If you do not have any ideas, check #player-submitted-opfors on the Discord for inspiration.'
            }
            {
              'And if you do not wish to OPFOR, simply press the button below to remove your status.'
            }
            <Stack.Item align="center">
              <Button
                color="red"
                content={'Remove Status'}
                tooltip={'Remove your OPFOR candidate status.'}
                onClick={() => act('pass_on')}
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
