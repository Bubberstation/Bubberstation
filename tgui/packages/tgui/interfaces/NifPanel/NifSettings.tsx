// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Dropdown, Input, LabeledList } from 'tgui-core/components';
import type { NifPanelData } from './data';

export function NifSettings() {
  const { act, data } = useBackend<NifPanelData>();
  const {
    nutrition_drain,
    ui_themes,
    current_theme,
    nutrition_level,
    blood_drain,
    minimum_blood_level,
    blood_level,
    stored_points,
    default_examine_text,
    current_examine_text,
  } = data;

  return (
    <LabeledList>
      <LabeledList.Item
        label="NIF Theme"
        tooltip="The theme this window will use."
      >
        <Dropdown
          width="100%"
          selected={current_theme}
          options={ui_themes}
          onSelected={(value) => act('change_theme', { target_theme: value })}
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="NIF Flavor Text"
        tooltip="This will appear when people examine you."
      >
        <Input
          placeholder={default_examine_text}
          value={current_examine_text}
          onEnter={(value) => act('change_examine_text', { new_text: value })}
          width="100%"
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="Nutrition Drain"
        tooltip="Toggles the ability for the NIF to use your food as an energy source. Enabling this may result in increased hunger."
      >
        <Button
          fluid
          onClick={() => act('toggle_nutrition_drain')}
          disabled={nutrition_level < 26}
        >
          {!nutrition_drain
            ? 'Nutrition Drain Disabled'
            : 'Nutrition Drain Enabled'}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item
        label="Blood Drain"
        tooltip="This allows the NIF to use your blood as an energy source. Will cause shortness of breath. Automatically shuts off when blood level is low."
      >
        <Button
          fluid
          onClick={() => act('toggle_blood_drain')}
          disabled={blood_level < minimum_blood_level}
        >
          {!blood_drain ? 'Blood Drain Disabled' : 'Blood Drain Enabled'}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item
        label="Rewards Points"
        tooltip="Rewards Points are an alternative currency gained by purchasing NIFSofts. These carry between shifts."
      >
        {stored_points}
      </LabeledList.Item>
    </LabeledList>
  );
}
