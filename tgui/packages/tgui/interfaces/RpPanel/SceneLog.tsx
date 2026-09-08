import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { LogEntry, RpPanelData } from './types';

const MODE_CLASS: Record<string, string> = {
  say: 'say',
  emote: 'emote',
  subtle: 'subtle',
  subtler: 'subtler',
  subtler_antighost: 'subtler',
  system: 'system',
};

function formatMessage(entry: LogEntry) {
  if (entry.mode === 'say' && !entry.message.startsWith('"')) {
    return `"${entry.message}"`;
  }
  return entry.message;
}

type SceneLogProps = {
  onExamine: (ref: string) => void;
};

export function SceneLog(props: SceneLogProps) {
  const { data, act } = useBackend<RpPanelData>();
  const { onExamine } = props;
  const {
    messages = [],
    scene_details,
    typing = [],
    settings = {
      font: 'Verdana',
      font_size: 100,
      line_spacing: 1.35,
      show_avatars: 1,
      avatar_size: 64,
    },
    max_chars = 2000,
    emote_mode,
    emote_modes = [],
  } = data;
  const logRef = useRef<HTMLDivElement>(null);
  const [draft, setDraft] = useState('');

  useEffect(() => {
    const node = logRef.current;
    if (node) {
      node.scrollTop = node.scrollHeight;
    }
  }, [messages.length]);

  const fontStyle = useMemo(
    () => ({
      fontFamily: settings.font,
      fontSize: `${settings.font_size}%`,
      lineHeight: settings.line_spacing,
    }),
    [settings.font, settings.font_size, settings.line_spacing],
  );

  const send = () => {
    const trimmed = draft.trim();
    if (!trimmed) {
      return;
    }
    act('send_message', { message: trimmed });
    setDraft('');
    act('set_typing', { typing: 0 });
  };

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill>
          <Box
            ref={logRef}
            className="SceneAssistant__log"
            style={fontStyle}
            height="100%"
            overflow="auto"
          >
            {!!scene_details && (
              <NoticeBox className="SceneAssistant__scenePin">
                {scene_details}
              </NoticeBox>
            )}
            {!messages.length && (
              <Box italic color="label">
                No messages yet. Send an emote to start!
              </Box>
            )}
            {messages.map((entry, index) => (
              <Box
                key={`${entry.timestamp}-${index}`}
                className={`SceneAssistant__logEntry SceneAssistant__logEntry--${MODE_CLASS[entry.mode] || 'other'}`}
              >
                <Stack>
                  {!!settings.show_avatars && (
                    <Stack.Item>
                      {entry.headshot ? (
                        <img
                          src={entry.headshot}
                          className="SceneAssistant__avatar"
                          style={{
                            width: `${settings.avatar_size}px`,
                            height: `${settings.avatar_size}px`,
                            cursor: entry.ref ? 'pointer' : 'default',
                          }}
                          onClick={() => entry.ref && onExamine(entry.ref)}
                        />
                      ) : (
                        <Box
                          className="SceneAssistant__avatar SceneAssistant__avatar--empty"
                          style={{
                            width: `${settings.avatar_size}px`,
                            height: `${settings.avatar_size}px`,
                          }}
                        >
                          No headshot
                        </Box>
                      )}
                    </Stack.Item>
                  )}
                  <Stack.Item grow>
                    {entry.mode === 'system' ? (
                      <Box italic color="purple">
                        {entry.message}
                      </Box>
                    ) : (
                      <>
                        <Box
                          bold
                          style={{ color: entry.color }}
                          onClick={() => entry.ref && onExamine(entry.ref)}
                        >
                          {entry.name}
                        </Box>
                        <Box>{formatMessage(entry)}</Box>
                      </>
                    )}
                  </Stack.Item>
                </Stack>
              </Box>
            ))}
            {!!typing.length && (
              <Box italic color="label" mt={1}>
                {typing.join(', ')} {typing.length === 1 ? 'is' : 'are'} typing
                …
              </Box>
            )}
          </Box>
        </Section>
      </Stack.Item>
      <Stack.Item className="SceneAssistant__composerWrap">
        <textarea
          className="SceneAssistant__composer"
          maxLength={max_chars}
          placeholder="This is a resizeable text box to write in!"
          value={draft}
          onChange={(event) => {
            const value = event.target.value;
            setDraft(value);
            act('set_typing', { typing: value.length > 0 ? 1 : 0 });
          }}
          onKeyDown={(event) => {
            if (event.key !== 'Enter') {
              return;
            }
            if (event.shiftKey) {
              if (emote_mode === 'say') {
                event.preventDefault();
                setDraft((value) => `${value} `);
              }
              return;
            }
            event.preventDefault();
            send();
          }}
        />
        <Stack mt={0.5}>
          <Stack.Item grow color="label">
            {draft.length} / {max_chars} characters
          </Stack.Item>
          <Stack.Item>
            <Dropdown
              selected={emote_mode}
              options={emote_modes.map((mode) => ({
                displayText: mode.label,
                value: String(mode.id),
              }))}
              onSelected={(value) => act('set_emote_mode', { mode: value })}
            />
          </Stack.Item>
          <Stack.Item>
            <Button icon="paper-plane" color="blue" onClick={send}>
              Send
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button icon="download" tooltip="Export log" onClick={() => act('export_log')} />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
}
