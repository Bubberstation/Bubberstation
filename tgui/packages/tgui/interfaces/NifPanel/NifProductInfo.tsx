// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import { BlockQuote, Section } from 'tgui-core/components';
import type { NifPanelData } from './data';

export function NifProductInfo() {
  const { data } = useBackend<NifPanelData>();
  const { product_notes } = data;

  return (
    <Section title="Product Info">
      <BlockQuote>{product_notes}</BlockQuote>
    </Section>
  );
}
