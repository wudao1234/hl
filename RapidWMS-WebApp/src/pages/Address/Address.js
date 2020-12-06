import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import {
  Button,
  Card,
  Form,
  Icon,
  Input,
  message,
  Modal,
  notification,
  Popconfirm,
  Select,
  Table,
} from 'antd';

import Highlighter from 'react-highlight-words';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './Address.less';

const FormItem = Form.Item;
const { Search } = Input;
const { TextArea } = Input;
const { Option } = Select;

@connect(({ address, addressType, loading }) => ({
  list: address.list.content,
  total: address.list.totalElements,
  addressTypeList: addressType.allList,
  loading: loading.models.address,
}))
@Form.create()
class Address extends PureComponent {
  state = {
    currentPage: 1,
    pageSize: 10,
    orderBy: null,
    search: null,
    addressTypeFilter: null,
    visible: false,
    done: false,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, addressTypeFilter } = this.state;
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy, addressTypeFilter);
    dispatch({
      type: 'addressType/fetchAll',
    });
  }

  handleAddressTypeFilters = () => {
    const { addressTypeList } = this.props;
    const addressTypeFilters = [];
    if (addressTypeList !== null && addressTypeList !== undefined) {
      addressTypeList.map(addressType => {
        return addressTypeFilters.push({ text: addressType.name, value: addressType.id });
      });
    }
    return addressTypeFilters;
  };

  handleSearch = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, addressTypeFilter } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, false, search, pageSize, 1, null, addressTypeFilter);
  };

  handleQuery = (
    dispatch,
    exportExcel,
    search,
    pageSize,
    currentPage,
    orderBy,
    addressTypeFilter
  ) => {
    dispatch({
      type: 'address/fetch',
      payload: { exportExcel, search, pageSize, currentPage, orderBy, addressTypeFilter },
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
        type: 'address/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建成功！' : '修改成功！');
            const { search, pageSize, currentPage, orderBy, addressTypeFilter } = this.state;
            this.handleQuery(
              dispatch,
              false,
              search,
              pageSize,
              currentPage,
              orderBy,
              addressTypeFilter
            );
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
      type: 'address/submit',
      payload: { id },
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('删除成功！');
          const { search, pageSize, currentPage, orderBy, addressTypeFilter } = this.state;
          this.handleQuery(
            dispatch,
            false,
            search,
            pageSize,
            currentPage,
            orderBy,
            addressTypeFilter
          );
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
    const { 'addressType.name': addressTypeFilter = null } = filters;
    this.setState({
      currentPage,
      pageSize,
      orderBy,
      addressTypeFilter,
    });
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy, addressTypeFilter);
  };

  handleAddressList = list => {
    if (!list) {
      return null;
    }
    return list.map(item => {
      return { ...item, customerName: item.customer ? item.customer.name : null };
    });
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, addressTypeFilter } = this.state;
    this.handleQuery(dispatch, true, search, pageSize, currentPage, orderBy, addressTypeFilter);
  };

  render() {
    const { list, total, loading, addressTypeList } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, currentItem = {} } = this.state;
    const { pageSize, currentPage, search } = this.state;

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
          placeholder="请输入地址或联系人进行搜索"
          onSearch={this.handleSearch}
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

    const getCurentAddressType = item => {
      if (item !== undefined && item !== null && item.addressType) {
        return item.addressType.id;
      }
      return undefined;
    };

    const getAddressTypesOptions = allAddressTypes => {
      const children = [];
      if (Array.isArray(allAddressTypes)) {
        allAddressTypes.forEach(addressType => {
          children.push(
            <Option key={addressType.id} value={addressType.id}>
              {addressType.name}
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
          <FormItem label="门店" {...this.formLayout} hasFeedback>
            {getFieldDecorator('clientStore', {
              rules: [{ required: true, message: '请输入门店' }],
              initialValue: currentItem.naclientStoreme,
            })(<Input placeholder="XX重庆江北店" />)}
          </FormItem>
          <FormItem label="地址" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入地址' }],
              initialValue: currentItem.name,
            })(<Input placeholder="请输入地址名称" />)}
          </FormItem>
          <FormItem label="地址类别" {...this.formLayout} hasFeedback>
            {getFieldDecorator('addressType', {
              rules: [{ required: true, message: '请选择地址类别' }],
              initialValue: getCurentAddressType(currentItem),
            })(
              <Select
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="请选择类别"
                style={{ width: '100%' }}
              >
                {getAddressTypesOptions(addressTypeList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="联系人" {...this.formLayout} hasFeedback>
            {getFieldDecorator('contact', {
              rules: [{ required: true, message: '请输入联系人' }],
              initialValue: currentItem.contact,
            })(<Input placeholder="请输入联系人" />)}
          </FormItem>
          <FormItem label="联系电话" {...this.formLayout} hasFeedback>
            {getFieldDecorator('phone', {
              rules: [{ required: true, message: '请输入联系电话' }],
              initialValue: currentItem.phone,
            })(<Input placeholder="请输入联系电话" />)}
          </FormItem>
          <FormItem label="系数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('coefficient', {
              rules: [{ required: true, message: '请输入系数' }],
              initialValue: currentItem.coefficient,
            })(<Input placeholder="请输入系数" />)}
          </FormItem>
          <FormItem label="备注" {...this.formLayout} hasFeedback>
            {getFieldDecorator('description', {
              initialValue: currentItem.description,
            })(<TextArea rows={4} placeholder="请输入备注" />)}
          </FormItem>
        </Form>
      );
    };

    const columns = [
      {
        title: '#',
        width: '1%',
        key: 'index',
        render: (text, record, index) => {
          return `${index + 1 + (currentPage - 1) * pageSize}`;
        },
      },
      {
        title: '门店',
        dataIndex: 'clientStore',
        key: 'clientStore',
        width: '15%',
      },
      {
        title: '地址',
        dataIndex: 'name',
        key: 'name',
        width: '15%',
        sorter: true,
        render: (text, record) => {
          return (
            <span>
              <a
                onClick={e => {
                  e.preventDefault();
                  this.showEditModal(record);
                }}
                style={{ marginRight: 3 }}
              >
                <Icon type="exclamation-circle" />
              </a>
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            </span>
          );
        },
      },
      {
        title: '类别',
        dataIndex: 'addressType.name',
        key: 'addressType.name',
        width: '5%',
        align: 'center',
        sorter: true,
        filters: this.handleAddressTypeFilters(),
      },
      {
        title: '联系人',
        dataIndex: 'contact',
        key: 'contact',
        width: '8%',
        sorter: true,
        render: text => {
          if (text !== undefined && text !== null) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            );
          }
          return text;
        },
      },
      {
        title: '联系电话',
        dataIndex: 'phone',
        key: 'phone',
        width: '8%',
        sorter: true,
        render: text => {
          if (text !== undefined && text !== null) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            );
          }
          return text;
        },
      },
      {
        title: '系数',
        dataIndex: 'coefficient',
        key: 'coefficient',
        width: '8%',
        sorter: true,
        render: text => {
          if (text !== undefined && text !== null) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            );
          }
          return text;
        },
      },
      {
        title: '备注',
        dataIndex: 'description',
        key: 'description',
        width: '10%',
        sorter: true,
        render: text => {
          if (text !== undefined && text !== null) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text.toString()}
              />
            );
          }
          return text;
        },
      },
      {
        title: '操作',
        width: '8%',
        align: 'right',
        render: (text, row) => {
          return (
            <span className={styles.buttons}>
              <Button
                size="small"
                htmlType="button"
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
                <Button size="small" htmlType="button" href="#" type="danger">
                  删除
                </Button>
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
            title="地址管理"
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
              创建新地址
            </Button>
            <Table
              columns={columns}
              dataSource={this.handleAddressList(list)}
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
              onChange={this.handleTableChange}
              size="small"
              onRow={record => {
                return {
                  onDoubleClick: () => {
                    this.showEditModal(record);
                  },
                };
              }}
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

export default Address;
