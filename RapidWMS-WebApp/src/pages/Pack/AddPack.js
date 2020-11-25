import React, { PureComponent } from 'react';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import PackForm from './PackForm';

class AddPack extends PureComponent {
  render() {
    const { pack } = this.props;

    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const formProps = {
      pack,
      queryParams,
      loading: false,
      isEdit: false,
    };

    return (
      <PageHeaderWrapper>
        <PackForm {...formProps} />
      </PageHeaderWrapper>
    );
  }
}

export default AddPack;
