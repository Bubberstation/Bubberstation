import type { BooleanLike } from 'tgui-core/react';

export function asArray<T>(value: T[] | unknown): T[] {
  return Array.isArray(value) ? value : [];
}

export type Person = {
  name: string;
  ref: string;
  headshot: string;
  color: string;
  is_you?: BooleanLike;
};

export type LogEntry = {
  name: string;
  message: string;
  headshot: string;
  mode: string;
  timestamp: string;
  ref: string;
  color: string;
};

export type StatusTag = {
  label: string;
  value: string;
};

export type LewdSlot = {
  name: string;
  img: string | null;
};

export type PrefChoice = {
  value: string;
  options: string[];
};

export type GenitalEntry = {
  slot: string;
  name: string;
  visibility: number;
};

export type Option = {
  id: string | number;
  label: string;
};

export type TargetData = {
  name: string;
  ref: string;
  headshot: string;
  is_self: BooleanLike;
  details: string[];
  tags: StatusTag[];
  has_reference: BooleanLike;
  show_erp: BooleanLike;
  your_name?: string;
  pleasure?: number;
  arousal?: number;
  pain?: number;
  their_name?: string;
  their_pleasure?: number;
  their_arousal?: number;
  their_pain?: number;
  block_interact: BooleanLike;
  categories: string[];
  interactions: Record<string, string[]>;
  descriptions: Record<string, string>;
  colors: Record<string, string>;
  lewd_slots: LewdSlot[];
};

export type SelfData = {
  show_erp: BooleanLike;
  autocum: BooleanLike;
  prefs: Record<string, PrefChoice>;
  genitals: GenitalEntry[];
  underwear: {
    underwear: BooleanLike;
    bra: BooleanLike;
    undershirt: BooleanLike;
    socks: BooleanLike;
  };
};

export type SettingsData = {
  theme: string;
  soundpack: string;
  sound_message: BooleanLike;
  sound_join: BooleanLike;
  sound_leave: BooleanLike;
  volume_message: number;
  volume_join: number;
  volume_leave: number;
  show_avatars: BooleanLike;
  avatar_size: number;
  font: string;
  font_size: number;
  line_spacing: number;
};

export type RpPanelData = {
  max_chars: number;
  arousal_limit: number;
  themes: Option[];
  soundpacks: Option[];
  avatar_sizes: Option[];
  fonts: string[];
  font_sizes: Option[];
  line_spacings: Option[];
  emote_mode: string;
  emote_modes: Option[];
  scene_details: string;
  messages: LogEntry[];
  you: Person;
  participants: Person[];
  nearby: Person[];
  typing: string[];
  selected_ref: string;
  target: TargetData;
  self: SelfData;
  settings: SettingsData;
};
