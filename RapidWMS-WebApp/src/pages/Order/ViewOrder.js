import React, { PureComponent } from 'react';
import { connect } from 'dva';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import OrderDetail from './OrderDetail';

@connect(({ order, loading }) => ({
  order: order.detail,
  loading: loading.models.order,
}))
class AuditOrder extends PureComponent {
  componentDidMount() {
    const {
      dispatch,
      match: {
        params: { id },
      },
    } = this.props;
    dispatch({
      type: 'order/fetchDetail',
      payload: id,
    });
  }

  render() {
    const {
      order,
      loading,
      match: {
        params: { id },
      },
    } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const initialProps = {
      order,
      queryParams,
      loading,
      isView: true,
      id,
    };

    return (
      <PageHeaderWrapper>
        <OrderDetail {...initialProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AuditOrder;
