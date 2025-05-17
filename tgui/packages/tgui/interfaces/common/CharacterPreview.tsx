import { ByondUi } from 'tgui-core/components';

export const CharacterPreview = (props: {
  width?: string; // BUBBER EDIT
  height: string;
  id: string;
}) => {
  // BUBBER EDIT
  const { width = '225px' } = props;
  // BUBBER EDIT END
  return (
    <ByondUi
      width={width} // BUBBER EDIT
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
