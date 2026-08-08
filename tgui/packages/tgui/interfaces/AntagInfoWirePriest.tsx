import { BlockQuote, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoWirePriest = (props) => {
  return (
    <Window width={660} height={660}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="50%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">You are the Wire Priest</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    You are part of the fleshmind, this means any fleshmind
                    entities, structures, mobs are your ally. You must not
                    attack them. You must roleplay that you are part of the
                    fleshmind. Your number one goal is converting other hosts
                    and spreading the flesh.
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>Create:&ensp;</span>
                  Create tech structures, basic structures, and wireweed itself
                  to help defend and spread the fleshmind. These structures
                  depend on the current level of the core.
                  <br />
                  <br />
                  <span style={tipstyle}>Defend:&ensp;</span>
                  Call flesh reinforcements and use your knife to defend the
                  your core. Remember, if you die, you will no longer be loyal
                  to your precious fleshmind, protecct it with your life.
                  <br />
                  <br />
                  <span style={tipstyle}>Convert:&ensp;</span>
                  Convert station dwellers with mechivers, rally them using the
                  call flesh reinforcements ability. You may be weak alone, but
                  with numbers you can easily overwhelm the crew.
                  <br />
                  <br />
                  <span style={tipstyle}>Communicate:&ensp;</span>
                  Speak with your fellow enlightened ones using your flesh chat
                  ability. Communication is key afterall.
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
