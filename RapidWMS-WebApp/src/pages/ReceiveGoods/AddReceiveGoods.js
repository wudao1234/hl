import React, { PureComponent } from 'react';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import ReceiveGoodsForm from './ReceiveGoodsForm';

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
        <ReceiveGoodsForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AddReceiveGoods;
