import { useState } from 'react';
import {
  Button,
  Divider,
  Dropdown,
  Image,
  Section,
  Stack,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { PowerInfo } from './AntagInfoBloodsucker';

type PowerDetailsProps = {
  powers: PowerInfo[];
};

export const PowerDetails = (props: PowerDetailsProps) => {
  const { powers } = props;
  if (!powers?.length) {
    return null;
  }

  const [selectedPower, setSelectedPower] = useState(powers[0]);

  return (
    <Section
      fill
      scrollable={!!powers}
      title="Powers"
      buttons={
        <Button
          icon="info"
          tooltipPosition="left"
          tooltip={
            'Select a Power using the dropdown menu for an in-depth explanation.'
          }
        />
      }
    >
      <Stack>
        <Stack.Item grow>
          <Dropdown
            displayText={selectedPower.power_name}
            selected={selectedPower.power_name}
            width="100%"
            options={powers.map((power) => power.power_name)}
            onSelected={(powerName: string) =>
              setSelectedPower(
                powers.find((p) => p.power_name === powerName) || powers[0],
              )
            }
          />
          {selectedPower && (
            <Image
              position="absolute"
              height="12rem"
              src={resolveAsset(`bloodsucker.${selectedPower.power_icon}.png`)}
            />
          )}
          <Divider vertical />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item grow fontSize="16px" width="40%">
          {selectedPower?.power_explanation?.length &&
            selectedPower.power_explanation.map((line, index) => {
              if (index === 0) {
                return line;
              } else {
                return (
                  <>
                    <br />
                    {line}
                  </>
                );
              }
            })}
        </Stack.Item>
      </Stack>
    </Section>
  );
};
