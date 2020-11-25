import React, { PureComponent } from 'react';
import {
  Button,
  Card,
  Cascader,
  DatePicker,
  Form,
  Input,
  InputNumber,
  message,
  Popconfirm,
  Select,
  Steps,
  Table,
  Tag,
  Tooltip,
} from 'antd';
import Highlighter from 'react-highlight-words';
import accounting from 'accounting';
import moment from 'moment';
import { connect } from 'dva';
import styles from '../Order/Order.less';

const FormItem = Form.Item;
const { Option } = Select;
const { Search } = Input;
const intformat = require('biguint-format');

@connect(({ goods, stock, customer, wareZone, store, loading }) => ({
  goodsList: goods.list.content,
  goodsTotal: goods.list.totalElements,
  stockList: stock.list.content,
  stockTotal: stock.list.totalElements,
  customerList: customer.allList,
  wareZoneList: wareZone.allList,
  wareZoneTree: wareZone.tree,
  storeList: store.allList,
  loadingGoods: loading.models.goods,
  loadingStock: loading.models.stock,
}))
@Form.create()
class OrderForm extends PureComponent {
  state = {
    search: null,
    goodsCurrentPage: 1,
    goodsPageSize: 5,
    stockCurrentPage: 1,
    stockPageSize: 5,
    orderId: null,
    customerFilter: null,
    orderDescription: null,
    autoIncreaseSn: null,
    printTitle: null,
    clientName: null,
    clientStore: null,
    clientAddress: null,
    clientOrderSn: null,
    clientOrderSn2: null,
    clientOperator: null,
    useNewAutoIncreaseSn: false,
    usePackCount: false,
    targetWareZones: [],
    fetchAll: false,
    orderExpireDateMin: null,
    orderExpireDateMax: null,
    fetchStocks: true,
    orderStatus: null,
    allItems: [],
  };

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'customer/fetchMy',
    });
  }

  componentWillReceiveProps() {
    const { customerList } = this.props;
    if (customerList !== undefined && customerList !== null) {
      if (customerList.length === 1) {
        this.setState({
          customerFilter: customerList[0].id,
        });
      }
    }
  }

  render() {
    const { dispatch, loading, queryParams } = this.props;

    const { search } = this.state;

    const { customerFilter } = this.state;

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

    const stockColumns = [
      {
        title: '#',
        width: '1%',
        key: 'index',
        render: (text, record, index) => {
          return `${index + 1 + (stockCurrentPage - 1) * stockPageSize}`;
        },
      },
      {
        title: '商品名称',
        dataIndex: 'goods.name',
        key: 'stock.goods.name',
        render: text => {
          return (
            <Highlighter
              highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
              searchWords={[search]}
              autoEscape
              textToHighlight={text.toString()}
            />
          );
        },
      },
      {
        title: '库位',
        dataIndex: 'warePosition.name',
        key: 'warePosition.name',
        width: '8%',
      },
      {
        title: '库区',
        dataIndex: 'warePosition.wareZone.name',
        key: 'warePosition.wareZone.name',
        width: '10%',
      },
      {
        title: '所属客户',
        dataIndex: 'goods.customer.name',
        key: 'goods.customer.name',
        width: '12%',
      },
      {
        title: '存量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '1%',
        align: 'right',
        render: text => {
          if (text === 0) {
            return <Tag color="green">{text}</Tag>;
          }
          return <Tag color="red">{text}</Tag>;
        },
      },
      {
        title: '条码',
        dataIndex: 'goods.sn',
        key: 'goods.sn',
        width: '1%',
        render: text => {
          return (
            <Highlighter
              highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
              searchWords={[search]}
              autoEscape
              textToHighlight={text.toString()}
            />
          );
        },
      },
      {
        title: '到期',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '1%',
        align: 'right',
        render: text => {
          let result;
          let color;
          if (Date.now() - text > 0) {
            result = '已过期';
            color = 'red';
          } else {
            const leftDays = parseInt(Math.abs(text - Date.now()) / 1000 / 60 / 60 / 24, 10);
            const leftYears = Math.floor(leftDays / 365); // 暂时不考虑闰年
            const lastDays = leftDays % 365;
            result = leftYears > 0 ? `剩余${leftYears}年${lastDays}天` : `剩余${lastDays}天`;
            color = 'blue';
          }
          return (
            <Tooltip title={result}>
              <Tag color={color}>{moment(text).format('YYYY-MM-DD')}</Tag>
            </Tooltip>
          );
        },
      },
      {
        title: '价格',
        dataIndex: 'goods.price',
        key: 'goods.price',
        width: '1%',
        align: 'right',
        render: text => {
          if (text === 0) {
            return <Tag color="green">{accounting.formatMoney(text, '￥')}</Tag>;
          }
          return <Tag color="red">{accounting.formatMoney(text, '￥')}</Tag>;
        },
      },
      {
        title: '质保',
        dataIndex: 'goods.monthsOfWarranty',
        key: 'goods.monthsOfWarranty',
        width: '1%',
        align: 'right',
        render: text => {
          if (text % 12 === 0) {
            return <Tag color="blue">{text / 12}年</Tag>;
          }
          if (text > 12) {
            return (
              <Tag color="blue">
                {Math.floor(text / 12)}年{text % 12}月
              </Tag>
            );
          }
          return <Tag color="orange">{text}月</Tag>;
        },
      },
      {
        title: '规格',
        dataIndex: 'goods.packCount',
        key: 'goods.packCount',
        width: '1%',
        align: 'right',
        render: text => {
          return <Tag color="#2db7f5">{text}</Tag>;
        },
      },
      {
        title: '操作',
        width: '5%',
        align: 'right',
        render: (text, row) => {
          return (
            <Button
              size="small"
              htmlType="button"
              type="primary"
              onClick={() =>
                handleAddOrderItem(
                  row.goods.id,
                  row.goods.name,
                  row.goods.sn,
                  row.goods.packCount,
                  row.goods.price,
                  row.expireDate,
                  row.quantity,
                  null,
                  row.warePosition.id,
                  row.warePosition.wareZone.id
                )
              }
            >
              添加
            </Button>
          );
        },
      },
    ];

    const orderColumns = [
      {
        title: '#',
        width: '1%',
        key: 'key',
        render: (text, record, index) => {
          return (
            <span>
              {index + 1}
              <FormItem>
                {getFieldDecorator(`allItems.${record.id}.id`, {
                  initialValue: record.goods.id,
                })(<Input hidden />)}
              </FormItem>
            </span>
          );
        },
      },
      {
        title: '商品名称',
        dataIndex: 'goods.name',
        key: 'goods.name',
        width: '20%',
        render: (text, record) => {
          if (record) {
            return (
              <span>
                {text}
                <FormItem>
                  {getFieldDecorator(`allItems.${record.id}.name`, {
                    initialValue: record.goods.name,
                  })(<Input hidden />)}
                </FormItem>
              </span>
            );
          }
          return text;
        },
      },
      {
        title: '条码',
        dataIndex: 'goods.sn',
        key: 'goods.sn',
        width: '15%',
        render: (text, record) => {
          if (record) {
            return (
              <span>
                {text}
                <FormItem>
                  {getFieldDecorator(`allItems.${record.id}.sn`, {
                    initialValue: record.goods.sn,
                  })(<Input hidden />)}
                </FormItem>
              </span>
            );
          }
          return text;
        },
      },
      {
        title: '规格',
        dataIndex: 'goods.packCount',
        key: 'goods.packCount',
        width: '5%',
        align: 'right',
        render: (text, record) => {
          if (record) {
            return (
              <span>
                <Tag color="#2db7f5">{text}</Tag>
                <FormItem>
                  {getFieldDecorator(`allItems.${record.id}.packCount`, {
                    initialValue: record.goods.packCount,
                  })(<Input hidden />)}
                </FormItem>
              </span>
            );
          }
          return text;
        },
      },
      {
        title: '过期日',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '10%',
        render: (text, record) => {
          if (record) {
            return (
              <FormItem hasFeedback>
                {getFieldDecorator(`allItems.${record.id}.expireDate`, {
                  initialValue: text ? moment(new Date(text)) : null,
                })(<DatePicker disabled placeholder="系统自动匹配" />)}
              </FormItem>
            );
          }
          return text;
        },
      },
      {
        title: '所在库位',
        dataIndex: 'warePositionIn',
        key: 'warePositionIn',
        width: '15%',
        render: (text, record) => {
          if (record) {
            return (
              <FormItem hasFeedback>
                {getFieldDecorator(`allItems.${record.id}.warePosition`, {
                  initialValue:
                    record.warePosition !== null
                      ? [record.warePosition.wareZone.id, record.warePosition.id]
                      : null,
                })(
                  <Cascader
                    disabled
                    expandTrigger="hover"
                    placeholder="系统自动匹配"
                    options={getWarePositionOptions()}
                  />
                )}
              </FormItem>
            );
          }
          return text;
        },
      },
      {
        title: '价格',
        dataIndex: 'price',
        key: 'price',
        width: '5%',
        render: (text, record) => {
          if (record) {
            return (
              <FormItem hasFeedback>
                {getFieldDecorator(`allItems.${record.id}.price`, {
                  rules: [{ required: true, message: '请输入数量' }],
                  initialValue: text,
                })(
                  <InputNumber
                    min={0}
                    max={99999999}
                    step={0.01}
                    precision={2}
                    placeholder="请输入价格"
                  />
                )}
              </FormItem>
            );
          }
          return text;
        },
      },
      {
        title: '库存',
        dataIndex: 'quantityLeft',
        key: 'quantityLeft',
        width: '5%',
        render: (text, record) => {
          if (record) {
            return (
              <span>
                {text}
                <FormItem>
                  {getFieldDecorator(`allItems.${record.id}.sortOrder`, {
                    initialValue: record.sortOrder,
                  })(<Input hidden />)}
                </FormItem>
              </span>
            );
          }
          return text;
        },
      },
      {
        title: '订单数量',
        dataIndex: 'quantityInitial',
        key: 'quantityInitial',
        width: '5%',
        render: (text, record) => {
          if (record) {
            return (
              <FormItem hasFeedback>
                {getFieldDecorator(`allItems.${record.id}.quantityInitial`, {
                  rules: [{ required: true, message: '请输入数量' }],
                  initialValue: text,
                })(<InputNumber min={1} max={99999999} />)}
              </FormItem>
            );
          }
          return text;
        },
      },
      {
        title: '匹配数量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '5%',
        render: (text, record) => {
          if (record) {
            return (
              <span>
                {text}
                <FormItem>{<Input hidden />}</FormItem>
              </span>
            );
          }
          return text;
        },
      },
      {
        title: '操作',
        width: '6%',
        align: 'right',
        render: record => {
          return (
            <Popconfirm
              title="确定删除吗？"
              onConfirm={() => handleRemoveOrderItem(record.id)}
              okText="删除"
              cancelText="取消"
            >
              <Button htmlType="button" href="#" type="danger">
                删除
              </Button>
              <FormItem>{<Input hidden />}</FormItem>
            </Popconfirm>
          );
        },
      },
    ];

    const handleGoodsQuery = (newSearch, newGoodsCurrentPage) => {
      dispatch({
        type: 'goods/fetch',
        payload: {
          search: newSearch,
          pageSize: goodsPageSize,
          currentPage: newGoodsCurrentPage,
          orderBy: null,
          goodsTypeFilter: null,
          goodsCustomerFilter: customerFilter,
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
        goodsCurrentPage: 1,
        stockCurrentPage: 1,
      });
      handleGoodsQuery(value, goodsCurrentPage);
      handleStockQuery(value, stockCurrentPage);
    };

    const searchContent = (
      <div className={styles.extraContent}>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入商品名或条码进行搜索"
          onSearch={handleSearch}
        />
      </div>
    );

    return (
      <div className={styles.standardList}>
        <Card
          bordered
          title="滞销商品排行"
          style={{ marginTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
        >
          <Select
            filterOption={(input, option) =>
              option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
            }
            placeholder="请选择所属客户"
          >
            {getCustomersOptions(customerList)}
          </Select>
        </Card>
        <Card
          bordered={false}
          style={{ marginTop: 12, paddingTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
          extra={searchContent}
        >
          <Table
            columns={stockColumns}
            dataSource={stockList}
            rowKey="id"
            loading={loadingStock}
            size="small"
          />
        </Card>
      </div>
    );
  }
}

export default OrderForm;
