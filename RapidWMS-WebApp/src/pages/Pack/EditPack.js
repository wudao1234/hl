import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Form } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import PackForm from './PackForm';

@connect(({ pack, loading }) => ({
  pack: pack.detail,
  loading: loading.models.pack,
}))
@Form.create()
class EditPack extends PureComponent {
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
    const { pack, loading } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      pack,
      queryParams,
      loading,
      isEdit: true,
    };

    return (
      <PageHeaderWrapper>
        <PackForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default EditPack;
