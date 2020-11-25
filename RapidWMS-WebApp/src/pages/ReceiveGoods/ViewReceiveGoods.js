import React, { PureComponent } from 'react';
import { connect } from 'dva';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import ReceiveGoodsDetail from './ReceiveGoodsDetail';

@connect(({ receiveGoods, loading }) => ({
  receiveGoods: receiveGoods.detail,
  loading: loading.models.receiveGoods,
}))
class AuditReceiveGoods extends PureComponent {
  componentDidMount() {
    const {
      dispatch,
      match: {
        params: { id },
      },
    } = this.props;
    dispatch({
      type: 'receiveGoods/fetchDetail',
      payload: id,
    });
  }

  render() {
    const {
      receiveGoods,
      match: {
        params: { id },
      },
      loading,
    } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const initialProps = {
      receiveGoods,
      queryParams,
      loading,
      isView: true,
      id,
    };

    return (
      <PageHeaderWrapper>
        <ReceiveGoodsDetail {...initialProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AuditReceiveGoods;
