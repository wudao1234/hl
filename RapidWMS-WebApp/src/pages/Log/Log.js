import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Card, Form, Input, Table, Tag, Button, Popconfirm, notification, message } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import moment from 'moment';
import styles from './Log.less';

const { Search } = Input;

@connect(({ log, loading }) => ({
  list: log.list.content,
  total: log.list.totalElements,
  loading: loading.models.log,
}))
@Form.create()
class Log extends PureComponent {
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
      title: '用户名',
      dataIndex: 'username',
      key: 'username',
      width: '10%',
    },
    {
      title: 'IP',
      dataIndex: 'requestIp',
      key: 'requestIp',
      width: '8%',
    },
    {
      title: '描述',
      dataIndex: 'description',
      key: 'description',
      width: '10%',
    },
    {
      title: '调用方法',
      dataIndex: 'method',
      key: 'method',
      width: '20%',
    },
    {
      title: '参数',
      dataIndex: 'params',
      key: 'params',
      width: '20%',
    },
    {
      title: '耗时',
      dataIndex: 'time',
      key: 'time',
      width: '5%',
      render: text => {
        return <Tag color="blue">{text}ms</Tag>;
      },
    },
    {
      title: '创建时间',
      dataIndex: 'createTime',
      key: 'createTime',
      render: text => {
        return moment(text).format('lll');
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { pageSize, current } = this.state;
    dispatch({
      type: 'log/fetch',
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

  handleSearchByUserName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, current } = this.state;
    this.handleQuery(dispatch, pageSize, current, search);
  };

  handleQuery = (dispatch, pageSize, current, search) => {
    dispatch({
      type: 'log/fetch',
      payload: { pageSize, current, search },
    });
  };

  handleDeleteAllLog = () => {
    const { dispatch } = this.props;
    const { pageSize } = this.state;
    this.setState({
      current: 1,
      search: null,
    });
    dispatch({
      type: 'log/deleteAll',
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
          title="所有日志（包括错误日志）都会被清空，确认操作？"
          onConfirm={this.handleDeleteAllLog}
          okText="确认删除"
          cancelText="取消"
        >
          <Button htmlType="button" type="danger">
            清空所有日志
          </Button>
        </Popconfirm>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入用户名进行搜索"
          onSearch={this.handleSearchByUserName}
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
            title="操作日志"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <Table
              columns={this.columns}
              dataSource={list}
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
            />
          </Card>
        </div>
      </PageHeaderWrapper>
    );
  }
}

export default Log;
