import { useEffect, useRef, useState } from 'react';
import { Box, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type LogFile = {
  message: string;
  author: string;
  timestamp: string;
  needRestore: BooleanLike;
};

type LogConsole = {
  messages: LogFile[];
};

export const NTosTextLogViewer = () => {
  const { data } = useBackend<LogConsole>();
  const { messages = [] } = data;

  const [selectedKey, setSelectedKey] = useState<string | null>(null);
  const [restored, setRestored] = useState(false);

  const scrollRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages.length, selectedKey]);

  const handleSelectLog = (file: LogFile) => {
    const key = `${file.timestamp}-${file.author}`;
    setSelectedKey(key);
    setRestored(false);
    scrollToBottom();
  };

  const handleRestore = () => {
    setRestored(true);
  };

  const selectedFile = selectedKey
    ? messages.find((f) => `${f.timestamp}-${f.author}` === selectedKey)
    : undefined;

  return (
    <NtosWindow width={720} height={480}>
      <NtosWindow.Content>
        <Stack fill>
          <Stack.Item basis="30%">
            <Section title="Logs" fill scrollable>
              {messages.length > 0 ? (
                messages.map((file) => {
                  const key = `${file.timestamp}-${file.author}`;
                  return (
                    <Button
                      key={key}
                      fluid
                      selected={selectedKey === key}
                      onClick={() => handleSelectLog(file)}
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
              fill
            >
              <div
                ref={scrollRef}
                style={{
                  height: '100%',
                  overflow: 'auto',
                  padding: '1em',
                }}
              >
                {selectedFile ? (
                  <Box>
                    <Box
                      as="pre"
                      mb={1}
                      fontFamily="Courier"
                      style={{ whiteSpace: 'pre-wrap' }}
                    >
                      {selectedFile.message}
                    </Box>

                    {!!selectedFile.needRestore && !restored && (
                      <Button icon="redo" color="good" onClick={handleRestore}>
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
      </NtosWindow.Content>
    </NtosWindow>
  );
};
