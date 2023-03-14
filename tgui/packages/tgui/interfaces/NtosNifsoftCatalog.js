import { useBackend, useSharedState } from '../backend';
import { NtosWindow } from '../layouts';
import { BlockQuote, Button, Collapsible, Flex, Section, Tabs } from '../components';

export const NtosNifsoftCatalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { product_list = [] } = data;
  const [tab, setTab] = useSharedState(
    context,
    'product_category',
    product_list[0].name
  );

  const products =
    product_list.find((product_category) => product_category.name === tab)
      ?.products || [];

  return (
    <NtosWindow width={500} height={700}>
      <NtosWindow.Content scrollable>
        <Tabs fluid>
          {product_list.map((product_category) => (
            <Tabs.Tab
              key={product_category.key}
              textAlign="center"
              onClick={() => setTab(product_category.name)}
              selected={tab === product_category.name}>
              <b>{product_category.name}</b>
            </Tabs.Tab>
          ))}
        </Tabs>
        <ProductCategory products={products} />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const ProductCategory = (props, context) => {
  const { act, data } = useBackend(context);
  const { target_nif, paying_account } = data;
  const { products } = props;

  return (
    <Section>
      <Flex direction="Column">
        {products.map((product) => (
          <Flex.Item key={product.key}>
            <Section title={product.name} fill={false}>
              <Collapsible title="Product Notes">
                <BlockQuote>{product.desc}</BlockQuote>
              </Collapsible>
              <Button
                icon="shopping-bag"
                color="green"
                disabled={!paying_account}
                onClick={() =>
                  act('purchase_product', {
                    product_to_buy: product.reference,
                    product_cost: product.price,
                  })
                }
                fluid>
                Purchase for {product.price}cr
              </Button>
            </Section>
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};
