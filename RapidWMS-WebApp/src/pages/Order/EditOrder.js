import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Form } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import OrderForm from './OrderForm';

@connect(({ order, loading }) => ({
  order: order.detail,
  loading: loading.models.order,
}))
@Form.create()
class EditOrder extends PureComponent {
  componentDidMount() {
    const {
      dispatch,
      match: {
        params: { id },
      },
    } = this.props;
    dispatch({
      type: 'order/fetchDetailForEdit',
      payload: id,
    });
  }

  render() {
    const { order, loading } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      order,
      queryParams,
      loading,
      isEdit: true,
    };

    return (
      <PageHeaderWrapper>
        <OrderForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default EditOrder;
