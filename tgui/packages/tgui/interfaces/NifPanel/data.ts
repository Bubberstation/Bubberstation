// THIS IS A BUBBER UI FILE
import type { BooleanLike } from 'tgui-core/react';

export type NifProgramData = {
  name: string;
  desc: string;
  active: BooleanLike;
  active_mode: BooleanLike;
  activation_cost: number;
  active_cost: number;
  reference: string;
  ui_icon: string;
  able_to_keep: BooleanLike;
  keep_installed: BooleanLike;
};

export type NifPanelData = {
  linked_mob_name: string;
  current_theme: string;
  power_level: number;
  power_usage: number;
  nutrition_drain: number;
  nutrition_level: number;
  blood_level: number;
  blood_drain: BooleanLike;
  minimum_blood_level: number;
  durability: number;
  current_examine_text?: string;

  loaded_nifsofts: NifProgramData[];
  ui_themes: string[];
  max_nifsofts: number;
  max_durability: number;
  max_power: number;
  max_blood_level: number;
  product_notes: string;
  stored_points: number;
  default_examine_text: string;
};
