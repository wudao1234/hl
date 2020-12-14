import React, { PureComponent } from 'react';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import UnloadGoodsForm from './UnloadGoodsForm';

class AddReceiveGoods extends PureComponent {
  render() {
    const { receiveGoods } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      receiveGoods,
      queryParams,
      loading: false,
      isEdit: false,
    };

    return (
      <PageHeaderWrapper>
        <UnloadGoodsForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AddReceiveGoods;
