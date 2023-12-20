import { useBackend, useLocalState } from '../backend';
import { Stack, Section, ByondUi, Tabs, Box } from '../components'; // Bubber edit added Collapsible
import { Window } from '../layouts';
import { resolveAsset } from '../assets';

const formatURLs = (text) => {
  if (!text) return;
  const parts = [];
  let regex = /https?:\/\/[^\s/$.?#].[^\s]*/gi;
  let lastIndex = 0;

  text.replace(regex, (url, index) => {
    parts.push(text.substring(lastIndex, index));
    parts.push(
      <a
        style={{
          'color': '#0591e3',
          'text-decoration': 'none',
        }}
        href={url}>
        {url}
      </a>
    );
    lastIndex = index + url.length;
    return url;
  });

  parts.push(text.substring(lastIndex));

  return <div>{parts}</div>;
};

export const ExaminePanel = (props, context) => {
  const [tabIndex, setTabIndex] = useLocalState(context, 'tab-index', 1);
  const { act, data } = useBackend(context);
  const {
    character_name,
    obscured,
    assigned_map,
    flavor_text,
    flavor_text_nsfw, // Bubber edit addition
    ooc_notes,
    custom_species,
    custom_species_lore,
    headshot,
  } = data;
  return (
    <Window title="Examine Panel" width={900} height={670} theme="admin">
      <Window.Content>
        <Stack fill>
          <Stack.Item width="30%">
            {!headshot ? (
              <Section fill title="Character Preview">
                <ByondUi
                  height="100%"
                  width="100%"
                  className="ExaminePanel__map"
                  params={{
                    id: assigned_map,
                    type: 'map',
                  }}
                />
              </Section>
            ) : (
              <>
                <Section height="310px" title="Character Preview">
                  <ByondUi
                    height="260px"
                    width="100%"
                    className="ExaminePanel__map"
                    params={{
                      id: assigned_map,
                      type: 'map',
                    }}
                  />
                </Section>
                <Section height="310px" title="Headshot">
                  <img
                    src={resolveAsset(headshot)}
                    height="250px"
                    width="250px"
                  />
                </Section>
              </>
            )}
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill vertical>
              <Tabs fluid>
                {/* BUBBER EDIT BEGIN, NSFW FLAVOR TEXT */}
                <Stack.Item grow>
                  <Box>
                    Tab {tabIndex}: {title}
                  </Box>
                  <Tabs.Tab
                    selected={tabIndex === 1}
                    onClick={() => setTabIndex(1)}>
                    <Section
                      scrollable
                      fill
                      title={character_name + "'s Flavor Text"}
                      preserveWhitespace>
                      {formatURLs(flavor_text)}
                    </Section>
                  </Tabs.Tab>
                  <Tabs.Tab
                    selected={tabIndex === 2}
                    onClick={() => setTabIndex(2)}>
                    <Section
                      scrollable
                      fill
                      title={'NSFW (Warning)'}
                      preserveWhitespace>
                      {flavor_text_nsfw
                        ? formatURLs(flavor_text_nsfw)
                        : 'Not currently visible.'}
                    </Section>
                  </Tabs.Tab>
                </Stack.Item>
              </Tabs>
            </Stack>
          </Stack.Item>
          {/* BUBBER EDIT END, NSFW FLAVOR TEXT */}
          <Stack.Item grow>
            <Stack>
              <Stack.Item grow basis={0}>
                <Section scrollable fill title="OOC Notes" preserveWhitespace>
                  {formatURLs(ooc_notes)}
                </Section>
              </Stack.Item>
              <Stack.Item grow basis={0}>
                <Section
                  scrollable
                  fill
                  title={
                    custom_species
                      ? 'Species: ' + custom_species
                      : 'No Custom Species!'
                  }
                  preserveWhitespace>
                  {custom_species
                    ? formatURLs(custom_species_lore)
                    : 'Just a normal space dweller.'}
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
