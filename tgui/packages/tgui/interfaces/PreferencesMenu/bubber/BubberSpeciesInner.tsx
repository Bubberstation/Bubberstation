// This is it's own file because of the sheer amount of GIGAFUCK edits that exist.
// It's not worth it, just make a new file, man. - Rimi

import { classes } from 'common/react';
import { useState } from 'react';

import { useBackend } from '../../../backend';
import { BlockQuote, Box, Button, Section, Stack } from '../../../components';
import { CharacterPreview } from '../../CharacterPreview';
import {
  createSetPreference,
  PreferencesMenuData,
  ServerData,
  Species,
} from '../data';
import { Diet, SpeciesPerks } from '../SpeciesPage';

export const BubberSpeciesPageInner = (props: {
  handleClose: () => void;
  species: ServerData['species'];
}) => {
  const { act, data } = useBackend<PreferencesMenuData>();
  const setSpecies = createSetPreference(act, 'species');

  let species: [string, Species][] = Object.entries(props.species).map(
    ([species, data]) => {
      return [species, data];
    },
  );

  // Humans are always the top of the list
  const humanIndex = species.findIndex(([species]) => species === 'human');
  const swapWith = species[0];
  species[0] = species[humanIndex];
  species[humanIndex] = swapWith;

  const [previewedSpecies, setPreviewedSpecies] = useState(
    data.character_preferences.misc.species,
  );

  const currentSpecies = species.filter(([speciesKey]) => {
    return speciesKey === previewedSpecies;
  })[0][1];

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack width="100%">
          <Stack.Item>
            <Button
              icon="arrow-left"
              onClick={props.handleClose}
              content="Go Back"
            />
          </Stack.Item>
          <Stack.Item ml="auto" mr="auto" fontSize="1.2em">
            <Button
              icon="check"
              onClick={() => setSpecies(previewedSpecies)}
              style={{ padding: '5px' }}
            >
              Apply Species
            </Button>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <Box height="calc(100vh - 170px)" overflowY="auto" pr={3}>
              {species.map(([speciesKey, species]) => {
                return (
                  <Button
                    key={speciesKey}
                    onClick={() => {
                      setPreviewedSpecies(speciesKey);
                    }}
                    selected={previewedSpecies === speciesKey}
                    tooltip={species.name}
                    style={{
                      display: 'block',
                      height: '64px',
                      width: '64px',
                    }}
                  >
                    <Box
                      className={classes(['species64x64', species.icon])}
                      ml={-1}
                    />
                  </Button>
                );
              })}
            </Box>
          </Stack.Item>

          <Stack.Item grow>
            <Box>
              <Box>
                <Stack fill>
                  <Stack.Item width="100%">
                    <Section
                      title={currentSpecies.name}
                      buttons={
                        // NOHUNGER species have no diet (diet = null),
                        // so we have nothing to show
                        currentSpecies.diet && (
                          <Diet diet={currentSpecies.diet} />
                        )
                      }
                    >
                      <Section title="Description">
                        {currentSpecies.desc.map((text, index) => (
                          <Box key={index} maxWidth="100%">
                            {text}
                            {index !== currentSpecies.desc.length - 1 && (
                              <>
                                <br />
                                <br />
                              </>
                            )}
                          </Box>
                        ))}
                      </Section>

                      <Section title="Features">
                        <SpeciesPerks perks={currentSpecies.perks} />
                      </Section>
                    </Section>
                  </Stack.Item>

                  <Stack.Item width="30%">
                    <CharacterPreview
                      id={data.character_preview_view}
                      height="100%"
                    />
                  </Stack.Item>
                </Stack>
              </Box>

              <Box mt={1}>
                <Section title="Lore">
                  <BlockQuote>{currentSpecies.desc}</BlockQuote>
                </Section>
              </Box>
            </Box>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
