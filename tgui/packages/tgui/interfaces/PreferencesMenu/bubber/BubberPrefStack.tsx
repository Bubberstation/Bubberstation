import { Stack } from 'tgui-core/components';
import {
  PreferencesMenuData,
  RandomSetting,
  ServerData,
  createSetPreference,
} from '../data';
import { FeatureChoicedServerData } from '../preferences/features/base';
import {
  ChoicedSelection,
  PreferenceList,
  createSetRandomization,
  getRandomization,
} from '../MainPage';
import { useBackend } from '../../../backend';
import { useRandomToggleState } from '../useRandomToggleState';
import { Box, Button, Popper } from '../../../components';
import { classes } from 'common/react';
import { RandomizationButton } from '../RandomizationButton';
import { useState } from 'react';

type MainFeatureServerData = FeatureChoicedServerData & {
  name: string;
  supplemental_features?: string[];
};

export const BubberPrefStack = (props: {
  category: string;
  serverData: ServerData | undefined;
}) => {
  const { category, serverData } = props;

  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPref, setCurrentPref] = useState<string | null>(null);

  const mainFeatures = data.character_preferences[category + '_iconed'];

  const listExists = !!data.character_preferences[category];

  return (
    <>
      {
        <TwinStack
          first={
            <Stack wrap>
              <StackHeader>Main settings for {category}</StackHeader>
              {Object.entries(mainFeatures).map(([entryKey, entry]) => {
                const catalog =
                  serverData && (serverData[entryKey] as MainFeatureServerData);

                return (
                  catalog && (
                    <ZubberFeature
                      key={entryKey}
                      catalog={catalog}
                      currentValue={entry as string}
                      handleOpen={() => {
                        setCurrentPref(entryKey);
                      }}
                      handleClose={() => setCurrentPref(null)}
                      handleSelect={(value) =>
                        createSetPreference(act, entryKey)(value)
                      }
                      isOpen={currentPref === entryKey}
                      setRandomization={createSetRandomization(act, entryKey)}
                    />
                  )
                );
              })}
            </Stack>
          }
          second={
            listExists && (
              <Stack wrap>
                <StackHeader>Secondary settings for {category}</StackHeader>
                <Stack.Item grow>
                  <PreferenceList
                    act={act}
                    preferences={data.character_preferences[category]}
                    randomizations={getRandomization(
                      data.character_preferences.secondary_features || [],
                      serverData,
                      data.character_preferences['misc'].random_body !==
                        RandomSetting.Disabled || useRandomToggleState()[0],
                    )}
                    maxHeight="100%"
                  />
                </Stack.Item>
              </Stack>
            )
          }
        />
      }
    </>
  );
};

export const StackHeader = (props: { children }) => {
  return (
    <Stack.Item minHeight="2rem" width="100%">
      <Box
        style={{
          borderBottom: '1px solid #888',
          fontWeight: 'bold',
          fontSize: '14px',
          textAlign: 'center',
        }}
      >
        {props.children}
      </Box>
    </Stack.Item>
  );
};

const TwinStack = (props: { first; second }) => {
  return (
    <Stack fill>
      <Stack.Item
        height="100%"
        width={props.second ? '50%' : '100%'}
        style={{
          background: 'rgba(0, 0, 0, 0.5)',
          padding: '4px',
        }}
        overflowX="hidden"
        overflowY="scroll"
      >
        {props.first}
      </Stack.Item>
      {!!props.second && (
        <Stack.Item
          height="100%"
          width="50%"
          style={{
            background: 'rgba(0, 0, 0, 0.5)',
            padding: '4px',
          }}
          overflowX="hidden"
          overflowY="scroll"
        >
          {props.second}
        </Stack.Item>
      )}
    </Stack>
  );
};

const ZubberFeature = (props: {
  catalog: MainFeatureServerData;
  currentValue: string;
  handleClose: () => void;
  handleOpen: () => void;
  handleSelect: (newClothing: string) => void;
  isOpen: boolean;
  randomization?: RandomSetting;
  setRandomization: (newSetting: RandomSetting) => void;
}) => {
  const {
    catalog,
    currentValue,
    handleClose,
    handleOpen,
    isOpen,
    handleSelect,
    randomization,
    setRandomization,
  } = props;

  return (
    <Stack.Item
      height={`48px`}
      mt={0.5}
      pr={2}
      pb={1}
      ml={0}
      width={'45%' /* I hate this */}
      position="relative"
    >
      <Popper
        placement="bottom-start"
        isOpen={isOpen}
        onClickOutside={handleClose}
        baseZIndex={1} // Below the default popper at z 2
        content={
          <ChoicedSelection
            name={catalog.name}
            catalog={catalog}
            selected={currentValue}
            supplementalFeatures={catalog.supplemental_features}
            onClose={handleClose}
            onSelect={handleSelect}
          />
        }
      >
        <Stack>
          <Stack.Item>
            <Button
              inline
              onClick={(event) => {
                event.stopPropagation();
                handleOpen();
              }}
              style={{
                height: `48px`,
                width: `48px`,
              }}
              position="relative"
            >
              <Box
                className={classes([
                  'preferences32x32',
                  catalog.icons![currentValue],
                  'centered-image',
                ])}
                style={{
                  transform: randomization
                    ? 'translateX(-70%) translateY(-70%) scale(1.1)'
                    : 'translateX(-50%) translateY(-50%) scale(1.3)',
                }}
              />

              {randomization && (
                <RandomizationButton
                  dropdownProps={{
                    dropdownStyle: {
                      bottom: 0,
                      position: 'absolute',
                      right: '1px',
                    },

                    onOpen: (event) => {
                      // We're a button inside a button.
                      // Did you know that's against the W3C standard? :)
                      event.cancelBubble = true;
                      event.stopPropagation();
                    },
                  }}
                  value={randomization}
                  setValue={setRandomization}
                />
              )}
            </Button>
          </Stack.Item>
          {/* There's probably a better way of doing this, but oh my fucking god I hate css - Rimi */}
          <Stack.Item fontSize={1.2} ml="5px" height="48px">
            <Box
              mt="auto"
              position="relative"
              top="50%"
              style={{ transform: 'translateY(-50%)' }}
            >
              {catalog.name}
            </Box>
          </Stack.Item>
        </Stack>
      </Popper>
    </Stack.Item>
  );
};
