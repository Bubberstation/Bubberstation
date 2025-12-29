import { Component, createRef, type RefObject } from 'react';
import { Box, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../backend';
import type { LogConsole, LogFile } from './types';

type LogViewerProps = {
  visible: BooleanLike;
  messages: LogFile[];
};

type LogViewerState = {
  selectedKey: string | null;
  restored: boolean;
};

export class LogViewScreen extends Component<LogViewerProps, LogViewerState> {
  scrollRef: RefObject<HTMLDivElement | null>;

  state: LogViewerState = {
    selectedKey: null,
    restored: false,
  };

  constructor(props: LogViewerProps) {
    super(props);
    this.scrollRef = createRef();

    this.handleSelectLog = this.handleSelectLog.bind(this);
    this.handleRestore = this.handleRestore.bind(this);
    this.scrollToBottom = this.scrollToBottom.bind(this);
  }

  componentDidMount() {
    this.scrollToBottom();
  }

  componentDidUpdate(prevProps: LogViewerProps, prevState: LogViewerState) {
    if (
      prevProps.messages !== this.props.messages ||
      prevState.selectedKey !== this.state.selectedKey
    ) {
      this.scrollToBottom();
    }
  }

  scrollToBottom() {
    const el = this.scrollRef.current;
    if (el) {
      el.scrollTop = el.scrollHeight;
    }
  }

  handleSelectLog(file: LogFile) {
    const key = `${file.timestamp}-${file.author}`;
    this.setState({ selectedKey: key, restored: false });
  }

  handleRestore() {
    this.setState({ restored: true });
  }

  render() {
    const { data } = useBackend<LogConsole>();
    const visible = !!this.props.visible;
    const messages = data.messages ?? [];

    const { selectedKey, restored } = this.state;
    const selectedFile =
      selectedKey !== null
        ? messages.find((f) => `${f.timestamp}-${f.author}` === selectedKey)
        : undefined;

    return (
      <Stack fill>
        <Stack.Item basis="30%">
          <Section title="Logs" scrollable>
            {messages.length > 0 ? (
              messages.map((file) => {
                const key = `${file.timestamp}-${file.author}`;
                return (
                  <Button
                    key={key}
                    fluid
                    selected={selectedKey === key}
                    onClick={() => this.handleSelectLog(file)}
                  >
                    {file.author} - {file.timestamp}
                  </Button>
                );
              })
            ) : (
              <Box>No logs available.</Box>
            )}
          </Section>
        </Stack.Item>

        <Stack.Item grow>
          <Section
            title={
              selectedFile
                ? `${selectedFile.author} - ${selectedFile.timestamp}`
                : 'Select a log'
            }
            scrollable
            fill
          >
            <div
              ref={this.scrollRef}
              style={{ maxHeight: '100%', overflow: 'auto' }}
            >
              {selectedFile ? (
                <Box>
                  <Box mb={1} font-family="Courier">
                    {selectedFile.message}
                  </Box>

                  {!!selectedFile.needRestore && !restored && (
                    <Button
                      icon="redo"
                      color="good"
                      onClick={this.handleRestore}
                    >
                      Restore record
                    </Button>
                  )}

                  {restored && <Box color="green">Restored!</Box>}
                </Box>
              ) : (
                <Box>Select a log to view.</Box>
              )}
            </div>
          </Section>
        </Stack.Item>
      </Stack>
    );
  }
}
