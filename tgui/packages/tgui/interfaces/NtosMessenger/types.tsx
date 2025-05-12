import { BooleanLike } from 'tgui-core/react';

export type NtMessage = {
  message: string;
  outgoing: BooleanLike;
  photo_path?: string;
  everyone: BooleanLike;
  timestamp: string;
  subtle: BooleanLike; // BUBBER EDIT ADDITION - SUBTLE MESSAGES
};

export type NtPicture = {
  uid: number;
  path: string;
};

export type NtMessenger = {
  name: string;
  job: string;
  ref?: string;
};

export type NtChat = {
  ref: string;
  recipient: NtMessenger;
  messages: NtMessage[];
  visible: BooleanLike;
  owner_deleted: BooleanLike;
  can_reply: BooleanLike;
  message_draft: string;
  unread_messages: number;
};
