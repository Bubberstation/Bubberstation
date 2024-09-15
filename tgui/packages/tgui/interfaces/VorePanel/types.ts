import { BooleanLike } from 'tgui-core/react';

export type Prey = {
  name: string;
  ref: string;
  appearance: string;
  absorbed: BooleanLike;
};

export enum DigestMode {
  Safe = 'Safe',
  Digest = 'Digest',
  Absorb = 'Absorb',
  Unabsorbed = 'Unabsorb',
}

export type Belly = {
  index: number;
  name: string;
  desc: string;
  ref: string;
  contents: Prey[];
  digest_mode: DigestMode;
  burn_damage: number;
  brute_damage: number;
  can_taste: BooleanLike;
  insert_verb: string;
  release_verb: string;
  muffles_radio: BooleanLike;
  escape_chance: number;
  escape_time: number;
  overlay_path: string | null;
  overlay_color: string;
  fancy_sounds: BooleanLike;
  insert_sound: string;
  release_sound: string;
  is_wet: BooleanLike;
  wet_loop: BooleanLike;
  messages: { [key: string]: string[] };
};

export type PreyBellyView = Omit<Belly, 'index' | 'ref'> & {
  owner_name: string;
};

export type FullscreenOverlay = {
  path: string;
  name: string;
  icon: string;
  icon_state: string;
  recolorable: BooleanLike;
};

export type Data = {
  max_bellies: number;
  max_prey: number;
  max_verb_length: number;
  max_vore_message_length: number;
  min_vore_message_length: number;
  max_burn_damage: number;
  max_brute_damage: number;
  max_escape_time: number;
  min_escape_time: number;
  selected_belly: number;
  bellies: Belly[];
  preferences: { [key: string]: any };
  current_slot: string;
  inside: PreyBellyView | null;
  character_slots: string[] | null;
  vore_slots: { [key: string]: number } | null;
  lookup_table: { [key: string]: number } | null;
  available_overlays: FullscreenOverlay[];
  not_our_owner: BooleanLike;
};

export const digestModeToPreyMode = {
  [DigestMode.Safe]: { text: 'being held.', color: 'good' },
  [DigestMode.Digest]: { text: 'being digested.', color: 'bad' },
  [DigestMode.Absorb]: { text: 'being absorbed.', color: 'purple' },
  [DigestMode.Unabsorbed]: { text: 'being reformed.', color: 'good' },
};

export const bellyKeyToText = {
  digest_messages_pred: 'Digest Messages (Owner)',
  digest_messages_prey: 'Digest Messages (Prey)',
  absorb_messages_owner: 'Absorb Messages (Owner)',
  absorb_messages_prey: 'Absorb Messages (Prey)',
  unabsorb_messages_owner: 'Unabsorb Messages (Owner)',
  unabsorb_messages_prey: 'Unabsorb Messages (Prey)',
  struggle_messages_outside: 'Struggle Messages (Outside)',
  struggle_messages_inside: 'Struggle Messages (Inside)',
  absorbed_struggle_messages_outside: 'Absorbed Struggle Messages (Outside)',
  absorbed_struggle_messages_inside: 'Absorbed Struggle Messages (Inside)',
  escape_attempt_messages_owner: 'Escape Attempt Messages (Owner)',
  escape_attempt_messages_prey: 'Escape Attempt Messages (Prey)',
  escape_messages_owner: 'Escape Messages (Owner)',
  escape_messages_prey: 'Escape Messages (Prey)',
  escape_messages_outside: 'Escape Messages (Outside)',
  escape_fail_messages_owner: 'Escape Fail Messages (Owner)',
  escape_fail_messages_prey: 'Escape Fail Messages (Prey)',
};
