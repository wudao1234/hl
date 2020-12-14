import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Form } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import UnloadGoodsAuditForm from './UnloadGoodsAuditForm';

@connect(({ receiveGoods, loading }) => ({
  receiveGoods: receiveGoods.detail,
  loading: loading.models.receiveGoods,
}))
@Form.create()
class AuditUnloadReceiveGoods extends PureComponent {
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
    const { receiveGoods, loading } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      receiveGoods,
      queryParams,
      loading,
      isAudit: true,
    };

    return (
      <PageHeaderWrapper>
        <UnloadGoodsAuditForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AuditUnloadReceiveGoods;
