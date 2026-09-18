// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import { Box, LabeledList, ProgressBar } from 'tgui-core/components';
import type { NifPanelData } from './data';

export function NifStats() {
  const { data } = useBackend<NifPanelData>();
  const { nutrition_drain, blood_drain } = data;

  return (
    <Box>
      <LabeledList>
        <LabeledList.Item label="NIF Condition">
          <NifConditionBar />
        </LabeledList.Item>
        <LabeledList.Item label="NIF Power">
          <NifPowerBar />
        </LabeledList.Item>
        {!!nutrition_drain && (
          <LabeledList.Item label="User Nutrition">
            <NifNutritionBar />
          </LabeledList.Item>
        )}
        {!!blood_drain && (
          <LabeledList.Item label="User Blood Level">
            <NifBloodBar />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Box>
  );
}

export function NifConditionBar() {
  const { data } = useBackend<NifPanelData>();
  const { durability, max_durability } = data;
  return (
    <ProgressBar
      value={durability}
      minValue={0}
      maxValue={max_durability}
      ranges={{
        good: [max_durability * 0.66, max_durability],
        average: [max_durability * 0.33, max_durability * 0.66],
        bad: [0, max_durability * 0.33],
      }}
    />
  );
}

export function NifPowerBar() {
  const { data } = useBackend<NifPanelData>();
  const { power_level, max_power, power_usage } = data;
  return (
    <ProgressBar
      value={power_level}
      minValue={0}
      maxValue={max_power}
      ranges={{
        good: [max_power * 0.66, max_power],
        average: [max_power * 0.33, max_power * 0.66],
        bad: [0, max_power * 0.33],
      }}
    >
      {Math.trunc((power_level / max_power) * 100) +
        '%' +
        ' (' +
        (power_usage / max_power) * 100 +
        '% Usage)'}
    </ProgressBar>
  );
}

export function NifNutritionBar() {
  const { data } = useBackend<NifPanelData>();
  const { nutrition_level } = data;
  return (
    <ProgressBar
      value={nutrition_level}
      minValue={0}
      maxValue={550}
      ranges={{
        good: [250, Infinity],
        average: [150, 250],
        bad: [0, 150],
      }}
    />
  );
}

export function NifBloodBar() {
  const { data } = useBackend<NifPanelData>();
  const { blood_level, minimum_blood_level, max_blood_level } = data;
  return (
    <ProgressBar
      value={blood_level}
      minValue={0}
      maxValue={max_blood_level}
      ranges={{
        good: [minimum_blood_level, Infinity],
        average: [336, minimum_blood_level],
        bad: [0, 336],
      }}
    />
  );
}
