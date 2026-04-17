// BUBBER FILE - COPIED FROM [AntagInfoHeretic.tsx] DUE TO THE SCALE OF CHANGES
import '../styles/interfaces/AntagInfoHeretic.scss';

import { useState } from 'react';
import { Box, Section, Stack, Tabs } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  FlavorSection,
  type HereticPath,
  type Knowledge,
  type KnowledgeTier,
  PathInfo,
  ResearchInfo,
} from './AntagInfoHeretic';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const hereticRed = {
  color: '#e03c3c',
};

const hereticBlue = {
  fontWeight: 'bold',
  color: '#2185d0',
};

const hereticPurple = {
  fontWeight: 'bold',
  color: '#bd54e0',
};

const hereticGreen = {
  fontWeight: 'bold',
  color: '#20b142',
};

const hereticYellow = {
  fontWeight: 'bold',
  color: 'yellow',
};

type Info = {
  charges: number;
  total_sacrifices: number;
  ascended: BooleanLike;
  objectives: Objective[];
  can_change_objective: BooleanLike;
  paths: HereticPath[];
  knowledge_shop: Knowledge[];
  knowledge_tiers: KnowledgeTier[];
  passive_level: number;
  points_to_aura: number;
  influences_drained: number;
  ways_opened: number;
};

const IntroductionSection = (props) => {
  const { data } = useBackend<Info>();
  const { objectives, ascended, can_change_objective } = data;

  return (
    <Stack justify="space-evenly" height="100%" width="100%">
      <Stack.Item grow>
        <Section title="You are the Heretic!" fill fontSize="14px">
          <Stack vertical>
            <FlavorSection />
            <Stack.Divider />
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <Stack.Divider />
            <GuideSection />
            <Stack.Divider />
            <InformationSection />
            <Stack.Divider />
            {!ascended && (
              <Stack.Item>
                <ObjectivePrintout
                  fill
                  titleMessage={
                    can_change_objective
                      ? 'Your OPFOR objectives are your primary ones, but you have these tasks to fulfill' /* SKYRAT EDIT CHANGE - opfor objectives */
                      : 'Your OPFOR objectives are your primary ones. Use your dark knowledge to fulfill your personal goal' /* SKYRAT EDIT CHANGE - opfor objectives  */
                  }
                  objectives={objectives}
                  objectiveFollowup={
                    <ReplaceObjectivesButton
                      can_change_objective={can_change_objective}
                      button_title={'Specify Own Objectives'}
                      button_colour={'red'}
                      button_tooltip={'Find your own path.'}
                    />
                  }
                />
              </Stack.Item>
            )}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const GuideSection = () => {
  return (
    <Stack.Item>
      <Stack vertical fontSize="12px">
        <Stack.Item>
          - Find reality smashing&nbsp;
          <span style={hereticPurple}>influences</span>
          &nbsp;around the station invisible to the normal eye and&nbsp;
          <b>right click</b> on them to harvest them for&nbsp;
          <span style={hereticBlue}>knowledge points</span> once you harvest
          enough of them. Tapping them makes them visible to all after a short
          time, which will drain their sanity, cause hallucinations, and spawn
          monsters. Predict the crew becoming hostile once you start draining
          influences.
        </Stack.Item>
        <Stack.Item>
          - Use your&nbsp;
          <span style={hereticYellow}>Knock of the Twin-finger ritual</span>
          &nbsp;to track down&nbsp;
          <span style={hereticYellow}>ways</span>. Ways are powerful gateways
          into the mansus that you can open for{' '}
          <span style={hereticBlue}>knowledge points</span> once you've opened
          enough. Ways require a full ritual to open as well as a collection of
          items - using the ritual away from any way will show you the nearest,
          and their items. Opening a way will create a dangerous event in its
          vicinity after a minute!
        </Stack.Item>
        <Stack.Item>
          - Draw a&nbsp;
          <span style={hereticGreen}>transmutation rune</span> by using a
          drawing tool (a pen or crayon) on the floor while having&nbsp;
          <span style={hereticGreen}>Mansus Grasp</span>
          &nbsp;active in your other hand. This rune allows you to complete
          rituals and sacrifices.
        </Stack.Item>
        <Stack.Item>
          - Make yourself a <span style={hereticYellow}>focus</span> to be able
          to cast various advanced spells to assist you in acquiring harder and
          harder ways.
        </Stack.Item>
        <Stack.Item>
          <span style={hereticRed}>WARNING!</span>
          <br />
          Keep in mind that using a&nbsp;
          <span style={hereticPurple}>Codex Cicatrix</span> will also make you
          very obvious as a heretic when draining&nbsp;
          <span style={hereticYellow}>influences</span>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const InformationSection = () => {
  const { data } = useBackend<Info>();
  const { charges, influences_drained, ways_opened, ascended } = data;
  return (
    <Stack.Item>
      <Stack vertical fill>
        {!!ascended && (
          <Stack.Item>
            <Stack align="center">
              <Stack.Item>You have</Stack.Item>
              <Stack.Item fontSize="24px">
                <Box inline color="yellow">
                  ASCENDED
                </Box>
                !
              </Stack.Item>
            </Stack>
          </Stack.Item>
        )}
        <Stack.Item>
          You have <b>{charges || 0}</b>&nbsp;
          <span style={hereticBlue}>
            knowledge point{charges !== 1 ? 's' : ''}
          </span>
          .
        </Stack.Item>
        <Stack.Item>
          You have opened a total of&nbsp;
          <b>{influences_drained || 0}</b>&nbsp;
          <span style={hereticPurple}>influences</span>.
        </Stack.Item>
        <Stack.Item>
          You have opened a total of&nbsp;
          <b>{ways_opened || 0}</b>&nbsp;
          <span style={hereticYellow}>ways</span>.
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

export const AntagInfoHereticV2 = () => {
  const { data } = useBackend<Info>();
  const { ascended, knowledge_tiers, paths } = data;

  const [currentTab, setTab] = useState(1);
  // only tiers has done variables set
  const currentPath = paths.find((path) =>
    knowledge_tiers.some((tier) =>
      tier.nodes.some(
        (node) => node.done && node.path === path.starting_knowledge.path,
      ),
    ),
  );

  const tabs = [
    { label: 'Information', icon: 'info', content: <IntroductionSection /> },
    {
      label: 'Path Info',
      icon: 'info',
      content: <PathInfo currentPath={currentPath} />,
    },
    { label: 'Research', icon: 'book', content: <ResearchInfo /> },
  ];

  const currentTheme = () => {
    if (currentPath?.route) {
      return `Heretic theme-Heretic--${currentPath.route.replace(' ', '')}`;
    }
    return 'Heretic';
  };

  return (
    <Window
      width={750}
      height={635}
      theme={`${currentTheme()}${ascended ? ' heretic-theme-ascended' : ''}`}
    >
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Tabs fluid>
              {tabs.map((tab, index) => (
                <Tabs.Tab
                  key={index}
                  icon={tab.icon}
                  selected={currentTab === index}
                  onClick={() => setTab(index)}
                >
                  {tab.label}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>{tabs[currentTab].content}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
