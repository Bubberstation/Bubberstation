// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import {
  BlockQuote,
  Button,
  Collapsible,
  Icon,
  Table,
} from 'tgui-core/components';
import type { NifPanelData, NifProgramData } from './data';

export function NifProgram(props: { src: NifProgramData }) {
  const { act, data } = useBackend<NifPanelData>();
  const { max_power } = data;
  const {
    name,
    desc,
    active,
    active_mode,
    activation_cost,
    active_cost,
    reference,
    ui_icon,
    able_to_keep,
    keep_installed,
  } = props.src;

  return (
    <Collapsible
      title={name}
      icon={ui_icon}
      buttons={
        <>
          <Button.Confirm
            icon="trash"
            color="red"
            tooltip="Uninstall"
            confirmContent="Uninstall?"
            onClick={() =>
              act('uninstall_nifsoft', {
                nifsoft_to_remove: reference,
              })
            }
          />
          <Button
            icon="floppy-disk"
            color={!able_to_keep ? 'grey' : keep_installed ? 'green' : null}
            tooltip={
              !able_to_keep
                ? "Can't save between shifts"
                : keep_installed
                  ? 'Saving between shifts'
                  : 'Not saving between shifts'
            }
            disabled={!able_to_keep}
            onClick={() =>
              act('toggle_keeping_nifsoft', {
                nifsoft_to_keep: reference,
              })
            }
          />
          <Button
            icon={!active_mode ? 'power-off' : active ? 'pause' : 'play'}
            color={active ? 'yellow' : 'green'}
            tooltip={!active_mode ? 'Activate' : active ? 'Stop' : 'Start'}
            onClick={() =>
              act('activate_nifsoft', {
                activated_nifsoft: reference,
              })
            }
          />
        </>
      }
    >
      <Table mb="5px">
        <Table.Row>
          <Table.Cell>
            <Icon
              name={!activation_cost ? 'check' : 'plug'}
              color="yellow"
              mr="5px"
            />
            {!activation_cost
              ? 'No activation cost'
              : `${+(activation_cost / max_power) * 100}% per activation`}
          </Table.Cell>
          <Table.Cell>
            <Icon
              name={active_cost ? 'battery-half' : 'battery-empty'}
              color="orange"
              mr="5px"
            />
            {!active_cost
              ? 'No active drain'
              : `${(active_cost / max_power) * 100}% consumed while active`}
          </Table.Cell>
          <Table.Cell>
            <Icon name="power-off" color={active ? 'green' : 'red'} mr="5px" />
            {active ? 'Active' : 'Not active'}
          </Table.Cell>
        </Table.Row>
      </Table>
      <BlockQuote preserveWhitespace>{desc}</BlockQuote>
    </Collapsible>
  );
}
