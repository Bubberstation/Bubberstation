import { NtosWindow } from '../../layouts';
import { LogViewScreen } from './LogViewScreen';

export function AppLogViewer(props) {
  return (
    <NtosWindow width={720} height={480}>
      <NtosWindow.Content>
        <LogViewScreen visible={props.visible} messages={props.messages} />
      </NtosWindow.Content>
    </NtosWindow>
  );
}
