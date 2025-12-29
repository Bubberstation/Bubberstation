import type { BooleanLike } from 'tgui-core/react';

export type LogFile = {
  message: string;
  author: string;
  timestamp: string;
  needRestore: BooleanLike;
};

export type LogConsole = {
  messages: LogFile[];
  visible: BooleanLike;
};
