import React, { PureComponent } from 'react';
import router from 'umi/router';
import {
  Button,
  Card,
  Col,
  Form,
  Icon,
  Input,
  InputNumber,
  message,
  notification,
  Popconfirm,
  Popover,
  Row,
  Select,
  Steps,
  Table,
  Tag,
} from 'antd';
import Highlighter from 'react-highlight-words';
import accounting from 'accounting';
import moment from 'moment';
import { connect } from 'dva';
import styles from './Pack.less';

const FormItem = Form.Item;
const { Option } = Select;
const { Search } = Input;
const { Step } = Steps;

const PinyinMatch = require('pinyin-match');

@connect(({ order, customer, address, loading }) => ({
  orderList: order.list.content,
  orderTotal: order.list.totalElements,
  customerList: customer.allList,
  addressList: address.allList,
  loadingOrders: loading.models.order,
}))
@Form.create()
class PackForm extends PureComponent {
  state = {
    search: null,
    orderCurrentPage: 1,
    orderPageSize: 10,
    packId: null,
    customerFilter: null,
    packDescription: null,
    packType: null,
    packages: null,
    trackingNumber: null,
    address: null,
    packStatus: null,
    allItems: [],
  };

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'customer/fetchAll',
    });
    dispatch({
      type: 'address/fetchAll',
    });
    dispatch({
      type: 'order/fetchNone',
    });
  }

  componentWillReceiveProps(nextProps) {
    const { orderList } = this.props;
    if (orderList !== undefined && orderList !== null) {
      if (orderList.length === 1) {
        const row = orderList[0];
        const { allItems } = this.state;
        if (!allItems.some(item => item.id === row.id)) {
          this.setState({
            allItems: [...allItems, row],
          });
          message.success(`添加${row.flowSn}成功`);
        }
      }
    }

    const { pack, loading } = nextProps;
    if (pack !== null && pack !== undefined && loading) {
      let result;
      switch (pack.packType) {
        case 'SENDING':
          result = 0;
          break;
        case 'TRANSFER':
          result = 1;
          break;
        case 'SELF_PICKUP':
          result = 2;
          break;
        default:
          result = null;
          break;
      }
      this.setState({
        packId: pack.id,
        customerFilter: pack.customer.id,
        packDescription: pack.description,
        packType: result,
        packages: pack.packages,
        trackingNumber: pack.trackingNumber,
        address: pack.address,
        packStatus: pack.packStatus,
        allItems: pack.orders,
      });
    }
  }

  render() {
    const {
      dispatch,
      form,
      form: { getFieldDecorator },
      orderList,
      orderTotal,
      customerList,
      addressList,
      loadingOrders,
      isEdit,
      loading,
      queryParams,
    } = this.props;

    const { orderPageSize, orderCurrentPage, search } = this.state;

    const {
      packId,
      customerFilter,
      packDescription,
      packType,
      packages,
      trackingNumber,
      address,
      packStatus,
      allItems,
    } = this.state;

    const handleSelectCustomer = value => {
      if (!isEdit) {
        this.setState({
          customerFilter: value,
          allItems: [],
        });
        dispatch({
          type: 'order/fetchNone',
        });
      }
    };

    const getCustomersOptions = allCustomers => {
      const children = [];
      if (Array.isArray(allCustomers)) {
        allCustomers.forEach(customer => {
          children.push(
            <Option key={customer.id} value={customer.id}>
              {customer.name}
            </Option>
          );
        });
      }
      return children;
    };

    const handleAddOrder = row => {
      if (allItems.some(item => item.id === row.id)) {
        message.warning(`${row.flowSn}订单已经添加过了`);
      } else {
        this.setState({
          allItems: [...allItems, row],
        });
        message.success(`添加${row.flowSn}成功`);
      }
    };

    const handleRemoveOrder = id => {
      this.setState({
        allItems: allItems.filter(item => item.id !== id),
      });
    };

    const columns = [
      {
        title: '#',
        width: '1%',
        key: 'index',
        render: (text, record, index) => {
          return `${index + 1 + (orderCurrentPage - 1) * orderPageSize}`;
        },
      },
      {
        title: '出货',
        dataIndex: 'isSatisfied',
        key: 'isSatisfied',
        width: '1%',
        align: 'center',
        render: text => {
          switch (text) {
            case true:
              return <Tag color="blue">全匹配</Tag>;
            case false:
              return <Tag color="orange">部分匹配</Tag>;
            default:
              return <Tag color="#A9A9A9">未匹配</Tag>;
          }
        },
      },
      {
        title: '流程',
        dataIndex: 'orderStatus',
        key: 'orderStatus',
        width: '1%',
        align: 'center',
        render: text => {
          let result;
          let color;
          switch (text) {
            case 'INIT':
              result = '生成订单';
              color = '#DC143C';
              break;
            case 'FETCH_STOCK':
              result = '匹配出库';
              color = '#C71585';
              break;
            case 'GATHERING_GOODS':
              result = '正在分拣';
              color = '#F7D358';
              break;
            case 'GATHER_GOODS':
              result = '分拣完成';
              color = '#2F4F4F';
              break;
            case 'CONFIRM':
              result = '复核分拣';
              color = '#808000';
              break;
            case 'PACKAGE':
              result = '整理打包';
              color = '#8A2BE2';
              break;
            case 'SENDING':
              result = '物流派送';
              color = '#191970';
              break;
            case 'CLIENT_SIGNED':
              result = '签收确认';
              color = '#FF8C00';
              break;
            case 'COMPLETE':
              result = '回执完成';
              color = '#00BFFF';
              break;
            case 'CANCEL':
              result = '订单作废';
              color = '#2E8B57';
              break;
            default:
              result = '未知';
              color = '#696969';
              break;
          }
          return <Tag color={color}>{result}</Tag>;
        },
      },
      {
        title: '所属客户',
        dataIndex: 'owner.name',
        key: 'owner.name',
        width: '15%',
      },
      {
        title: '订单客户',
        dataIndex: 'clientName',
        key: 'clientName',
        width: '15%',
        render: (text, record) => {
          const tooltip = (
            <div>
              <p>
                <b>客户名称</b>: {record.clientName}
              </p>
              <p>
                <b>客户地址</b>: {record.clientAddress}
              </p>
              <p>
                <b>客户门店</b>: {record.clientStore}
              </p>
            </div>
          );
          return (
            <span>
              <Popover content={tooltip} title={text}>
                <a style={{ marginRight: 3 }}>
                  <Icon type="exclamation-circle" />
                </a>
              </Popover>
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text !== null && text !== undefined ? text.toString() : ''}
              />
            </span>
          );
        },
      },
      {
        title: '客户订单号',
        dataIndex: 'clientOrderSn',
        key: 'clientOrderSn',
        width: '10%',
        render: text => {
          if (text) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text === undefined ? '' : text.toString()}
              />
            );
          }
          return '';
        },
      },
      {
        title: '说明',
        dataIndex: 'description',
        key: 'description',
        width: '20%',
        render: text => {
          if (text) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[search]}
                autoEscape
                textToHighlight={text === undefined ? '' : text.toString()}
              />
            );
          }
          return '';
        },
      },
      {
        title: '金额',
        dataIndex: 'totalPrice',
        key: 'totalPrice',
        width: '1%',
        align: 'right',
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text, '￥')}</Tag>;
        },
      },
      {
        title: '提交时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: '1%',
        render: text => {
          return <Tag>{moment(text).format('YY/MM/DD/HH:mm')}</Tag>;
        },
      },
      {
        title: '流水号',
        dataIndex: 'flowSn',
        key: 'flowSn',
        width: '1%',
        render: text => {
          return (
            <Highlighter
              highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
              searchWords={[search]}
              autoEscape
              textToHighlight={text !== null && text !== undefined ? text.toString() : ''}
            />
          );
        },
      },
      {
        title: '自编号',
        dataIndex: 'autoIncreaseSn',
        key: 'autoIncreaseSn',
        width: '1%',
        render: text => {
          return (
            <Highlighter
              highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
              searchWords={[search]}
              autoEscape
              textToHighlight={text !== null && text !== undefined ? text.toString() : ''}
            />
          );
        },
      },
    ];

    const orderColumns = [
      ...columns,
      {
        title: '操作',
        width: '1%',
        align: 'right',
        render: (text, row) => {
          return (
            <Button
              htmlType="button"
              size="small"
              type="primary"
              onClick={e => {
                e.preventDefault();
                handleAddOrder(row);
              }}
            >
              添加
            </Button>
          );
        },
      },
    ];

    const selectOrderColumns = [
      ...columns,
      {
        title: '操作',
        width: '6%',
        align: 'right',
        render: record => {
          return (
            <span>
              <Popconfirm
                title="确定删除吗？"
                onConfirm={() => handleRemoveOrder(record.id)}
                okText="删除"
                cancelText="取消"
              >
                <Button htmlType="button" type="danger" size="small">
                  删除
                </Button>
              </Popconfirm>
            </span>
          );
        },
      },
    ];

    const handleOrderQuery = (newSearch, newOrderCurrentPage) => {
      dispatch({
        type: 'order/fetchForPack',
        payload: {
          search: newSearch,
          pageSize: orderPageSize,
          currentPage: newOrderCurrentPage,
          orderBy: null,
          customerFilter,
        },
      });
    };

    const handleSearch = value => {
      if (customerFilter === null || customerFilter === undefined) {
        message.warning('请首先选择客户，再进行此操作！');
        return;
      }
      this.setState({
        search: value,
        orderCurrentPage: 1,
      });
      handleOrderQuery(value, orderCurrentPage);
    };

    const searchContent = (
      <div className={styles.extraContent}>
        <Search
          className={styles.extraContentSearch}
          placeholder="订单流水，自编号等订单信息"
          onSearch={handleSearch}
        />
      </div>
    );

    const handleGoBackToList = () => {
      router.push({
        pathname: '/transit/pack',
        query: {
          queryParams,
        },
      });
    };

    const handleSubmit = e => {
      e.preventDefault();
      form.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        dispatch({
          type: 'pack/submit',
          payload: { ...fieldsValue, isEdit, orders: allItems },
          callback: response => {
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              message.success(isEdit ? '修改成功！' : '创建成功！');
              handleGoBackToList();
            }
          },
        });
      });
    };

    const handleTotal = (total, range) => {
      return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
    };

    const handleOrderTableChange = pagination => {
      const { current: newOrderCurrentPage } = pagination;
      this.setState({
        orderCurrentPage: newOrderCurrentPage,
      });
      handleOrderQuery(search, newOrderCurrentPage);
    };

    const handlePackTypeChange = value => {
      this.setState({
        packType: value,
      });
      if (value === 2) {
        form.setFieldsValue({
          address: null,
        });
      }
    };

    const orderPaginationProps = {
      showTotal: handleTotal,
      current: orderCurrentPage,
      total: orderTotal,
      pageSize: orderPageSize,
    };

    const getPackTypeOptions = () => {
      const receiveGoodsTypeArray = [
        { id: 0, name: '市区派送' },
        { id: 1, name: '外发物流' },
        { id: 2, name: '自行提取' },
      ];
      const children = [];
      if (Array.isArray(receiveGoodsTypeArray)) {
        receiveGoodsTypeArray.forEach(type => {
          children.push(
            <Option key={type.id} value={type.id}>
              {type.name}
            </Option>
          );
        });
      }
      return children;
    };

    const getAddressOptions = allAddress => {
      const children = [];
      if (Array.isArray(allAddress)) {
        allAddress.forEach(addressItem => {
          children.push(
            <Option key={addressItem.id} value={addressItem.id}>
              {addressItem.name} / {addressItem.addressType.name} / {addressItem.contact} /{' '}
              {addressItem.phone}
            </Option>
          );
        });
      }
      return children;
    };

    const getPackStatusValue = status => {
      switch (status) {
        case 'PACKAGE':
          return 0;
        case 'SENDING':
          return 1;
        case 'CLIENT_SIGNED':
          return 2;
        case 'COMPLETE':
          return 3;
        default:
          return 0;
      }
    };

    return (
      <div className={styles.standardList}>
        <Card
          bordered
          title={isEdit ? '编辑订单信息' : '新增订单'}
          style={{ marginTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
        >
          <Row gutter={16}>
            <Col>
              <Steps
                size="small"
                labelPlacement="vertical"
                style={{ float: 'right' }}
                current={getPackStatusValue(packStatus)}
              >
                <Step title="整理打包" />
                <Step title="物流派送" />
                <Step title="签收确认" />
                <Step title="回执完成" />
              </Steps>
            </Col>
          </Row>
          <Form onSubmit={handleSubmit}>
            <Row gutter={16}>
              <Col span={5}>
                <FormItem label="选择客户" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('customer', {
                    rules: [{ required: true, message: '请选择所属客户' }],
                    initialValue: customerFilter,
                  })(
                    <Select
                      disabled={isEdit}
                      showSearch
                      filterOption={(input, option) =>
                        option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                      }
                      placeholder="请选择所属客户"
                      onChange={handleSelectCustomer}
                    >
                      {getCustomersOptions(customerList)}
                    </Select>
                  )}
                </FormItem>
              </Col>
              <Col span={3}>
                <FormItem label="打包类型" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('packType', {
                    rules: [{ required: true, message: '请选择打包类型' }],
                    initialValue: packType,
                  })(
                    <Select
                      showSearch
                      filterOption={(input, option) =>
                        option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                      }
                      placeholder="请选择打包类型"
                      onChange={handlePackTypeChange}
                    >
                      {getPackTypeOptions()}
                    </Select>
                  )}
                </FormItem>
              </Col>
              <Col span={3}>
                <FormItem label="打包数量" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('packages', {
                    rules: [{ required: true, message: '请打包数量' }],
                    initialValue: packages,
                  })(<InputNumber min={1} />)}
                </FormItem>
              </Col>
              <Col span={3}>
                <FormItem label="物流单号" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('trackingNumber', {
                    initialValue: trackingNumber,
                  })(<Input />)}
                </FormItem>
              </Col>
              <Col span={10}>
                <FormItem label="备注" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('description', {
                    initialValue: packDescription,
                  })(<Input />)}
                </FormItem>
              </Col>
            </Row>
            <Row gutter={16}>
              <Col span={11}>
                <FormItem label="选择送货地址" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('address', {
                    rules: [{ required: packType !== 2, message: '请选择送货地址' }],
                    initialValue: address !== undefined && address !== null ? address.id : null,
                  })(
                    <Select
                      disabled={packType === 2}
                      showSearch
                      allowClear
                      filterOption={(input, option) =>
                        PinyinMatch.match(option.props.children.toString(), input)
                      }
                    >
                      {getAddressOptions(addressList)}
                    </Select>
                  )}
                </FormItem>
              </Col>
            </Row>
            <Table
              columns={selectOrderColumns}
              dataSource={allItems}
              pagination={false}
              size="middle"
              rowKey="id"
              loading={loading}
            />
            <Row>
              <Col span={12} offset={6}>
                <Button
                  htmlType="submit"
                  type="primary"
                  size="large"
                  style={{ width: '70%', marginTop: 24 }}
                  onClick={handleSubmit}
                >
                  保存
                </Button>
                <Button
                  htmlType="button"
                  size="large"
                  style={{ width: '20%', marginTop: 24, marginLeft: 24 }}
                  onClick={handleGoBackToList}
                >
                  返回列表
                </Button>
              </Col>
            </Row>
            <FormItem>
              {getFieldDecorator('packId', {
                initialValue: packId,
              })(<Input hidden />)}
            </FormItem>
          </Form>
        </Card>
        <Card
          bordered={false}
          style={{ marginTop: 12, paddingTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
          extra={searchContent}
        >
          <Table
            columns={orderColumns}
            dataSource={orderList}
            rowKey="id"
            loading={loadingOrders}
            pagination={orderPaginationProps}
            onChange={handleOrderTableChange}
            size="small"
          />
        </Card>
      </div>
    );
  }
}

export default PackForm;