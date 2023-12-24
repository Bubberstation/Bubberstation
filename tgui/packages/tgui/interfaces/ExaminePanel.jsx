// THIS IS A SKYRAT UI FILE
import { useBackend } from '../backend';
import { Stack, Section, ByondUi, Tabs } from '../components'; // Bubber edit: add Tabs
import { useState } from 'react';
import { Window } from '../layouts';

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
          color: '#0591e3',
          'text-decoration': 'none',
        }}
        href={url}
      >
        {url}
      </a>,
    );
    lastIndex = index + url.length;
    return url;
  });

  parts.push(text.substring(lastIndex));

  return <div>{parts}</div>;
};

export const ExaminePanel = (props) => {
  const [tabIndex, setTabIndex] = useState(1);
  const { act, data } = useBackend();
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
    headshot_nsfw,
  } = data;
  return (
    <Window
      title={character_name + "'s Examine Panel"}
      width={900}
      height={670}
    >
      {/* BUBBER EDIT: DON'T USE ADMIN THEME*/}
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
                    src={
                      tabIndex === 2
                        ? headshot_nsfw
                        : headshot
                    }
                    height="250px"
                    width="250px"
                  />
                </Section>
              </>
            )}
          </Stack.Item>
          <Stack.Item grow>
            {/* BUBBER EDIT BEGIN, NSFW FLAVOR TEXT */}
            <Tabs fluid>
              <Tabs.Tab
                selected={tabIndex === 1}
                onClick={() => setTabIndex(1)}
              >
                <Section fitted title={'Flavor Text'} />
              </Tabs.Tab>
              <Tabs.Tab
                selected={tabIndex === 2}
                onClick={() => setTabIndex(2)}
              >
                <Section fitted title={'NSFW (Warning)'} />
              </Tabs.Tab>
              <Tabs.Tab
                selected={tabIndex === 3}
                onClick={() => setTabIndex(3)}
              >
                <Section
                  fitted
                  title={custom_species ? custom_species : 'Unnamed Species'}
                />
              </Tabs.Tab>
            </Tabs>
            {tabIndex === 1 && (
              <Section
                style={{ 'overflow-y': 'scroll' }}
                fitted
                preserveWhitespace
                minHeight="50%"
                maxHeight="50%"
              >
                {formatURLs(flavor_text)}
              </Section>
            )}
            {tabIndex === 2 && (
              <Section
                style={{ 'overflow-y': 'scroll' }}
                fitted
                preserveWhitespace
                minHeight="50%"
                maxHeight="50%"
              >
                {formatURLs(flavor_text_nsfw)}
              </Section>
            )}
            {tabIndex === 3 && (
              <Section
                style={{ 'overflow-y': 'scroll' }}
                fitted
                preserveWhitespace
                minHeight="50%"
                maxHeight="50%"
              >
                {custom_species
                  ? formatURLs(custom_species_lore)
                  : 'Just a normal space dweller.'}
              </Section>
            )}
            <Section
              style={{ 'overflow-y': 'scroll' }}
              fitted
              preserveWhitespace
              minHeight="40%"
              maxHeight="40%"
              title="OOC Notes"
            >
              <Stack.Item>{formatURLs(ooc_notes)}</Stack.Item>
            </Section>
            {/* BUBBER EDIT END, NSFW FLAVOR TEXT */}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
