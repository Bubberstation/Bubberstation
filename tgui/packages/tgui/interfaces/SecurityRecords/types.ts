import { BooleanLike } from 'common/react';

export type SecurityRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
  available_statuses: string[];
  records: SecurityRecord[];
  min_age: number;
  max_age: number;
};

export type SecurityRecord = {
  age: number;
  citations: Crime[];
  crew_ref: string;
  crimes: Crime[];
  fingerprint: string;
  gender: string;
  name: string;
  note: string;
  rank: string;
  species: string;
  wanted_status: string;
  // SKYRAT EDIT START - RP Records
  past_security_records: string;
  // SKYRAT EDIT END
};

export type Crime = {
  author: string;
  crime_ref: string;
  details: string;
  fine: number;
  name: string;
  paid: number;
  time: number;
};

export enum SECURETAB {
  Crimes,
  Citations,
  Add,
}

export enum PRINTOUT {
  Missing = 'missing',
  Rapsheet = 'rapsheet',
  Wanted = 'wanted',
}
