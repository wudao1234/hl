import React, { PureComponent } from 'react';
import { connect } from 'dva';
import {
  Button,
  Card,
  Form,
  Input,
  message,
  notification,
  Popconfirm,
  Table,
  Typography,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import styles from './Redis.less';

const { Search } = Input;
const { Paragraph } = Typography;

@connect(({ redis, loading }) => ({
  list: redis.list.content,
  total: redis.list.totalElements,
  loading: loading.models.redis,
}))
@Form.create()
class Redis extends PureComponent {
  state = {
    current: 1,
    pageSize: 10,
    search: null,
  };

  columns = [
    {
      title: '#',
      width: '3%',
      key: 'index',
      render: (text, record, index) => `${index + 1}`,
    },
    {
      title: 'Key',
      dataIndex: 'key',
      key: 'key',
      width: '30%',
      render: text => {
        return <Paragraph ellipsis>${text}</Paragraph>;
      },
    },
    {
      title: 'Value',
      dataIndex: 'value',
      key: 'value',
      render: text => {
        return <Paragraph ellipsis>${text}</Paragraph>;
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { pageSize, current } = this.state;
    dispatch({
      type: 'redis/fetch',
      payload: { pageSize, current },
    });
  }

  handleChangePage = (page, size) => {
    const { dispatch } = this.props;
    const { search } = this.state;
    this.setState({
      current: page,
      pageSize: size,
    });
    this.handleQuery(dispatch, size, page, search);
  };

  handleShowSizeChange = (newCurrent, newPageSize) => {
    const { dispatch, search } = this.props;
    this.setState({
      current: newCurrent,
      pageSize: newPageSize,
    });
    this.handleQuery(dispatch, newPageSize, newCurrent, search);
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleSearchByKey = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, current } = this.state;
    this.handleQuery(dispatch, pageSize, current, search);
  };

  handleQuery = (dispatch, pageSize, current, search) => {
    dispatch({
      type: 'redis/fetch',
      payload: { pageSize, current, search },
    });
  };

  handleDeleteAllRedis = () => {
    const { dispatch } = this.props;
    const { pageSize } = this.state;
    this.setState({
      current: 1,
      search: null,
    });
    dispatch({
      type: 'redis/deleteAll',
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('清空缓存成功');
          this.handleQuery(dispatch, pageSize, 1, null);
        }
      },
    });
  };

  render() {
    const { list, total, loading } = this.props;
    const { current, pageSize } = this.state;

    const searchContent = (
      <div className={styles.extraContent}>
        <Popconfirm
          title="确认清空Redis缓存？"
          onConfirm={this.handleDeleteAllRedis}
          okText="确认删除"
          cancelText="取消"
        >
          <Button htmlType="button" type="danger">
            清空所有缓存
          </Button>
        </Popconfirm>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入Key进行搜索"
          onSearch={this.handleSearchByKey}
        />
      </div>
    );

    const paginationProps = {
      showSizeChanger: true,
      showQuickJumper: true,
      onChange: this.handleChangePage,
      onShowSizeChange: this.handleShowSizeChange,
      showTotal: this.handleTotal,
      current,
      total,
      pageSize,
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="Redis缓存"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <Table
              columns={this.columns}
              dataSource={list}
              rowKey="key"
              loading={loading}
              pagination={paginationProps}
            />
          </Card>
        </div>
      </PageHeaderWrapper>
    );
  }
}

export default Redis;
