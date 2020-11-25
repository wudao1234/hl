import React, { PureComponent } from 'react';
import { connect } from 'dva';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import PackDetail from './PackDetail';

@connect(({ pack, loading }) => ({
  pack: pack.detail,
  loading: loading.models.pack,
}))
class AuditPack extends PureComponent {
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
  }

  render() {
    const {
      pack,
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
      pack,
      queryParams,
      loading,
      isView: true,
      id,
    };

    return (
      <PageHeaderWrapper>
        <PackDetail {...initialProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AuditPack;
