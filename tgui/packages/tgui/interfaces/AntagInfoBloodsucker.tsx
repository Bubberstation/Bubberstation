import { useState } from 'react';
import { Box, Button, Image, Section, Stack, Tabs } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Objective } from './common/Objectives';
import { PowerDetails } from './PowerInfo';

export type ClanProps = {
  clan: ClanInfo[];
  in_clan: BooleanLike;
};

export type ClanInfo = {
  clan_name: string;
  clan_description: string;
  clan_icon: string;
};

export type PowerInfo = {
  power_name: string;
  power_explanation: string[];
  power_icon: string;
};

export type BloodsuckerProps = {
  powers: PowerInfo[];
  objectives: Objective[];
};
export type GhoulProps = BloodsuckerProps & {
  title: string;
  description: string;
};

const ObjectivePrintout = (props: any) => {
  const { data } = useBackend<BloodsuckerProps>();
  const { objectives } = data;
  return (
    <Stack vertical>
      <Stack.Item bold>Your current objectives:</Stack.Item>
      <Stack.Item>
        {(!objectives && 'None!') ||
          objectives.map((objective) => (
            <Stack.Item key={objective.count}>
              #{objective.count}: {objective.explanation}
            </Stack.Item>
          ))}
      </Stack.Item>
    </Stack>
  );
};

export const AntagInfoBloodsucker = (props: any) => {
  const [tab, setTab] = useState(1);
  return (
    <Window width={620} height={700} theme="spookyconsole">
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}
          >
            Introduction
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}
          >
            Clan & Powers
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <BloodsuckerIntro />}
        {tab === 2 && <BloodsuckerClan />}
      </Window.Content>
    </Window>
  );
};

const BloodsuckerIntro = () => {
  return (
    <Stack vertical fill>
      <Stack.Item minHeight="16rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              You are a Bloodsucker, an undead blood-seeking monster living
              aboard Space Station 13
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section fill title="Strengths and Weaknesses">
          <Stack vertical height="7rem">
            <Stack.Item>
              <span>
                You regenerate your health slowly, you&#39;re weak to fire, and
                you depend on blood to survive. Don&#39;t allow your blood to
                run too low, or you&#39;ll enter a
              </span>
              <span className={'color-red'}> Frenzy</span>!<br />
              <span>
                Beware of your Humanity level! The more Humanity you lose, the
                easier it is to fall into a{' '}
                <span className={'color-red'}> Frenzy</span>!
              </span>
              <br />
              <span>
                Avoid using your Feed ability while near others, or else you
                will risk <i>breaking the Masquerade</i>!
              </span>
              <span>
                Loosing your heart will render your powers useless, but going
                into a coffin with a heart inside will allow you to regenerate
                it.
              </span>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section fill title="Items">
          <Stack vertical>
            <Stack.Item>
              Rest in a <b>Coffin</b> to claim it, and that area, as your haven.
              <br />
              Examine your new structures to see how they function!
              <br />
              Medical analyzers and the book of kindred can sell you out, your
              Masquerade ability will hide your identity to prevent this.
              <br />
              You will learn how to make persuasion racks once you have enough
              levels to support a ghoul, which you will learn during torpor
              during daytime. Examine the ghoul rack to see how many ghouls you
              can have!
              <br />
              You cannot level up until you select a clan. To select a clan,
              click the clan tab on the top right of this window.
              <br />
              Ensure to read the descriptions of each ability in the Clan &
              Powers tab, you may learn something new!
              <br />
              After a certain level, Sol will no longer grant you levels,
              instead, you will need to feed on the blood of others to gain
              levels.
            </Stack.Item>
            <Stack.Item>
              <Section textAlign="center" textColor="red" fontSize="20px">
                Other Bloodsuckers are not necessarily your friends, but your
                survival may depend on cooperation. Betray them at your own
                discretion and peril.
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const BloodsuckerClan = (props: any) => {
  const { act, data } = useBackend<BloodsuckerProps & ClanProps>();
  const { clan, in_clan, powers } = data;

  if (!in_clan) {
    return (
      <Section minHeight="220px">
        <Box mt={5} bold textAlign="center" fontSize="40px">
          You are not in a Clan.
        </Box>
        <Box mt={3}>
          <Button
            fluid
            icon="users"
            textAlign="center"
            fontSize="30px"
            lineHeight={2}
            onClick={() => act('join_clan')}
          >
            Join Clan
          </Button>
        </Box>
      </Section>
    );
  }

  return (
    <Stack vertical fill>
      <Stack.Item minHeight="20rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item>
              {clan.map((ClanInfo) => (
                <>
                  <Image
                    height="20rem"
                    opacity={0.25}
                    src={resolveAsset(`bloodsucker.${ClanInfo.clan_icon}.png`)}
                    className="img absolute"
                    style={{ position: 'absolute' }}
                  />
                  <Stack.Item fontSize="20px" textAlign="center">
                    You are part of the {ClanInfo.clan_name}
                  </Stack.Item>
                  <Stack.Item
                    fontSize="16px"
                    style={{ flexBasis: '60% !important' }}
                  >
                    {ClanInfo.clan_description}
                  </Stack.Item>
                </>
              ))}
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <PowerDetails powers={powers} />
    </Stack>
  );
};
