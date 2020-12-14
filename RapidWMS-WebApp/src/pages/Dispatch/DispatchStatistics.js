import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Card, Form, Input, message, Modal, notification, Table, DatePicker } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './DispatchStatistics.less';

const FormItem = Form.Item;
const { Search } = Input;
const { RangePicker } = DatePicker;

@connect(({ dispatchStatistics, loading }) => ({
  list: dispatchStatistics.list.content,
  total: dispatchStatistics.list.totalElements,
  loading: loading.models.dispatchStatistics,
}))
@Form.create()
class DispatchStatistics extends PureComponent {
  state = {
    currentPage: 1,
    pageSize: 10,
    orderBy: null,
    search: null,
    visible: false,
    done: false,
    startDate: null,
    endDate: null,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  columns = [
    {
      title: '#',
      width: '3%',
      key: 'index',
      render: (text, record, index) => `${index + 1}`,
    },
    {
      title: '姓名',
      dataIndex: 'username',
      key: 'username',
      width: '15%',
    },
    {
      title: '配送',
      dataIndex: 'finishScore',
      key: 'finishScore',
      width: '10%',
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, startDate, endDate } = this.state;
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, currentPage, orderBy);
  }

  handleSearchByName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, startDate, endDate } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, 1, null);
  };

  handleQuery = (dispatch, search, startDate, endDate, pageSize, currentPage, orderBy) => {
    let startDateString = null;
    let endDateString = null;
    if (
      startDate !== null &&
      endDate !== null &&
      startDate !== undefined &&
      endDate !== undefined
    ) {
      startDateString = startDate.format('YYYY-MM-DD');
      endDateString = endDate.format('YYYY-MM-DD');
    }
    dispatch({
      type: 'dispatchStatistics/fetch',
      payload: {
        search,
        startDate: startDateString,
        endDate: endDateString,
        pageSize,
        currentPage,
        orderBy,
      },
    });
  };

  showEditModal = item => {
    this.setState({
      visible: true,
      currentItem: item,
    });
  };

  handleDone = () => {
    this.setState({
      done: false,
      visible: false,
    });
  };

  handleCancel = () => {
    this.setState({
      visible: false,
    });
  };

  handleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;
    const { currentItem } = this.state;
    const id = currentItem ? currentItem.id : '';

    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleDone();
      dispatch({
        type: 'dispatchStatistics/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建成功！' : '修改成功！');
            const { search, pageSize, currentPage, orderBy, startDate, endDate } = this.state;
            this.handleQuery(dispatch, search, startDate, endDate, pageSize, currentPage, orderBy);
          }
        },
      });
    });
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search, startDate, endDate } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const orderBy = field !== undefined ? `${field},${order}` : null;
    this.setState({
      currentPage,
      pageSize,
      orderBy,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, currentPage, orderBy);
  };

  handleDateRangeChange = date => {
    const startDate = date[0];
    const endDate = date[1];
    this.setState({
      startDate,
      endDate,
    });
    const { dispatch } = this.props;
    const { pageSize, search } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, 1, null);
  };

  render() {
    const { list, total, loading } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, currentItem = {}, startDate, endDate } = this.state;
    const { pageSize, currentPage } = this.state;

    const modalFooter = done
      ? { footer: null, onCancel: this.handleDone }
      : { okText: '保存', onOk: this.handleSubmit, onCancel: this.handleCancel };

    const paginationProps = {
      showSizeChanger: true,
      showQuickJumper: true,
      showTotal: this.handleTotal,
      current: currentPage,
      total,
      pageSize,
      position: 'both',
    };

    const searchContent = (
      <div className={styles.extraContent}>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入姓名进行搜索"
          onSearch={this.handleSearchByName}
        />
        <RangePicker
          style={{ marginLeft: 10, marginRight: 10 }}
          onChange={this.handleDateRangeChange}
          value={[startDate, endDate]}
        />
      </div>
    );

    const getModalContent = () => {
      if (done) {
        message.success('保存成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="计件单价" {...this.formLayout} hasFeedback>
            {getFieldDecorator('piece', {
              rules: [{ required: true, message: '请输入计件系数' }],
              initialValue: currentItem.piece,
            })(<Input placeholder="请输入计件系数" />)}
          </FormItem>
          <FormItem label="金额系数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('money', {
              rules: [{ required: true, message: '请输入金额系数' }],
              initialValue: currentItem.money,
            })(<Input placeholder="请输入金额系数" />)}
          </FormItem>
          <FormItem label="拣配系数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('pickMatch', {
              rules: [{ required: true, message: '请输入拣配系数' }],
              initialValue: currentItem.pickMatch,
            })(<Input placeholder="请输入拣配系数" />)}
          </FormItem>
          <FormItem label="复核系数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('review', {
              rules: [{ required: true, message: '请输入复核系数' }],
              initialValue: currentItem.review,
            })(<Input placeholder="请输入复核系数" />)}
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="配送计件统计"
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
              onChange={this.handleTableChange}
              size="small"
            />
          </Card>
        </div>
        <Modal
          title={done ? null : `${currentItem.id ? '编辑' : '添加'}`}
          className={styles.standardListForm}
          width={640}
          bodyStyle={done ? { padding: '72px 0' } : { padding: '28px 0 0' }}
          destroyOnClose
          loading={loading}
          visible={visible}
          {...modalFooter}
        >
          {getModalContent()}
        </Modal>
      </PageHeaderWrapper>
    );
  }
}

export default DispatchStatistics;
