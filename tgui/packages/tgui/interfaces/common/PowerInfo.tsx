import { useState } from 'react';
import {
  Button,
  Divider,
  Dropdown,
  Image,
  Section,
  Stack,
} from 'tgui-core/components';

import { resolveAsset } from '../../assets';
import { PowerInfo } from './../AntagInfoBloodsucker';

type PowerDetailsProps = {
  powers: PowerInfo[];
};

export const PowerDetails = (props: PowerDetailsProps) => {
  const { powers } = props;
  if (!powers?.length) {
    return <Section minHeight="220px" />;
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
            options={powers.map((powers) => powers.power_name)}
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
        <Stack.Item grow={1} fontSize="16px">
          {selectedPower && selectedPower.power_explanation}
        </Stack.Item>
      </Stack>
    </Section>
  );
};
