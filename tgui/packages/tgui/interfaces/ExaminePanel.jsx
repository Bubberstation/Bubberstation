// THIS IS A SKYRAT UI FILE
import { useState } from 'react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { ByondUi, Section, Stack, Tabs } from '../components';
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
  const [lowerTabIndex, setLowerTabIndex] = useState(1);
  const { act, data } = useBackend();
  const {
    character_name,
    obscured,
    assigned_map,
    flavor_text,
    flavor_text_nsfw,
    ooc_notes,
    custom_species,
    custom_species_lore,
    character_ad,
    headshot,
    headshot_nsfw,
  } = data;
  return (
    <Window
      title={character_name + "'s Examine Panel"}
      width={900}
      height={670}
    >
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
                        ? resolveAsset(headshot_nsfw)
                        : resolveAsset(headshot)
                    }
                    height="250px"
                    width="250px"
                  />
                </Section>
              </>
            )}
          </Stack.Item>
          <Stack.Item grow>
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
                fontSize="14px"
                lineHeight="1.7"
                textIndent="3em"
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
                fontSize="14px"
                lineHeight="1.7"
                textIndent="3em"
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
                fontSize="14px"
                lineHeight="1.7"
                textIndent="3em"
              >
                {custom_species
                  ? formatURLs(custom_species_lore)
                  : 'Just a normal space dweller.'}
              </Section>
            )}
            <Tabs fluid>
              <Tabs.Tab
                selected={lowerTabIndex === 1}
                onClick={() => setLowerTabIndex(1)}
              >
                <Section fitted title={'OOC Notes'} />
              </Tabs.Tab>
              <Tabs.Tab
                selected={lowerTabIndex === 2}
                onClick={() => setLowerTabIndex(2)}
              >
                <Section fitted title={'Character Advert'} />
              </Tabs.Tab>
            </Tabs>
            {lowerTabIndex === 1 && (
              <Section
                style={{ 'overflow-y': 'scroll' }}
                preserveWhitespace
                fitted
                minHeight="35%"
                maxHeight="35%"
                fontSize="14px"
                lineHeight="1.5"
              >
                <Stack.Item>{formatURLs(ooc_notes)}</Stack.Item>
              </Section>
            )}
            {lowerTabIndex === 2 && (
              <Section
                style={{ 'overflow-y': 'scroll' }}
                preserveWhitespace
                fitted
                minHeight="35%"
                maxHeight="35%"
                fontSize="14px"
                lineHeight="1.5"
              >
                <Stack.Item>{formatURLs(character_ad)}</Stack.Item>
              </Section>
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
