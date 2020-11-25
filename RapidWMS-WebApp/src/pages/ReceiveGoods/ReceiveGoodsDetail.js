import React, { PureComponent } from 'react';
import router from 'umi/router';
import { Button, Card, Col, Divider, Icon, Popover, Row, Table, Tag } from 'antd';
import moment from 'moment';
import { connect } from 'dva';
import accounting from 'accounting';
import styles from './ReceiveGoods.less';

@connect(({ stockFlow, loading }) => ({
  stockFlowList: stockFlow.list,
  loadingStockFlow: loading.models.stockFlow,
}))
class ReceiveGoodsDetail extends PureComponent {
  state = {
    customerFilter: null,
    receiveGoodsType: null,
    receiveGoodsDescription: null,
    creator: null,
    createTime: null,
    auditor: null,
    auditTime: null,
    receiveGoodsItems: [],
    loadingReceiveGoodsItems: true,
  };

  componentDidMount() {
    const { dispatch, id } = this.props;
    dispatch({
      type: 'stockFlow/findByReceiveGoodsId',
      payload: id,
    });
  }

  componentWillReceiveProps(nextProps) {
    const { receiveGoods, loading } = nextProps;
    this.setState({
      loadingReceiveGoodsItems: loading,
    });
    if (receiveGoods !== null && receiveGoods !== undefined && loading) {
      this.setState({
        receiveGoodsItems: receiveGoods.receiveGoodsItems.sort((a, b) => {
          return a.createTime - b.createTime;
        }),
        customerFilter: receiveGoods.customer.name,
        receiveGoodsType: receiveGoods.receiveGoodsType,
        receiveGoodsDescription: receiveGoods.description,
        creator: receiveGoods.creator,
        createTime: receiveGoods.createTime,
        auditor: receiveGoods.auditor,
        auditTime: receiveGoods.auditTime,
      });
    }
  }

  render() {
    const { stockFlowList = [], loadingStockFlow, queryParams } = this.props;
    const {
      customerFilter,
      receiveGoodsType,
      receiveGoodsDescription,
      receiveGoodsItems,
      creator,
      createTime,
      auditor,
      auditTime,
      loadingReceiveGoodsItems,
    } = this.state;

    const receiveGoodsColumns = [
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
        width: '15%',
      },
      {
        title: '价格',
        dataIndex: 'price',
        key: 'price',
        width: '15%',
        render: text => {
          if (text === 0) {
            return <Tag color="green">{accounting.formatMoney(text, '￥')}</Tag>;
          }
          return <Tag color="red">{accounting.formatMoney(text, '￥')}</Tag>;
        },
      },
      {
        title: '过期日',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '10%',
        render: text => {
          return moment(text).format('YYYY-MM-DD');
        },
      },
      {
        title: '放入库位',
        dataIndex: 'warePosition',
        key: 'warePosition',
        width: '10%',
        render: record => {
          if (record !== null && record !== undefined) {
            return `${record.wareZone.name} / ${record.name}`;
          }
          return '';
        },
      },
      {
        title: '提审数量',
        dataIndex: 'quantityInitial',
        key: 'quantityInitial',
        width: '5%',
      },
      {
        title: '确认数量',
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
        title: '入库库区',
        dataIndex: 'warePositionIn.wareZone.name',
        key: 'warePositionIn.wareZone.name',
        width: '10%',
        render: text => {
          if (text == null) {
            return <Tag color="#A9A9A9">空</Tag>;
          }
          return text;
        },
      },
      {
        title: '入库库位',
        dataIndex: 'warePositionIn.name',
        key: 'warePositionIn.name',
        width: '8%',
        render: text => {
          if (text != null) {
            return text;
          }
          return <Tag color="#A9A9A9">空</Tag>;
        },
      },
    ];

    const handleGoBackToList = () => {
      router.push({
        pathname: '/warehouse/receiveGoods',
        query: {
          queryParams,
        },
      });
    };

    const getTypeValue = value => {
      let result;
      switch (value) {
        case 'NEW':
          result = '新增到货';
          break;
        case 'REJECTED':
          result = '退货';
          break;
        default:
          result = null;
          break;
      }
      return result;
    };

    return (
      <div className={styles.standardList}>
        <Card
          bordered
          title="查看入库信息"
          style={{ marginTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
        >
          <Row gutter={16}>
            <Col span={8}>
              <span style={{ fontWeight: 'bold' }}>入库客户：</span>
              {customerFilter}
            </Col>
            <Col span={8}>
              <span style={{ fontWeight: 'bold' }}>入库类型：</span>
              {getTypeValue(receiveGoodsType)}
            </Col>
            <Col span={8}>
              <span style={{ fontWeight: 'bold' }}>说明：</span>
              {receiveGoodsDescription}
            </Col>
          </Row>
          <Divider />
          <Row gutter={24}>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>提交人：</span>
              {creator}
            </Col>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>提交时间：</span>
              <Tag>{moment(createTime).format('lll')}</Tag>
            </Col>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>审核人：</span>
              {auditor}
            </Col>
            <Col span={6}>
              <span style={{ fontWeight: 'bold' }}>审核时间：</span>
              <Tag>{auditTime !== null ? moment(auditTime).format('lll') : '未审核'}</Tag>
            </Col>
          </Row>
          <Divider />
          <Table
            columns={receiveGoodsColumns}
            dataSource={Array.isArray(receiveGoodsItems) ? receiveGoodsItems : []}
            pagination={false}
            size="small"
            rowKey="id"
            loading={loadingReceiveGoodsItems}
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
      </div>
    );
  }
}

export default ReceiveGoodsDetail;
