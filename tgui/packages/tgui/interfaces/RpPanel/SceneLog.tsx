import { useLayoutEffect, useMemo, useRef, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  NoticeBox,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { sanitizeText } from '../../sanitize';
import { asArray, type LogEntry, type RpPanelData } from './types';
import sceneAssistantIcon from './scene_assistant.png';

const MODE_CLASS: Record<string, string> = {
  say: 'say',
  whisper: 'whisper',
  emote: 'emote',
  subtle: 'subtle',
  subtler: 'subtler',
  subtler_antighost: 'subtler',
  system: 'system',
};

function applyChatEmphasis(raw: string): string {
  let input = raw
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
  const wrap = (marker: string, tag: string) => {
    const pattern = new RegExp(`(?<!\\\\)${marker}(.+?)(?<!\\\\)${marker}`, 'g');
    input = input.replace(pattern, `<${tag}>$1</${tag}>`);
  };
  wrap('\\|', 'i');
  wrap('\\+', 'b');
  wrap('_', 'u');
  wrap('\\^', 'small');
  input = input.replace(/\\(_|\+|\||\^)/g, '$1');
  return sanitizeText(input.replace(/\r\n|\n|\r/g, '<br>'));
}

function formatMessageHtml(entry: LogEntry) {
  let message = entry.message || '';
  if (
    (entry.mode === 'say' || entry.mode === 'whisper') &&
    !message.startsWith('"')
  ) {
    message = `"${message}"`;
  }
  return { __html: sanitizeText(message) };
}

function isHttpsUrl(url: string | undefined): url is string {
  return !!url && url.startsWith('https://') && !/[<>"']/.test(url);
}

type SceneLogProps = {
  onExamine: (ref: string) => void;
};

export function SceneLog(props: SceneLogProps) {
  const { data, act } = useBackend<RpPanelData>();
  const { onExamine } = props;
  const {
    scene_details,
    settings = {
      font: 'Verdana',
      font_size: 100,
      line_spacing: 1.35,
      show_avatars: 1,
      avatar_size: 64,
    },
    max_chars = 2000,
    emote_mode,
  } = data;
  const messages = asArray<LogEntry>(data.messages);
  const typing = asArray<string>(data.typing);
  const emote_modes = asArray(data.emote_modes);
  const logRef = useRef<HTMLDivElement>(null);
  const stickToBottomRef = useRef(true);
  const prevCountRef = useRef(0);
  const [draft, setDraft] = useState('');
  const [unread, setUnread] = useState(0);
  const [imageOpen, setImageOpen] = useState(false);
  const [imageDraft, setImageDraft] = useState('');

  const scrollToBottom = () => {
    const node = logRef.current;
    if (!node) {
      return;
    }
    node.scrollTop = node.scrollHeight;
    stickToBottomRef.current = true;
    setUnread(0);
  };

  const onLogScroll = () => {
    const node = logRef.current;
    if (!node) {
      return;
    }
    const nearBottom =
      node.scrollHeight - node.scrollTop - node.clientHeight <= 48;
    stickToBottomRef.current = nearBottom;
    if (nearBottom) {
      setUnread(0);
    }
  };

  useLayoutEffect(() => {
    const node = logRef.current;
    if (!node) {
      return;
    }
    const added = messages.length - prevCountRef.current;
    prevCountRef.current = messages.length;
    if (stickToBottomRef.current) {
      node.scrollTop = node.scrollHeight;
      setUnread(0);
      return;
    }
    if (added > 0) {
      setUnread((count) => count + added);
    }
  }, [messages.length, typing.length]);

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
    const imageUrl = imageDraft.trim();
    if (imageUrl) {
      act('send_image', { url: imageUrl, caption: trimmed });
      setDraft('');
      setImageDraft('');
      setImageOpen(false);
      act('set_typing', { typing: 0 });
      stickToBottomRef.current = true;
      setUnread(0);
      return;
    }
    if (!trimmed) {
      return;
    }
    act('send_message', { message: trimmed });
    setDraft('');
    act('set_typing', { typing: 0 });
    stickToBottomRef.current = true;
    setUnread(0);
  };

  return (
    <Stack fill vertical className="SceneAssistant__logStack">
      <Stack.Item grow className="SceneAssistant__logPane">
        <div
          ref={logRef}
          className="SceneAssistant__log"
          style={fontStyle}
          onScroll={onLogScroll}
        >
            {!!scene_details && (
              <NoticeBox className="SceneAssistant__scenePin">
                <span
                  dangerouslySetInnerHTML={{
                    __html: applyChatEmphasis(scene_details),
                  }}
                />
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
                      {entry.mode === 'system' ? (
                        <img
                          src={sceneAssistantIcon}
                          className="SceneAssistant__avatar SceneAssistant__avatar--system"
                          style={{
                            width: `${settings.avatar_size}px`,
                            height: `${settings.avatar_size}px`,
                          }}
                        />
                      ) : entry.headshot ? (
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
                      <Box
                        italic
                        color="purple"
                        dangerouslySetInnerHTML={{
                          __html: sanitizeText(entry.message || ''),
                        }}
                      />
                    ) : (
                      <>
                        <Box
                          bold
                          style={{ color: entry.color }}
                          onClick={() => entry.ref && onExamine(entry.ref)}
                        >
                          {entry.name}
                        </Box>
                        {!!entry.message && (
                          <Box dangerouslySetInnerHTML={formatMessageHtml(entry)} />
                        )}
                        {isHttpsUrl(entry.image) && (
                          <img
                            src={entry.image}
                            className="SceneAssistant__logImage"
                            onClick={() =>
                              act('open_image', { url: entry.image })
                            }
                          />
                        )}
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
          </div>
        {unread > 0 && (
          <Button
            className="SceneAssistant__newMessage"
            icon="arrow-down"
            color="blue"
            onClick={scrollToBottom}
          >
            {unread === 1 ? 'New Message' : `New Messages (${unread})`}
          </Button>
        )}
      </Stack.Item>
      <Stack.Item className="SceneAssistant__composerWrap">
        <textarea
          className="SceneAssistant__composer"
          maxLength={max_chars}
          placeholder={
            imageOpen
              ? 'Optional caption for the image (scene log only)'
              : 'This is a resizeable text box to write in!'
          }
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
              if (emote_mode === 'say' || emote_mode === 'whisper') {
                event.preventDefault();
                setDraft((value) => `${value} `);
              }
              return;
            }
            event.preventDefault();
            send();
          }}
        />
        {imageOpen && (
          <input
            className="SceneAssistant__imageUrl"
            placeholder="https:// direct image link (Catbox, Imgbox, Gyazo, Lensdump, F-List)"
            value={imageDraft}
            onChange={(event) => setImageDraft(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === 'Enter') {
                event.preventDefault();
                send();
              }
            }}
          />
        )}
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
            <Button
              icon="image"
              color={imageOpen ? 'blue' : undefined}
              selected={imageOpen}
              tooltip="Attach an image. Logged as subtler in the scene, not in IC chat."
              onClick={() => {
                setImageOpen((open) => !open);
                if (imageOpen) {
                  setImageDraft('');
                }
              }}
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
