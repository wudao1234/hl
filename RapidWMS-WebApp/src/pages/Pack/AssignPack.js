import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Form } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import AssignPackForm from './AssignPackForm';

@connect(({ pack, loading }) => ({
  pack: pack.detail,
  stockFlows: pack.stockFlows,
  loading: loading.models.pack,
}))
@Form.create()
class AssignPack extends PureComponent {
  componentDidMount() {
    const {
      dispatch,
      match: {
        params: { id },
      },
    } = this.props;
    dispatch({
      type: 'pack/fetchDetail',
      payload: id,
    });
    dispatch({
      type: 'pack/fetchStockFlows',
      payload: id,
    });
  }

  render() {
    const { pack, stockFlows, loading } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      pack,
      stockFlows,
      queryParams,
      loading,
      isEdit: true,
    };

    return (
      <PageHeaderWrapper>
        <AssignPackForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AssignPack;
