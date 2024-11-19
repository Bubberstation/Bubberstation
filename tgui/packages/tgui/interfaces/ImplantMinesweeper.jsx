import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Box, Button, Knob, Section } from '../components';
import { Window } from '../layouts';
import { MinesweeperContent } from './Minesweeper';

export const ImplantMinesweeper = (props, context) => {
  return (
    <Window width={600} height={518} resizable>
      <Window.Content>
        <MinesweeperContent />
      </Window.Content>
    </Window>
  );
};
