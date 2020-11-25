import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Card, Form, Input, Table, Tag, Button, Popconfirm, notification, message } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import moment from 'moment';
import styles from './JobLog.less';

const { Search } = Input;

@connect(({ jobLog, loading }) => ({
  list: jobLog.list.content,
  total: jobLog.list.totalElements,
  loading: loading.models.jobLog,
}))
@Form.create()
class JobLog extends PureComponent {
  state = {
    current: 1,
    pageSize: 10,
    search: null,
  };

  columns = [
    {
      title: '名称',
      dataIndex: 'jobName',
      key: 'jobName',
      width: '15%',
    },
    {
      title: 'Bean',
      dataIndex: 'beanName',
      key: 'beanName',
      width: '5%',
      render: text => {
        return <Tag color="blue">{text}</Tag>;
      },
    },
    {
      title: '执行方法',
      dataIndex: 'methodName',
      key: 'methodName',
      width: '8%',
    },
    {
      title: '参数',
      dataIndex: 'params',
      key: 'params',
      width: '8%',
    },
    {
      title: 'Cron表达式',
      dataIndex: 'cronExpression',
      key: 'cronExpression',
      width: '10%',
    },
    {
      title: '状态',
      dataIndex: 'isSuccess',
      key: 'isSuccess',
      width: '5%',
      render: text => {
        if (text) {
          return <Tag color="green">成功</Tag>;
        }
        return <Tag color="red">失败</Tag>;
      },
    },
    {
      title: '异常详情',
      dataIndex: 'exceptionDetail',
      key: 'exceptionDetail',
    },
    {
      title: '运行日期',
      dataIndex: 'createTime',
      key: 'createTime',
      width: '12%',
      render: text => {
        return moment(text).format('lll');
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { pageSize, current } = this.state;
    dispatch({
      type: 'jobLog/fetch',
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
      type: 'jobLog/fetch',
      payload: { pageSize, current, search },
    });
  };

  handleDeleteAllJobLog = () => {
    const { dispatch } = this.props;
    const { pageSize } = this.state;
    this.setState({
      current: 1,
      search: null,
    });
    dispatch({
      type: 'jobLog/deleteAll',
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
          title="所有任务日志都会被清空，确认操作？"
          onConfirm={this.handleDeleteAllJobLog}
          okText="确认删除"
          cancelText="取消"
        >
          <Button htmlType="button" type="danger">
            清空所有日志
          </Button>
        </Popconfirm>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入任务名进行搜索"
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
            title="任务日志"
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

export default JobLog;
