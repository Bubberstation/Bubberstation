import { NtosWindow } from '../layouts';
import { MinesweeperContent } from './Minesweeper';

export const NtosMinesweeper = (props, context) => {
  return (
    <NtosWindow width={600} height={572}>
      <NtosWindow.Content>
        <MinesweeperContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
