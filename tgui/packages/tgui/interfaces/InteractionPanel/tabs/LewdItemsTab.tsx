// THIS IS A BUBBER UI FILE
import { Box, Button, Icon, Stack } from 'tgui-core/components';

import { useBackend } from '../../../backend';

type LewdSlot = {
  img: string;
  name: string;
  item_name: string;
  lewd_slots: LewdSlot[];
  ref_self: string;
  ref_user: string;
};

type LewdItemsTabPropsData = {
  searchText: string;
};

export const LewdItemsTab = (props: LewdItemsTabPropsData) => {
  const { act, data } = useBackend<LewdSlot>();
  const { lewd_slots = [], ref_self, ref_user } = data;
  const { searchText } = props;
  const searchLower = searchText.toLowerCase();

  const filteredSlots = lewd_slots.filter((slot) => {
    return (
      slot.name.toLowerCase().includes(searchLower) ||
      slot.item_name?.toLowerCase().includes(searchLower)
    );
  });

  return (
    <Stack fill>
      {filteredSlots.length > 0 && (
        <Stack fill>
          {filteredSlots.map((slot) => {
            return (
              <Stack.Item key={slot.name}>
                <Button
                  onClick={() =>
                    act('remove_lewd_item', {
                      item_slot: slot.name,
                      selfref: ref_self,
                      userref: ref_user,
                    })
                  }
                  color="pink"
                  tooltip={`${slot.name}${slot.item_name ? ` - ${slot.item_name}` : ''}`}
                >
                  <Box
                    style={{
                      width: '32px',
                      height: '32px',
                      margin: '0.5em 0',
                    }}
                  >
                    {slot.img ? (
                      <img
                        src={`data:image/png;base64,${slot.img}`}
                        style={{
                          width: '100%',
                          height: '100%',
                        }}
                      />
                    ) : (
                      <Icon
                        name="eye-slash"
                        size={2}
                        ml={0}
                        mt={0.75}
                        style={{
                          textAlign: 'center',
                        }}
                      />
                    )}
                  </Box>
                </Button>
              </Stack.Item>
            );
          })}
        </Stack>
      )}
    </Stack>
  );
};
