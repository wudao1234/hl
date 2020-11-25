import React, { PureComponent } from 'react';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import OrderForm from './OrderForm';

class AddOrder extends PureComponent {
  render() {
    const { order } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      order,
      queryParams,
      loading: false,
      isEdit: false,
    };

    return (
      <PageHeaderWrapper>
        <OrderForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AddOrder;
