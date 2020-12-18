import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import { Button, Card, Form, Input, message, Modal, notification, Popconfirm, Table } from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import Highlighter from 'react-highlight-words';
import styles from '@/pages/Common/Common.less';

const FormItem = Form.Item;
const { Search } = Input;
const basePath = 'carBasic';

@connect(({ carBasic, loading }) => ({
  list: carBasic.list.content,
  total: carBasic.list.totalElements,
  loading: loading.models.carBasic,
}))
@Form.create()
class CarBasic extends PureComponent {
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

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy } = this.state;
    this.handleQuery(dispatch, search, pageSize, currentPage, orderBy);
  }

  handleSearchChange = e => {
    this.setState({
      search: e.target.value,
    });
  };

  handleSearchByName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, search, pageSize, 1, null);
  };

  handleQuery = (dispatch, search, pageSize, currentPage, orderBy) => {
    dispatch({
      type: `${basePath}/fetch`,
      payload: { search, pageSize, currentPage, orderBy },
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
      console.log(fieldsValue);
      dispatch({
        type: `${basePath}/submit`,
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
            this.handleQuery(dispatch, search, pageSize, currentPage, orderBy);
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
      type: `${basePath}/submit`,
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
          this.handleQuery(dispatch, search, pageSize, currentPage, orderBy);
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
    this.handleQuery(dispatch, search, pageSize, currentPage, orderBy);
  };

  render() {
    const { search } = this.state;
    const { list, total, loading } = this.props;
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
          value={search}
          className={styles.extraContentSearch}
          placeholder="请输入名称进行搜索"
          onChange={this.handleSearchChange}
          onSearch={this.handleSearchByName}
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
          <FormItem label="驾驶员姓名" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carDriverName', {
              rules: [{ required: true, message: '请输入驾驶员姓名' }],
              initialValue: currentItem.carDriverName,
            })(<Input placeholder="请输入驾驶员姓名" />)}
          </FormItem>
          <FormItem label="车牌号" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carNum', {
              rules: [{ required: true, message: '请输入车牌号' }],
              initialValue: currentItem.carNum,
            })(<Input placeholder="请输入车牌号" />)}
          </FormItem>
          <FormItem label="车辆型号" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carModel', {
              rules: [{ required: true, message: '请输入车辆型号' }],
              initialValue: currentItem.carModel,
            })(<Input placeholder="请输入车辆型号" />)}
          </FormItem>
          <FormItem label="车辆类型" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carType', {
              rules: [{ required: true, message: '请输入车辆类型' }],
              initialValue: currentItem.carType,
            })(<Input placeholder="请输入车辆类型" />)}
          </FormItem>
          <FormItem label="车辆状态" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carStatus', {
              rules: [{ required: true, message: '请输入车辆状态' }],
              initialValue: currentItem.carStatus,
            })(<Input placeholder="请输入车辆状态" />)}
          </FormItem>
          <FormItem label="备注" {...this.formLayout} hasFeedback>
            {getFieldDecorator('carDesc', {
              rules: [{ required: true, message: '请输入备注' }],
              initialValue: currentItem.carDesc,
            })(<Input placeholder="请输入备注" />)}
          </FormItem>
        </Form>
      );
    };

    const columns = [
      {
        title: '#',
        width: '3%',
        key: 'index',
        render: (text, record, index) => `${index + 1}`,
      },
      {
        title: '驾驶员姓名',
        dataIndex: 'carDriverName',
        key: 'carDriverName',
        width: '15%',
        sorter: true,
        render: text => {
          if (text !== null && text !== undefined) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            );
          }
          return '';
        },
      },
      {
        title: '车牌号',
        dataIndex: 'carNum',
        key: 'carNum',
        width: '10%',
      },
      {
        title: '车辆型号',
        dataIndex: 'carModel',
        key: 'carModel',
        width: '10%',
      },
      {
        title: '车辆类型',
        dataIndex: 'carType',
        key: 'carType',
        width: '10%',
      },
      {
        title: '车辆状态',
        dataIndex: 'carStatus',
        key: 'carStatus',
        width: '10%',
      },
      {
        title: '备注',
        dataIndex: 'carDesc',
        key: 'carDesc',
        width: '10%',
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

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="车辆信息管理"
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
              创建
            </Button>
            <Table
              columns={columns}
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

export default CarBasic;
