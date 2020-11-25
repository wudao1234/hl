import React, { PureComponent } from 'react';
import router from 'umi/router';
import {
  Button,
  Card,
  Col,
  Divider,
  Form,
  Icon,
  Popover,
  Row,
  Steps,
  Table,
  Tag,
  Timeline,
  Alert,
} from 'antd';
import accounting from 'accounting';
import moment from 'moment';
import { connect } from 'dva';
import styles from './Order.less';

const { Step } = Steps;

@connect(({ customer, stockFlow, loading }) => ({
  customerList: customer.allList,
  stockFlowList: stockFlow.list,
  loadingStockFlow: loading.models.stockFlow,
}))
@Form.create()
class OrderDetail extends PureComponent {
  state = {
    customerFilter: null,
    printTitle: null,
    orderDescription: null,
    clientName: null,
    clientStore: null,
    clientAddress: null,
    clientOrderSn: null,
    clientOrderSn2: null,
    clientOperator: null,
    orderStatus: null,
    fetchAll: false,
    usePackCount: false,
    orderExpireDateMin: null,
    orderExpireDateMax: null,
    flowSn: null,
    autoIncreaseSn: null,
    allItems: [],
    operateSnapshots: [],
    tableFooter: null,
    wareZones: null,
    cancelDescription: null,
    totalPrice: 0,
    completePrice: 0,
    completeDescription: '',
  };

  componentDidMount() {
    const { dispatch, id } = this.props;
    dispatch({
      type: 'customer/fetchMy',
    });
    dispatch({
      type: 'stockFlow/fetchByOrderId',
      payload: id,
    });
  }

  componentWillReceiveProps(nextProps) {
    const { order, loading } = nextProps;
    if (order !== null && order !== undefined && loading) {
      const orderItems = order.customerOrderItems.sort((a, b) => {
        return a.createTime - b.createTime;
      });
      const orderStocks = order.customerOrderStocks.sort((a, b) => {
        return a.createTime - b.createTime;
      });
      const { operateSnapshots } = order;
      let allItems = [];
      orderStocks.forEach(item => {
        allItems.push({
          ...item,
        });
      });
      orderItems.forEach(item => {
        allItems.push({
          sortOrder: item.sortOrder,
          id: item.id,
          goods: {
            name: item.name,
            sn: item.sn,
            packCount: item.packCount,
          },
          quantityInitial: item.quantityInitial,
          quantity: item.quantity,
          description: item.description,
          price: item.price,
          warePosition: null,
        });
      });

      allItems = allItems.sort((a, b) => {
        return a.sortOrder - b.sortOrder;
      });

      this.setState({
        allItems,
        operateSnapshots,
        customerFilter: order.owner.name,
        printTitle: order.printTitle,
        orderDescription: order.description,
        clientName: order.clientName,
        clientStore: order.clientStore,
        clientAddress: order.clientAddress,
        clientOrderSn: order.clientOrderSn,
        clientOrderSn2: order.clientOrderSn2,
        clientOperator: order.clientOperator,
        orderStatus: order.orderStatus,
        fetchAll: order.fetchAll,
        orderExpireDateMin: order.expireDateMin,
        orderExpireDateMax: order.expireDateMax,
        usePackCount: order.usePackCount,
        flowSn: order.flowSn,
        autoIncreaseSn: order.autoIncreaseSn,
        wareZones: order.targetWareZoneList,
        cancelDescription: order.cancelDescription,
        totalPrice: order.totalPrice,
        completePrice: order.completePrice,
        completeDescription: order.completeDescription,
        tableFooter: () => {
          return (
            <span style={{ textAlign: 'center', display: 'block' }}>
              出货总数：{allItems.map(item => item.quantity).reduce((prev, curr) => prev + curr)}，
              商品总价：<Tag color="blue">{accounting.formatMoney(order.totalPrice, '￥')}</Tag>
            </span>
          );
        },
      });
    }
  }

  render() {
    const { stockFlowList, loading, loadingStockFlow, queryParams } = this.props;

    const {
      customerFilter,
      printTitle,
      orderDescription,
      clientName,
      clientStore,
      clientAddress,
      clientOrderSn,
      clientOrderSn2,
      clientOperator,
      orderStatus,
      fetchAll,
      usePackCount,
      orderExpireDateMin,
      orderExpireDateMax,
      flowSn,
      autoIncreaseSn,
      allItems,
      operateSnapshots,
      tableFooter,
      wareZones,
      cancelDescription,
    } = this.state;

    const orderColumns = [
      {
        title: '#',
        width: '1%',
        key: 'key',
        render: (text, record, index) => {
          return `${index + 1}`;
        },
      },
      {
        title: '商品名称',
        dataIndex: 'goods.name',
        key: 'goods.name',
        width: '15%',
      },
      {
        title: '条码',
        dataIndex: 'goods.sn',
        key: 'goods.sn',
        width: '1%',
      },
      {
        title: '规格',
        dataIndex: 'goods.packCount',
        key: 'goods.packCount',
        width: '5%',
        align: 'right',
        render: text => {
          return <Tag color="#2db7f5">{text}</Tag>;
        },
      },
      {
        title: '过期日',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '10%',
        render: text => {
          if (text) {
            return <Tag>{moment(text).format('YYYY-MM-DD')}</Tag>;
          }
          return <Tag>未指定</Tag>;
        },
      },
      {
        title: '指定库位',
        dataIndex: 'warePositionIn',
        key: 'warePositionIn',
        width: '10%',
        render: (text, record) => {
          if (record !== null && record !== undefined && record.warePosition != null) {
            return `${record.warePosition.wareZone.name} / ${record.warePosition.name}`;
          }
          return <Tag>未指定</Tag>;
        },
      },
      {
        title: '价格',
        dataIndex: 'price',
        key: 'price',
        width: '5%',
        render: (text, record) => {
          if (record !== null && record !== undefined) {
            return <Tag color="blue">{accounting.formatMoney(text, '￥')}</Tag>;
          }
          return '';
        },
      },
      {
        title: '订单数量',
        dataIndex: 'quantityInitial',
        key: 'quantityInitial',
        width: '5%',
      },
      {
        title: '出货数量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '5%',
        render: (text, record) => {
          if (record) {
            if (record.quantityInitial !== record.quantity) {
              return <span style={{ color: 'red' }}>{text}</span>;
            }
          }
          return text;
        },
      },
      {
        title: '说明',
        dataIndex: 'description',
        key: 'description',
        width: '10%',
      },
    ];

    const stockFlowColumns = [
      {
        title: '#',
        width: '1%',
        key: 'key',
        render: (text, record, index) => {
          return `${index + 1}`;
        },
      },
      {
        title: '类别',
        dataIndex: 'flowOperateType',
        key: 'flowOperateType',
        width: '1%',
        render: text => {
          let result;
          let color;
          switch (text) {
            case 'IN_ADD':
              result = '入库-新增到货';
              color = '#DC143C';
              break;
            case 'IN_CUSTOMER_REJECTED':
              result = '入库-客户退货';
              color = '#DDA0DD';
              break;
            case 'IN_PROFIT':
              result = '入库-库存盘盈';
              color = '#191970';
              break;
            case 'OUT_LOSSES':
              result = '出库-库存盘亏';
              color = '#FF8C00';
              break;
            case 'OUT_ORDER_FIT':
              result = '出库-订单匹配';
              color = '#00BFFF';
              break;
            case 'MOVE':
              result = '移库-仓库管理';
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
        title: '时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: '1%',
        render: text => {
          return <Tag>{moment(text).format('lll')}</Tag>;
        },
      },
      {
        title: '操作',
        dataIndex: 'operator',
        key: 'operator',
        width: '5%',
      },
      {
        title: '商品名称',
        dataIndex: 'name',
        key: 'name',
        render: (text, record) => {
          const tooltip = (
            <div>
              <p>
                <b>价格</b>: {accounting.formatMoney(record.price, '￥')}
              </p>
              <p>
                <b>到期日</b>: {moment(record.expireDate).format('YYYY-MM-DD')}
              </p>
              <p>
                <b>规格</b>: {record.packCount}
              </p>
            </div>
          );
          return (
            <span>
              <Popover content={tooltip} title={text}>
                <a style={{ marginRight: 3 }}>
                  <Icon type="exclamation-circle" />
                </a>
                {text}
              </Popover>
            </span>
          );
        },
      },
      {
        title: '商品条码',
        dataIndex: 'sn',
        key: 'sn',
        width: '10%',
      },
      {
        title: '数量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '5%',
        render: (text, record) => {
          let iconType;
          switch (record.flowOperateType) {
            case 'IN_ADD':
            case 'IN_CUSTOMER_REJECTED':
            case 'IN_STOCK_REJECTED':
            case 'IN_ORDER_REJECTED':
            case 'IN_PROFIT':
              iconType = '+';
              break;
            case 'OUT_LOSSES':
            case 'OUT_ORDER_FIT':
              iconType = '-';
              break;
            case 'MOVE':
              iconType = '~';
              break;
            default:
              iconType = '?';
              break;
          }
          return `${iconType}${text}`;
        },
      },
      {
        title: '质保期',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '1%',
        render: text => {
          return <Tag>{moment(text).format('YYYY-MM-DD')}</Tag>;
        },
      },
      {
        title: '出库库区',
        dataIndex: 'warePositionOut.wareZone.name',
        key: 'warePositionOut.wareZone.name',
        width: '10%',
        render: text => {
          if (text == null) {
            return <Tag color="#A9A9A9">空</Tag>;
          }
          return text;
        },
      },
      {
        title: '出库库位',
        dataIndex: 'warePositionOut.name',
        key: 'warePositionOut.name',
        width: '10%',
        render: text => {
          if (text != null) {
            return text;
          }
          return <Tag color="#A9A9A9">空</Tag>;
        },
      },
    ];

    const handleGoBackToList = () => {
      const { viewFromComplete } = queryParams;
      if (viewFromComplete === true) {
        router.push({
          pathname: '/order/completeOrder',
          query: {
            queryParams,
          },
        });
      } else {
        router.push({
          pathname: '/order/order',
          query: {
            queryParams,
          },
        });
      }
    };

    const getOrderStatusValue = status => {
      switch (status) {
        case 'INIT':
          return 1;
        case 'FETCH_STOCK':
          return 2;
        case 'GATHERING_GOODS':
          return 3;
        case 'GATHER_GOODS':
          return 4;
        case 'CONFIRM':
          return 5;
        case 'PACKAGE':
          return 6;
        case 'SENDING':
          return 7;
        case 'CLIENT_SIGNED':
          return 8;
        case 'COMPLETE':
          return 9;
        case 'CANCEL':
          return 99;
        default:
          return 0;
      }
    };

    const getOrderSteps = () => {
      const { totalPrice, completePrice, completeDescription } = this.state;
      const description = `订单金额：${accounting.formatMoney(
        totalPrice,
        '￥'
      )} / 回执确认金额：${accounting.formatMoney(completePrice, '￥')} / 回执说明：${
        completeDescription === null ? '(未填写)' : completeDescription
      }`;
      if (orderStatus !== 'CANCEL') {
        return (
          <div style={{ paddingBottom: 30 }}>
            {orderStatus === 'COMPLETE' ? (
              <span>
                <Alert
                  type="success"
                  showIcon
                  message="此订单已经完成全部流程"
                  description={description}
                />
                <Divider />
              </span>
            ) : (
              ''
            )}
            <Steps
              size="small"
              labelPlacement="vertical"
              current={getOrderStatusValue(orderStatus)}
            >
              <Step title="生成订单" />
              <Step title="匹配出库" />
              <Step title="正在分拣" />
              <Step title="分拣完成" />
              <Step title="复核分拣" />
              <Step title="整理打包" />
              <Step title="物流派送" />
              <Step title="签收确认" />
              <Step title="回执完成" />
            </Steps>
          </div>
        );
      }
      return (
        <span>
          <Alert
            type="warning"
            showIcon
            message="订单已经作废"
            description={`原因说明：${cancelDescription}`}
          />
          <Divider />
        </span>
      );
    };

    const getOperateSnapshots = () => {
      const items = [];
      operateSnapshots.forEach(snapshot =>
        items.push(
          <Timeline.Item key={snapshot.id}>
            {moment(snapshot.createTime).format('llll')} <Tag color="blue">{snapshot.operator}</Tag>{' '}
            {snapshot.operation}
          </Timeline.Item>
        )
      );
      return <Timeline>{items}</Timeline>;
    };

    return (
      <div className={styles.standardList}>
        <Card
          bordered
          title="订单详情"
          style={{ marginTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
        >
          <Row gutter={16}>
            <Col>{getOrderSteps()}</Col>
          </Row>
          <Row gutter={16}>
            <Col span={5}>
              <span style={{ fontWeight: 'bold' }}>入库客户：</span>
              {customerFilter}
            </Col>
            <Col span={5}>
              <span style={{ fontWeight: 'bold' }}>打印标题：</span>
              {printTitle}
            </Col>
            <Col span={5}>
              <span style={{ fontWeight: 'bold' }}>订单说明：</span>
              {orderDescription}
            </Col>
            <Col span={5}>
              <span style={{ fontWeight: 'bold' }}>订单流水号：</span>
              {flowSn}
            </Col>
            <Col span={4}>
              <span style={{ fontWeight: 'bold' }}>订单自编号：</span>
              {autoIncreaseSn}
            </Col>
          </Row>
          <Divider />
          <Row gutter={16}>
            <Col span={5}>
              <span style={{ fontWeight: 'bold' }}>订单客户名称：</span>
              {clientName}
            </Col>
            <Col span={4}>
              <span style={{ fontWeight: 'bold' }}>订单客户地址：</span>
              {clientAddress}
            </Col>
            <Col span={4}>
              <span style={{ fontWeight: 'bold' }}>订单客户门店：</span>
              {clientStore}
            </Col>
            <Col span={4}>
              <span style={{ fontWeight: 'bold' }}>客户订单号：</span>
              {clientOrderSn}
            </Col>
            <Col span={4}>
              <span style={{ fontWeight: 'bold' }}>客户单据号：</span>
              {clientOrderSn2}
            </Col>
            <Col span={3}>
              <span style={{ fontWeight: 'bold' }}>客户订单操作人员：</span>
              {clientOperator}
            </Col>
          </Row>
          <Divider />
          <Row gutter={16}>
            <Col span={3}>
              <span style={{ fontWeight: 'bold' }}>必须全部匹配：</span>
              {fetchAll !== undefined && fetchAll ? '是' : '否'}
            </Col>
            <Col span={3}>
              <span style={{ fontWeight: 'bold' }}>强制匹配商品规格：</span>
              {usePackCount !== undefined && usePackCount ? '是' : '否'}
            </Col>
            <Col span={3}>
              <span style={{ fontWeight: 'bold' }}>指定的匹配库区：</span>
              {wareZones !== undefined && wareZones
                ? wareZones.map(item => item.name).join(' / ')
                : '未指定'}
            </Col>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>最低保质期：</span>
              {orderExpireDateMin !== undefined && orderExpireDateMin !== null
                ? moment(orderExpireDateMin).format('YYYY-MM-DD')
                : '未指定'}
            </Col>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>最高保质期：</span>
              {orderExpireDateMax !== undefined && orderExpireDateMax !== null
                ? moment(orderExpireDateMax).format('YYYY-MM-DD')
                : '未指定'}
            </Col>
          </Row>
          <Divider />
          <Table
            columns={orderColumns}
            dataSource={Array.isArray(allItems) ? allItems : []}
            pagination={false}
            size="small"
            rowKey="id"
            loading={loading}
            footer={tableFooter}
          />
          <Row>
            <Col span={18} offset={6}>
              <Button
                htmlType="button"
                type="primary"
                size="large"
                style={{ width: '70%', marginTop: 24, marginLeft: 24 }}
                onClick={handleGoBackToList}
              >
                返回列表
              </Button>
            </Col>
          </Row>
        </Card>
        <Card title="相关流水" bordered={false} style={{ marginTop: 12 }}>
          <Table
            columns={stockFlowColumns}
            dataSource={Array.isArray(stockFlowList) ? stockFlowList : []}
            rowKey="id"
            loading={loadingStockFlow}
            size="small"
            pagination={false}
          />
        </Card>
        <Card title="操作记录" bordered={false} style={{ marginTop: 12 }}>
          {getOperateSnapshots()}
        </Card>
      </div>
    );
  }
}

export default OrderDetail;
