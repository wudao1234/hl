import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import {
  Button,
  Card,
  Form,
  Input,
  message,
  Modal,
  notification,
  Popconfirm,
  Select,
  Table,
  Tag,
} from 'antd';

import moment from 'moment';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './Customer.less';

const FormItem = Form.Item;
const { Search } = Input;

@connect(({ customer, user, loading }) => ({
  list: customer.list.content,
  total: customer.list.totalElements,
  currentUser: user.currentUser,
  users: user.list,
  loading: loading.models.customer,
}))
@Form.create()
class Customer extends PureComponent {
  state = {
    currentPage: 1,
    pageSize: 10,
    orderBy: null,
    search: null,
    visible: false,
    done: false,
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
      title: '客户名称',
      dataIndex: 'name',
      key: 'name',
      width: '15%',
      sorter: true,
      render: (text, row) => {
        return (
          <a
            href="#"
            onClick={e => {
              e.preventDefault();
              this.showEditModal(row);
            }}
          >
            {text}
          </a>
        );
      },
    },
    {
      title: '英文简称',
      dataIndex: 'shortNameEn',
      key: 'shortNameEn',
      width: '5%',
    },
    {
      title: '中文简称',
      dataIndex: 'shortNameCn',
      key: 'shortNameCn',
      width: '5%',
    },
    {
      title: '产品数量',
      dataIndex: 'goodsCount',
      key: 'goodsCount',
      width: '5%',
      render: text => {
        return <Tag color="blue">{text}</Tag>;
      },
    },
    {
      title: '订单数量',
      dataIndex: 'ordersCount',
      key: 'ordersCount',
      width: '5%',
      render: text => {
        return <Tag color="red">{text}</Tag>;
      },
    },
    {
      title: '创建日期',
      dataIndex: 'createTime',
      key: 'createTime',
      width: '12%',
      sorter: true,
      render: text => {
        return moment(text).format('lll');
      },
    },
    {
      title: '操作',
      width: '10%',
      render: (text, row) => {
        return (
          <span className={styles.buttons}>
            <Button
              onClick={e => {
                e.preventDefault();
                this.showEditModal(row);
              }}
            >
              编辑
            </Button>
            <Popconfirm
              title="确定删除吗？"
              onConfirm={() => this.confirmDelete(row)}
              okText="删除"
              cancelText="取消"
            >
              <Button type="danger">删除</Button>
            </Popconfirm>
          </span>
        );
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy } = this.state;
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy);
    dispatch({
      type: 'user/fetch',
    });
  }

  handleSearchByUserName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, false, search, pageSize, 1, null);
  };

  handleQuery = (dispatch, exportExcel, search, pageSize, currentPage, orderBy) => {
    dispatch({
      type: 'customer/fetch',
      payload: { exportExcel, search, pageSize, currentPage, orderBy },
    });
  };

  showModal = () => {
    this.setState({
      visible: true,
      currentItem: undefined,
    });
  };

  showEditModal = item => {
    this.setState({
      visible: true,
      currentItem: item,
    });
  };

  handleDone = () => {
    setTimeout(() => this.addBtn.blur(), 0);
    this.setState({
      done: false,
      visible: false,
    });
  };

  handleCancel = () => {
    setTimeout(() => this.addBtn.blur(), 0);
    this.setState({
      visible: false,
    });
  };

  handleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;
    const { currentItem } = this.state;
    const id = currentItem ? currentItem.id : '';

    setTimeout(() => this.addBtn.blur(), 0);
    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleDone();
      dispatch({
        type: 'customer/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建成功！' : '修改成功！');
            const { search, pageSize, currentPage, orderBy } = this.state;
            this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy);
          }
        },
      });
    });
  };

  confirmDelete = item => {
    const { dispatch } = this.props;
    const { id } = item;
    this.setState({
      done: false,
      visible: false,
    });
    dispatch({
      type: 'customer/submit',
      payload: { id },
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('删除成功！');
          const { search, pageSize, currentPage, orderBy } = this.state;
          this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy);
        }
      },
    });
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const orderBy = field !== undefined ? `${field},${order}` : null;
    this.setState({
      currentPage,
      pageSize,
      orderBy,
    });
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy);
  };

  handleShowManagerSelection = currentUser => {
    if (currentUser !== null && currentUser !== undefined && currentUser.roles !== undefined) {
      if (
        currentUser.roles.includes('ADMIN') ||
        (currentUser.roles.includes('S_CUSTOMER_LIST') &&
          currentUser.roles.includes('S_CUSTOMER_CRUD'))
      ) {
        return false;
      }
    }
    return true;
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy } = this.state;
    this.handleQuery(dispatch, true, search, pageSize, currentPage, orderBy);
  };

  render() {
    const { list, users, currentUser, total, loading } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, currentItem = {} } = this.state;
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
          placeholder="客户名称,简称"
          onSearch={this.handleSearchByUserName}
        />
        <Button
          style={{ marginLeft: 10 }}
          htmlType="button"
          type="primary"
          icon="export"
          onClick={this.handleExportExcel}
        >
          导出Excel
        </Button>
      </div>
    );

    const getUserNames = currentUsers => {
      if (currentUsers instanceof Array) {
        return currentUsers.map(user => user.id);
      }
      return [];
    };

    const getUsersOptions = allUsers => {
      const { Option } = Select;
      const children = [];
      if (Array.isArray(allUsers)) {
        allUsers.map(user => {
          return children.push(
            <Option key={user.id} value={user.id}>
              {user.username}
            </Option>
          );
        });
        return children;
      }
      return null;
    };

    const getModalContent = () => {
      if (done) {
        message.success('保存成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="客户名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入客户名称' }],
              initialValue: currentItem.name,
            })(<Input placeholder="请输入客户名称" />)}
          </FormItem>
          <FormItem label="英文简称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('shortNameEn', {
              rules: [{ required: true, message: '请输入英文简称' }],
              initialValue: currentItem.shortNameEn,
            })(<Input placeholder="请输入英文简称" />)}
          </FormItem>
          <FormItem label="中文简称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('shortNameCn', {
              rules: [{ required: true, message: '请输入中文简称' }],
              initialValue: currentItem.shortNameCn,
            })(<Input placeholder="请输入中文简称" />)}
          </FormItem>
          <FormItem label="客户管理员" {...this.formLayout}>
            {getFieldDecorator('users', {
              initialValue: getUserNames(currentItem.users),
            })(
              <Select
                mode="multiple"
                style={{ width: '100%' }}
                placeholder="请选择客户管理员"
                disabled={this.handleShowManagerSelection(currentUser)}
              >
                {getUsersOptions(users)}
              </Select>
            )}
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="客户管理"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <Button
              type="dashed"
              style={{ width: '100%', marginBottom: 8 }}
              icon="plus"
              onClick={this.showModal}
              ref={component => {
                /* eslint-disable */
                this.addBtn = findDOMNode(component);
                /* eslint-enable */
              }}
            >
              创建新客户
            </Button>
            <Table
              columns={this.columns}
              dataSource={list}
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
              onChange={this.handleTableChange}
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

export default Customer;