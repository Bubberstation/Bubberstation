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
  fancy_sounds: BooleanLike;
  insert_sound: string;
  release_sound: string;
  is_wet: BooleanLike;
  wet_loop: BooleanLike;
};

export type PreyBellyView = Omit<Belly, 'index' | 'ref'> & {
  owner_name: string;
};

export type Data = {
  max_bellies: number;
  max_prey: number;
  max_verb_length: number;
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
  not_our_owner: BooleanLike;
};

export const digestModeToPreyMode = {
  [DigestMode.Safe]: { text: 'being held.', color: 'good' },
  [DigestMode.Digest]: { text: 'being digested.', color: 'bad' },
  [DigestMode.Absorb]: { text: 'being absorbed.', color: 'purple' },
  [DigestMode.Unabsorbed]: { text: 'being reformed.', color: 'good' },
};
