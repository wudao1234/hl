import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Button, Card, Form, Input, Popover, Table, Tag, DatePicker, Icon } from 'antd';
import accounting from 'accounting';

import Highlighter from 'react-highlight-words';
import moment from 'moment';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import styles from './StockFlow.less';

const { Search } = Input;
const { RangePicker } = DatePicker;

const initialSortState = {
  sortCreateTime: null,
  sortOperator: null,
  sortName: null,
  sortQuantity: null,
  sortWarePositionOut: null,
};

const initialState = {
  currentPage: 1,
  pageSize: 10,
  orderBy: null,
  search: null,
  searchWarePositionOut: null,
  startDate: null,
  endDate: null,
  customerFilter: null,
  wareZoneOutFilter: null,
  ...initialSortState,
};

@connect(({ stockFlow, wareZone, customer, loading }) => ({
  list: stockFlow.list.content,
  total: stockFlow.list.totalElements,
  wareZoneList: wareZone.allList,
  customerList: customer.allList,
  loading: loading.models.stockFlow && loading.models.wareZone && loading.models.customer,
}))
@Form.create()
class OrderStockFlow extends PureComponent {
  state = initialState;

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    const {
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter,
    } = this.state;
    this.handleQuery(
      dispatch,
      false,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter
    );
    dispatch({
      type: 'wareZone/fetchAll',
    });
    dispatch({
      type: 'customer/fetchMy',
    });
  }

  handleQuery = (
    dispatch,
    exportExcel,
    search,
    searchWarePositionOut,
    startDate,
    endDate,
    pageSize,
    currentPage,
    orderBy,
    customerFilter,
    wareZoneOutFilter
  ) => {
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
      type: 'stockFlow/fetchForOrders',
      payload: {
        exportExcel,
        search,
        searchWarePositionOut,
        startDate: startDateString,
        endDate: endDateString,
        pageSize,
        currentPage,
        orderBy,
        customerFilter,
        wareZoneOutFilter,
      },
    });
  };

  handleResetSearch = () => {
    this.setState(initialState, () => {
      const { dispatch } = this.props;
      const { pageSize, currentPage } = this.state;
      this.handleQuery(
        dispatch,
        false,
        null,
        null,
        null,
        null,
        pageSize,
        currentPage,
        null,
        null,
        null
      );
    });
  };

  handleWareZoneFilters = () => {
    const { wareZoneList } = this.props;
    const wareZoneFilter = [];
    if (wareZoneList) {
      wareZoneList.map(wareZone => {
        return wareZoneFilter.push({ text: wareZone.name, value: wareZone.id });
      });
    }
    return wareZoneFilter;
  };

  handleCustomerFilters = () => {
    const { customerList } = this.props;
    const customerFilters = [];
    if (customerList && customerList !== undefined) {
      customerList.map(customer => {
        return customerFilters.push({ text: customer.name, value: customer.id });
      });
    }
    return customerFilters;
  };

  handleSearchChange = e => {
    this.setState({
      search: e.target.value,
    });
  };

  handleWarePositionOutSearchChange = e => {
    this.setState({
      searchWarePositionOut: e.target.value,
    });
  };

  handleDateRangeChange = date => {
    const startDate = date[0];
    const endDate = date[1];
    this.setState({
      startDate,
      endDate,
    });
    const { dispatch } = this.props;
    const {
      search,
      searchWarePositionOut,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter,
    } = this.state;
    this.handleQuery(
      dispatch,
      false,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter
    );
  };

  handleSearch = () => {
    const { dispatch } = this.props;
    const {
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      customerFilter,
      wareZoneOutFilter,
    } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(
      dispatch,
      false,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      1,
      null,
      customerFilter,
      wareZoneOutFilter
    );
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search, searchWarePositionOut, startDate, endDate } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const {
      'customerOrder.owner.name': customerFilter = null,
      'warePositionOut.wareZone.name': wareZoneOutFilter = null,
    } = filters;
    const orderBy = field !== undefined ? `${field},${order}` : null;

    let sortOrders;
    switch (field) {
      case 'createTime':
        sortOrders = { ...initialSortState, sortCreateTime: order };
        break;
      case 'operator':
        sortOrders = { ...initialSortState, sortOperator: order };
        break;
      case 'name':
        sortOrders = { ...initialSortState, sortName: order };
        break;
      case 'quantity':
        sortOrders = { ...initialSortState, sortQuantity: order };
        break;
      case 'warePositionOut.name':
        sortOrders = { ...initialSortState, sortWarePositionOut: order };
        break;
      default:
        sortOrders = initialSortState;
    }

    this.setState({
      currentPage,
      pageSize,
      orderBy,
      customerFilter,
      wareZoneOutFilter,
      ...sortOrders,
    });
    this.handleQuery(
      dispatch,
      false,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter
    );
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const {
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter,
    } = this.state;
    this.handleQuery(
      dispatch,
      true,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      wareZoneOutFilter
    );
  };

  render() {
    const { list, total, loading } = this.props;
    const { pageSize, currentPage } = this.state;
    const { search, searchWarePositionOut, startDate, endDate } = this.state;
    const { customerFilter, wareZoneOutFilter } = this.state;

    const { sortCreateTime, sortName, sortQuantity, sortWarePositionOut } = this.state;

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
          placeholder="订单号/订单备注/订单客户/商品名/条码"
          onChange={this.handleSearchChange}
          onSearch={this.handleSearch}
        />
        <Search
          value={searchWarePositionOut}
          className={styles.warePosition}
          placeholder="出库库位"
          onChange={this.handleWarePositionOutSearchChange}
          onSearch={this.handleSearch}
        />
        <RangePicker
          style={{ marginLeft: 10 }}
          onChange={this.handleDateRangeChange}
          value={[startDate, endDate]}
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
        title: '客户',
        dataIndex: 'customerOrder.owner.shortNameCn',
        key: 'customerOrder.owner.name',
        width: '4%',
        filters: this.handleCustomerFilters(),
        filteredValue: customerFilter,
        render: text => {
          return text;
        },
      },
      {
        title: '客户订单号',
        dataIndex: 'customerOrder.clientOrderSn',
        key: 'customerOrder.clientOrderSn',
        width: '5%',
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
        title: '客户单据号',
        dataIndex: 'customerOrder.clientOrderSn2',
        key: 'customerOrder.clientOrderSn2',
        width: '5%',
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
        title: '自定义单号',
        dataIndex: 'customerOrder.autoIncreaseSn',
        key: 'customerOrder.autoIncreaseSn',
        width: '5%',
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
        title: '订单备注',
        dataIndex: 'customerOrder.description',
        key: 'customerOrder.description',
        width: '8%',
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
        title: '订单客户',
        dataIndex: 'customerOrder.clientName',
        key: 'customerOrder.clientName',
        width: '10%',
        render: (text, record) => {
          let tooltip;
          if (record.customerOrder !== undefined && record.customerOrder !== null) {
            tooltip = (
              <div>
                <p>
                  <b>客户名称</b>: {record.customerOrder.clientName}
                </p>
                <p>
                  <b>客户地址</b>: {record.customerOrder.clientAddress}
                </p>
                <p>
                  <b>客户门店</b>: {record.customerOrder.clientStore}
                </p>
              </div>
            );
          } else {
            tooltip = <div />;
          }
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
        title: '时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: '1%',
        sorter: true,
        sortOrder: sortCreateTime,
        render: text => {
          return <Tag>{moment(text).format('lll')}</Tag>;
        },
      },
      {
        title: '商品名称',
        dataIndex: 'name',
        width: '10%',
        key: 'name',
        sorter: true,
        sortOrder: sortName,
        render: (text, record) => {
          const tooltip = (
            <div>
              <p>
                <b>条码</b>: {record.sn}
              </p>
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
        title: '价格',
        dataIndex: 'price',
        key: 'price',
        width: '5%',
        render: text => {
          return <Tag>{accounting.formatMoney(text, '￥')}</Tag>;
        },
      },
      {
        title: '数量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '5%',
        sorter: true,
        sortOrder: sortQuantity,
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
        title: '出库库区',
        dataIndex: 'warePositionOut.wareZone.name',
        key: 'warePositionOut.wareZone.name',
        width: '5%',
        filters: this.handleWareZoneFilters(),
        filteredValue: wareZoneOutFilter,
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
        width: '5%',
        sorter: true,
        sortOrder: sortWarePositionOut,
        render: text => {
          if (text != null) {
            return (
              <Highlighter
                highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
                searchWords={[searchWarePositionOut]}
                autoEscape
                textToHighlight={text !== null && text !== undefined ? text.toString() : ''}
              />
            );
          }
          return <Tag color="#A9A9A9">空</Tag>;
        },
      },
    ];

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="订单出库流水查询"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <div className={styles.tableList}>
              <div className={styles.tableListOperator}>
                <Button icon="search" htmlType="button" onClick={this.handleResetSearch}>
                  重置查询参数
                </Button>
              </div>
              <Table
                columns={columns}
                dataSource={list}
                rowKey="id"
                loading={loading}
                pagination={paginationProps}
                onChange={this.handleTableChange}
                size="small"
              />
            </div>
          </Card>
        </div>
      </PageHeaderWrapper>
    );
  }
}

export default OrderStockFlow;
