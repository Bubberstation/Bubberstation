import { useBackend } from '../backend';
import { Section, Stack } from '../components';
import { Window } from '../layouts';
import { VassalProps } from './AntagInfoBloodsucker';
import { ObjectivePrintout } from './common/Objectives';
import { PowerDetails } from './PowerInfo';

export const AntagInfoVassal = (props: any, context: any) => {
  const { data } = useBackend<VassalProps>();
  const { powers } = data;
  return (
    <Window
      width={620}
      height={powers?.length ? 600 : 300}
      theme="spookyconsole"
    >
      <Window.Content>
        <VassalInfo />
      </Window.Content>
    </Window>
  );
};

const VassalInfo = () => {
  const { data } = useBackend<VassalProps>();
  const { powers, objectives, title, description } = data;
  return (
    <Stack vertical fill>
      <Stack.Item minHeight="20rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              {title}
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout objectives={objectives} />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      {description ? (
        <Stack.Item>
          <Section fill>
            <Stack vertical>
              <Stack.Item>
                <span>{description}</span>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
      ) : null}

      <PowerDetails powers={powers} />
    </Stack>
  );
};
