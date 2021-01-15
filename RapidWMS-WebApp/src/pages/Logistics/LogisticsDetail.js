import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import accounting from 'accounting';
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
  Table,
  Select,
  InputNumber,
  Tag,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import Highlighter from 'react-highlight-words';
import styles from '../Common.less';

const PinyinMatch = require('pinyin-match');

const FormItem = Form.Item;
const { Search } = Input;
const { Option } = Select;

@connect(({ logisticsDetail, loading, address, customer, logisticsTemplate }) => ({
  list: logisticsDetail.list.content,
  total: logisticsDetail.list.totalElements,
  loading: loading.models.logisticsDetail,
  addressList: address.allList,
  customerList: customer.allList,
  logisticsTemplateList: logisticsTemplate.allList,
}))
@Form.create()
class LogisticsDetail extends PureComponent {
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
    dispatch({
      type: 'address/fetchAll',
    });
    dispatch({
      type: 'customer/fetchAll',
    });
    dispatch({
      type: 'logisticsTemplate/fetchGroupAll',
    });
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
      type: 'logisticsDetail/fetch',
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
      dispatch({
        type: 'logisticsDetail/submit',
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
      type: 'logisticsDetail/submit',
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
    const { addressList, customerList, logisticsTemplateList } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const {
      visible,
      done,
      currentItem = {
        logisticsTemplate: { id: undefined },
      },
    } = this.state;
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

    const getLogisticsTemplateOptions = () => {
      const children = [];
      if (Array.isArray(logisticsTemplateList)) {
        logisticsTemplateList.forEach(item => {
          children.push(
            <Option key={item.id} value={item.id}>
              {item.name}
            </Option>
          );
        });
      }
      return children;
    };
    const getCustomersOptions = () => {
      const children = [];
      if (Array.isArray(customerList)) {
        customerList.forEach(customer => {
          children.push(
            <Option key={customer.id} value={customer.name}>
              {customer.name}
            </Option>
          );
        });
      }
      return children;
    };

    const getAddressOptions = () => {
      const children = [];
      if (Array.isArray(addressList)) {
        addressList.forEach(addressItem => {
          children.push(
            <Option key={addressItem.id} value={addressItem.clientStore}>
              {addressItem.clientStore} /{addressItem.name}
            </Option>
          );
        });
      }
      return children;
    };

    const getModalContent = () => {
      if (done) {
        message.success('保存成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="渠道" {...this.formLayout} hasFeedback>
            {getFieldDecorator('logisticsTemplate.id', {
              rules: [{ required: true, message: '请选择渠道' }],
              initialValue: currentItem.logisticsTemplate.id,
            })(
              <Select
                showSearch
                allowClear
                filterOption={(input, option) =>
                  PinyinMatch.match(option.props.children.toString(), input)
                }
                placeholder="请选择渠道"
              >
                {getLogisticsTemplateOptions()}
              </Select>
            )}
          </FormItem>
          <FormItem label="选择客户" {...this.formLayout} hasFeedback>
            {getFieldDecorator('customer', {
              rules: [{ required: true, message: '请选择所属客户' }],
              initialValue: currentItem.customer,
            })(
              <Select
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="请选择所属客户"
              >
                {getCustomersOptions()}
              </Select>
            )}
          </FormItem>
          <FormItem label="门店地址" {...this.formLayout} hasFeedback>
            {getFieldDecorator('address', {
              rules: [{ required: true, message: '请选择门店地址' }],
              initialValue: currentItem.address,
            })(
              <Select
                showSearch
                allowClear
                filterOption={(input, option) =>
                  PinyinMatch.match(option.props.children.toString(), input)
                }
                placeholder="请选择门店地址"
              >
                {getAddressOptions()}
              </Select>
            )}
          </FormItem>
          <FormItem label="省" {...this.formLayout} hasFeedback>
            {getFieldDecorator('province', {
              rules: [{ required: true, message: '请输入省' }],
              initialValue: currentItem.province,
            })(<Input placeholder="请输入省" />)}
          </FormItem>
          <FormItem label="单据" {...this.formLayout} hasFeedback>
            {getFieldDecorator('bill', {
              rules: [{ required: true, message: '请输入单据' }],
              initialValue: currentItem.bill,
            })(<Input placeholder="请输入单据" />)}
          </FormItem>
          <FormItem label="件数" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`piece`, {
              rules: [{ required: true, message: '请输入件数' }],
              initialValue: currentItem.piece,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0}
                max={99999999}
                step={1}
                precision={0}
                placeholder="请输入件数"
              />
            )}
          </FormItem>
          <FormItem label="实际重量（克）" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`realityWeight`, {
              rules: [{ required: true, message: '请输入实际重量（克）' }],
              initialValue: currentItem.realityWeight,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0}
                max={99999999}
                step={1}
                precision={0}
                placeholder="请输入实际重量（克）"
              />
            )}
          </FormItem>
          <FormItem label="计算重量（克）" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`computeWeight`, {
              rules: [{ required: true, message: '请输入计算重量（克）' }],
              initialValue: currentItem.computeWeight,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0}
                max={99999999}
                step={1}
                precision={0}
                placeholder="请输入计算重量（克）"
              />
            )}
          </FormItem>
          <FormItem label="备注" {...this.formLayout} hasFeedback>
            {getFieldDecorator('remark', {
              rules: [{ required: true, message: '请输入备注' }],
              initialValue: currentItem.remark,
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
        title: '渠道',
        dataIndex: 'name',
        key: 'name',
        width: '5%',
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
        title: '省',
        dataIndex: 'province',
        key: 'province',
        width: '2%',
      },
      {
        title: '客户',
        dataIndex: 'customer',
        key: 'customer',
        width: '5%',
      },
      {
        title: '门店地址',
        dataIndex: 'address',
        key: 'address',
        width: '5%',
      },
      {
        title: '单据',
        dataIndex: 'bill',
        key: 'bill',
        width: '5%',
      },
      {
        title: '件数',
        dataIndex: 'piece',
        key: 'piece',
        width: '2%',
      },
      {
        title: '实际重量（克）',
        dataIndex: 'realityWeight',
        key: 'realityWeight',
        width: '5%',
      },
      {
        title: '计算重量（克）',
        dataIndex: 'computeWeight',
        key: 'computeWeight',
        width: '5%',
      },
      {
        title: '续重/续件数量',
        dataIndex: 'renewNum',
        key: 'renewNum',
        width: '5%',
      },
      {
        title: '总价',
        dataIndex: 'totalPrice',
        key: 'totalPrice',
        width: '5%',
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text / 100, '￥')}</Tag>;
        },
      },
      {
        title: '备注',
        dataIndex: 'remark',
        key: 'remark',
        width: '10%',
      },
      {
        title: '操作',
        width: '8%',
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
            title="物流结算管理"
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
              创建新物流结算信息
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

export default LogisticsDetail;
