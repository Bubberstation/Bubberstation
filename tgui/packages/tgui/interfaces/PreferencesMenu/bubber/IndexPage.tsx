import { useState } from 'react';
import { Box, Button, Divider, Stack } from '../../../components';
import { Page } from '../CharacterPreferenceWindow';
import { useBackend } from '../../../backend';
import { PreferencesMenuData } from '../data';
import { BigPageButton } from './PageButton';
import { MultiNameInput } from '../names';

export const CharacterControls = (props: {
  handleRotate: (String) => void;
}) => {
  return (
    <Stack>
      <Stack.Item>
        <Button
          onClick={() => props.handleRotate('90')}
          fontSize="22px"
          icon="undo"
          tooltip="Rotate Left"
          tooltipPosition="top"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => props.handleRotate('-90')}
          fontSize="22px"
          icon="redo"
          tooltip="Rotate Right"
          tooltipPosition="top"
        />
      </Stack.Item>
    </Stack>
  );
};

export const IndexPage = (props: { setCurrentPage: (page: Page) => void }) => {
  const { act, data } = useBackend<PreferencesMenuData>();
  const { setCurrentPage } = props;
  const [multiNameInputOpen, setMultiNameInputOpen] = useState(false);

  const [tutorialStatus, setTutorialStatus] = useState<string | null>(null);

  return (
    <Box>
      {multiNameInputOpen && (
        <MultiNameInput
          handleClose={() => setMultiNameInputOpen(false)}
          handleRandomizeName={(preference) =>
            act('randomize_name', {
              preference,
            })
          }
          handleUpdateName={(nameType, value) =>
            act('set_preference', {
              preference: nameType,
              value,
            })
          }
          names={data.character_preferences.names}
        />
      )}

      <Box width="100%">
        <Box inline>
          <h2>Categories</h2>
        </Box>
        <Button
          position="absolute"
          right={0.5}
          fontSize="1.2em"
          onClick={() => {
            setTutorialStatus('new_player');
          }}
        >
          New Player Introduction
        </Button>
      </Box>

      <Divider />

      <Stack width="100%">
        <Stack.Item width="33%">
          <Stack vertical>
            <Stack.Item>
              <BigPageButton
                page={Page.Species}
                setPage={setCurrentPage}
                tooltip="Your character's species!"
              >
                Species
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Appearance}
                setPage={setCurrentPage}
                tooltip="Your character's basic appearance!"
              >
                Appearance
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Antags}
                setPage={setCurrentPage}
                tooltip="Which evil guys you wanna be randomly rolled as!"
              >
                Antagonists
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.OOC}
                setPage={setCurrentPage}
                tooltip="Information related to you, the player!"
              >
                OOC
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Loadout}
                setPage={setCurrentPage}
                tooltip="The items and clothes you start with!"
              >
                Loadout
              </BigPageButton>
            </Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item width="33%">
          <Stack vertical>
            <Stack.Item>
              <BigPageButton
                page={Page.Inspection}
                setPage={setCurrentPage}
                tooltip="The flavour text that's shown for your character!"
                tooltipPosition="bottom"
              >
                Inspection Text
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Quirks}
                setPage={setCurrentPage}
                tooltip="Odd traits that can range from a minor boon, to a fundamental gameplay alteration in order to stay alive!"
                tooltipPosition="bottom"
              >
                Quirks
              </BigPageButton>
            </Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item width="33%">
          <Stack vertical>
            <Stack.Item>
              <BigPageButton
                page={Page.Jobs}
                setPage={setCurrentPage}
                tooltip="What jobs your character plays!"
              >
                Occupations
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Misc}
                setPage={setCurrentPage}
                tooltip="Various settings!"
              >
                Misc
              </BigPageButton>
            </Stack.Item>

            <Stack.Item>
              <BigPageButton
                page={Page.Food}
                setPage={setCurrentPage}
                tooltip="The food your character enjoys and dislikes!"
              >
                Food Preferences
              </BigPageButton>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Box>
  );
};
