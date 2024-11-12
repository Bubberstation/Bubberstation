import { ReactNode, useState } from 'react';
import { sendAct, useBackend } from '../../../backend';
import {
  Box,
  Button,
  Dropdown,
  LabeledList,
  Section,
  Stack,
  Tooltip,
} from '../../../components';
import { CharacterPreview } from '../../CharacterPreview';
import { CharacterControls } from './IndexPage';
import {
  PreferencesMenuData,
  RandomSetting,
  createSetPreference,
} from '../data';
import { NameInput } from '../names';
import { StackHeader } from './BubberPrefStack';
import { createSetRandomization, sortPreferences } from '../MainPage';
import features from '../preferences/features';
import { RandomizationButton } from '../RandomizationButton';
import { FeatureValueInput } from '../preferences/features/base';

export const LoadoutPreviewSection = (props: {
  tutorialStatus;
  setMultiNameInputOpen;
}) => {
  const { act, data } = useBackend<PreferencesMenuData>();
  const { character_preview_view } = data;
  const { tutorialStatus, setMultiNameInputOpen } = props;
  return (
    <Section height="100%" title="Preview">
      <Stack vertical>
        <Stack.Item height="250px" align="center">
          {!tutorialStatus && (
            <CharacterPreview height="100%" id={character_preview_view} />
          )}
        </Stack.Item>
        <Stack.Divider />

        <Stack.Item>
          <NameInput
            name={data.character_preferences.names[data.name_to_use]}
            handleUpdateName={createSetPreference(act, data.name_to_use)}
            openMultiNameInput={() => {
              setMultiNameInputOpen(true);
            }}
          />
        </Stack.Item>

        <Stack.Item style={{ textAlign: 'center' }}>
          <Dropdown
            width="100%"
            selected={data.preview_selection}
            options={data.preview_options}
            onSelected={(value) =>
              act('update_preview', {
                updated_preview: value,
              })
            }
          />
        </Stack.Item>
        <Stack.Item align="center">
          <CharacterControls
            handleRotate={(dir) => {
              act('rotate', { dir: dir });
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const BetterPrefList = (props: {
  header?: string;
  act?: typeof sendAct;
  preferences?: Record<string, unknown>;
  randomizations?: Record<string, RandomSetting>;
  children?: ReactNode;
}) => {
  return (
    <Stack vertical fill>
      {!!props.header && <StackHeader>{props.header}</StackHeader>}
      {!!props.preferences &&
        sortPreferences(Object.entries(props.preferences)).map(
          ([featureId, value]) => {
            const feature = features[featureId];
            const randomSetting = props.randomizations
              ? props.randomizations[featureId]
              : null;

            if (feature === undefined) {
              return (
                <Stack.Item key={featureId}>
                  <b>Feature {featureId} is not recognized.</b>
                </Stack.Item>
              );
            }

            return (
              <SlightlyLessCrappyLabeledListItem
                key={featureId}
                label={
                  feature.description ? (
                    <Box
                      style={{
                        borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                        cursor: 'help',
                      }}
                      as="span"
                    >
                      {feature.name}
                    </Box>
                  ) : (
                    feature.name
                  )
                }
                tooltip={feature.description}
              >
                <Stack fill>
                  {randomSetting && (
                    <Stack.Item>
                      <RandomizationButton
                        setValue={createSetRandomization(props.act!, featureId)}
                        value={randomSetting}
                      />
                    </Stack.Item>
                  )}

                  <Stack.Item grow>
                    <FeatureValueInput
                      act={props.act!}
                      feature={feature}
                      featureId={featureId}
                      value={value}
                    />
                  </Stack.Item>
                </Stack>
              </SlightlyLessCrappyLabeledListItem>
            );
          },
        )}
      {props.children}
    </Stack>
  );
};

// Looks nicer than the normal one (IMO), also doesn't use tables.
export const SlightlyLessCrappyLabeledListItem = (props: {
  children;
  label;
  tooltip;
}) => {
  return (
    <Stack.Item width="100%" minHeight="2rem">
      <LazyShortcut condition={!!props.tooltip} tooltip={props.tooltip}>
        <Stack>
          {/* There's probably a better way of doing this, but oh my fucking god I hate css - Rimi */}
          <Stack.Item mr="5px" width="42%">
            <Box
              mt="auto"
              position="relative"
              top="50%"
              style={{ transform: 'translateY(-50%)' }}
              textAlign="right"
            >
              {props.label}:
            </Box>
          </Stack.Item>
          <Stack.Item grow>{props.children}</Stack.Item>
        </Stack>
      </LazyShortcut>
    </Stack.Item>
  );
};

const LazyShortcut = (props: {
  children?: ReactNode;
  tooltip?: any;
  condition;
}) => {
  return (
    (props.condition && (
      <Tooltip content={props.tooltip}>{props.children}</Tooltip>
    )) || <>{props.children}</>
  );
};
