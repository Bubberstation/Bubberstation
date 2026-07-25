export interface NaniteProgram {
  name: string;
  id: string;
  desc: string;
  activated: boolean;
  activation_code: number;
  use_rate: number;
  deactivation_code: number;
  kill_code: number;
  trigger_cost: number;
  trigger_cooldown: number;
  trigger_code: number;
  can_trigger: boolean;
  timer_restart: number;
  timer_shutdown: number;
  timer_trigger: number;
  timer_trigger_delay: number;
  has_extra_settings: boolean;
  extra_settings: ExtraSetting[];
  rules: NaniteRules[];
  can_rule?: boolean;
  has_rules?: boolean;
  all_rules_required?: boolean;
}

export interface NaniteRules {
  display: string;
  id: string;
}

export interface Techweb {
  name: string;
  organization: string;
}
