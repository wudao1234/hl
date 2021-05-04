import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import accounting from 'accounting';
import moment from 'moment';
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
  DatePicker,
  InputNumber,
  Tag,
  Radio,
  Select,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import Highlighter from 'react-highlight-words';
import styles from '../Common.less';

const FormItem = Form.Item;
const { Search } = Input;
const RadioGroup = Radio.Group;
const { Option } = Select;

@connect(({ logisticsTemplate, addressArea, loading }) => ({
  list: logisticsTemplate.list.content,
  total: logisticsTemplate.list.totalElements,
  addressAreaList: addressArea.allList,
  loading: loading.models.logisticsTemplate,
}))
@Form.create()
class LogisticsTemplate extends PureComponent {
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
      type: 'addressArea/fetchAll',
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
      type: 'logisticsTemplate/fetch',
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
    const currentItem = Object.assign({}, item);
    currentItem.firstPrice /= 100;
    currentItem.renewPrice /= 100;
    currentItem.protectPrice /= 100;
    this.setState({
      visible: true,
      currentItem,
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
      const data = Object.assign({}, fieldsValue);
      data.firstPrice *= 100;
      data.renewPrice *= 100;
      data.protectPrice *= 100;
      data.dateTime = new Date(moment(data.dateTime).format('YYYY-MM-DD 00:00:00'));
      dispatch({
        type: 'logisticsTemplate/submit',
        payload: { id, ...data },
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
      type: 'logisticsTemplate/submit',
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

  handleAddressAreaFilters = () => {
    const { addressAreaList } = this.props;
    const addressAreaFilters = [];
    if (addressAreaList !== null && addressAreaList !== undefined) {
      addressAreaList.map(item => {
        return addressAreaFilters.push({ text: item.name, value: item.id });
      });
    }
    return addressAreaFilters;
  };

  render() {
    const { search } = this.state;
    const { list, total, addressAreaList, loading } = this.props;
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

    const getCurentAddressArea = item => {
      if (item !== undefined && item !== null && item.addressArea) {
        return item.addressArea.id;
      }
      return undefined;
    };

    const getAddressAreasOptions = allAddressAreas => {
      const children = [];
      if (Array.isArray(allAddressAreas)) {
        allAddressAreas.forEach(item => {
          children.push(
            <Option key={item.id} value={item.id}>
              {item.name}
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
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入渠道' }],
              initialValue: currentItem.name,
            })(<Input placeholder="请输入渠道" />)}
          </FormItem>
          <FormItem label="计量方式" {...this.formLayout} hasFeedback>
            {getFieldDecorator('type', {
              rules: [{ required: true, message: '请选择按件/按重' }],
              initialValue: currentItem.type,
            })(
              <RadioGroup>
                <Radio value={0}>按件</Radio>
                <Radio value={1}>按重</Radio>
                <Radio value={2}>按体积</Radio>
              </RadioGroup>
            )}
          </FormItem>
          <FormItem label="地区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('addressArea', {
              rules: [{ required: true, message: '请选择地区' }],
              initialValue: getCurentAddressArea(currentItem),
            })(
              <Select
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="请选择地区"
                style={{ width: '100%' }}
              >
                {getAddressAreasOptions(addressAreaList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="生效日期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('dateTime', {
              rules: [{ required: true, message: '请选择生效日期' }],
              initialValue: currentItem.dateTime ? moment(new Date(currentItem.dateTime)) : null,
            })(<DatePicker />)}
          </FormItem>
          <FormItem label="首重/首件" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`first`, {
              rules: [{ required: true, message: '请输入首重/首件（千克、件）' }],
              initialValue: currentItem.first,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0.01}
                max={99999999}
                step={1}
                precision={2}
                placeholder="请输入首重/首件（千克、件）"
              />
            )}
          </FormItem>
          <FormItem label="首重/首件单价" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`firstPrice`, {
              rules: [{ required: true, message: '请输入首重/首件单价(元)' }],
              initialValue: currentItem.firstPrice,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0.01}
                max={99999999}
                step={0.01}
                precision={2}
                placeholder="请输入首重/首件单价(元)"
              />
            )}
          </FormItem>
          <FormItem label="保费" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`protectPrice`, {
              rules: [{ required: false, message: '请输入保费(元)' }],
              initialValue: currentItem.protectPrice,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0.01}
                max={99999999}
                step={0.01}
                precision={2}
                placeholder="请输入保费(元)"
              />
            )}
          </FormItem>
          <FormItem label="续重/续件" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`renew`, {
              rules: [{ required: true, message: '请输入续重/续件（千克、件）' }],
              initialValue: currentItem.renew,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0.01}
                max={99999999}
                step={1}
                precision={2}
                placeholder="请输入续重/续件（千克、件）"
              />
            )}
          </FormItem>
          <FormItem label="续重/续件单价" {...this.formLayout} hasFeedback>
            {getFieldDecorator(`renewPrice`, {
              rules: [{ required: true, message: '请输入续重/续件单价(元)' }],
              initialValue: currentItem.renewPrice,
            })(
              <InputNumber
                className={styles.myAntInputNumber}
                min={0}
                max={99999999}
                step={0.01}
                precision={2}
                placeholder="请输入续重/续件单价(元)"
              />
            )}
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
        title: '地区',
        dataIndex: 'addressArea.name',
        key: 'addressArea.name',
        width: '5%',
        align: 'center',
        sorter: true,
        filters: this.handleAddressAreaFilters(),
      },
      {
        title: '按件/按重',
        dataIndex: 'type',
        key: 'type',
        width: '5%',
        render: text => {
          switch (text) {
            case 0:
              return <Tag>按重</Tag>;
            case 1:
              return <Tag>按件</Tag>;
            default:
              return <Tag>按体积</Tag>;
          }
        },
      },
      {
        title: '首重/首件/首体积',
        dataIndex: 'first',
        key: 'first',
        width: '10%',
      },
      {
        title: '续重/续件/续体积',
        dataIndex: 'renew',
        key: 'renew',
        width: '10%',
      },
      {
        title: '首重/首件/首体积单价',
        dataIndex: 'firstPrice',
        key: 'firstPrice',
        width: '10%',
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text / 100, '￥')}</Tag>;
        },
      },
      {
        title: '续重/续件/续体积单价',
        dataIndex: 'renewPrice',
        key: 'renewPrice',
        width: '10%',
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text / 100, '￥')}</Tag>;
        },
      },
      {
        title: '保费',
        dataIndex: 'protectPrice',
        key: 'protectPrice',
        width: '10%',
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text / 100, '￥')}</Tag>;
        },
      },
      {
        title: '提交时间',
        dataIndex: 'dateTime',
        key: 'dateTime',
        width: '10%',
        render: text => {
          return <Tag>{moment(text).format('YYYY-MM-DD')}</Tag>;
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

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="模板管理"
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
              创建新模板
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

export default LogisticsTemplate;
