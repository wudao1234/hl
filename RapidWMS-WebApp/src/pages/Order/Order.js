import React, { Fragment, PureComponent } from 'react';
import { Document, Page } from 'react-pdf';
import { connect } from 'dva';
import {
  Alert,
  BackTop,
  Button,
  Card,
  DatePicker,
  Form,
  Icon,
  Input,
  message,
  Modal,
  notification,
  Popconfirm,
  Popover,
  Progress,
  Table,
  Tag,
  InputNumber,
  Radio,
} from 'antd';

import Highlighter from 'react-highlight-words';
import moment from 'moment';
import router from 'umi/router';
import accounting from 'accounting';
import FormItem from 'antd/es/form/FormItem';
import print from 'print-js';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import styles from './Order.less';

const { Search } = Input;
const { RangePicker } = DatePicker;
const { TextArea } = Input;

const initialSortState = {
  sortClientName: null,
  sortClientOrderSn: null,
  sortClientOrderSn2: null,
  sortTotalPrice: null,
  sortCreateTime: null,
  sortFlowSn: null,
  sortAutoIncreaseSn: null,
};

const initialModalState = {
  singleModalVisible: false,
  completeModalVisible: false,
  updateCompleteModalVisible: false,
  printModalVisible: false,
  done: false,
};

const initialState = {
  currentPage: 1,
  pageSize: 10,
  orderBy: null,
  search: null,
  isPrintedFilter: null,
  orderStatusFilter: null,
  receiveTypeFilter: null,
  isSatisfiedFilter: null,
  customerFilter: null,
  startDate: null,
  endDate: null,
  selectedRowKeys: [],
  selectedRows: [],
  loadingFetchStockAndReturnStock: false,
  numPages: 0,
  ...initialSortState,
  ...initialModalState,
};

@connect(({ order, customer, loading }) => ({
  list: order.list.content,
  pdf: order.pdf,
  total: order.list.totalElements,
  customerList: customer.allList,
  loading: loading.models.order && loading.models.customer,
}))
@Form.create()
class Order extends PureComponent {
  state = initialState;

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    const {
      location: {
        query: { queryParams },
      },
    } = this.props;

    const {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;

    if (queryParams !== undefined && queryParams !== null) {
      this.setQueryParamsAndQuery(queryParams);
    } else {
      this.handleQuery(
        dispatch,
        false,
        search,
        startDate,
        endDate,
        pageSize,
        currentPage,
        orderBy,
        isPrintedFilter,
        isSatisfiedFilter,
        orderStatusFilter,
        receiveTypeFilter,
        customerFilter
      );
    }
    dispatch({
      type: 'customer/fetchMy',
    });
  }

  reloadPage = () => {
    this.cleanSelectedKeys();
    const { dispatch } = this.props;
    const {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;
    this.handleQuery(
      dispatch,
      false,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter
    );
  };

  getQueryParams = () => {
    const {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;
    return {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    };
  };

  setQueryParamsAndQuery = params => {
    const {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = params;

    let sortOrders;
    if (orderBy !== undefined && orderBy !== null) {
      const orderByArray = orderBy.split(',');
      sortOrders = this.getSortOrders(orderByArray[0], orderByArray[1]);
    }

    this.setState(
      {
        search,
        startDate,
        endDate,
        pageSize,
        currentPage,
        orderBy,
        isPrintedFilter,
        isSatisfiedFilter,
        orderStatusFilter,
        receiveTypeFilter,
        customerFilter,
        ...sortOrders,
      },
      () => {
        this.reloadPage();
      }
    );
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
        pageSize,
        currentPage,
        null,
        null,
        null,
        null,
        null
      );
    });
    router.push('/order/order');
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

  handleSearch = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const {
      startDate,
      endDate,
      pageSize,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.cleanSelectedKeys();
    this.handleQuery(
      dispatch,
      false,
      search,
      startDate,
      endDate,
      pageSize,
      1,
      null,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter
    );
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
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;
    this.cleanSelectedKeys();
    this.handleQuery(
      dispatch,
      false,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter
    );
  };

  handleQuery = (
    dispatch,
    exportExcel,
    search,
    startDate,
    endDate,
    pageSize,
    currentPage,
    orderBy,
    isPrintedFilter,
    isSatisfiedFilter,
    orderStatusFilter,
    receiveTypeFilter,
    customerFilter
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
      type: 'order/fetch',
      payload: {
        exportExcel,
        search,
        startDate: startDateString,
        endDate: endDateString,
        pageSize,
        currentPage,
        orderBy,
        isPrintedFilter,
        isSatisfiedFilter,
        orderStatusFilter,
        receiveTypeFilter,
        customerFilter,
      },
    });
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleSelectRows = (newSelectedRowKeys, newSelectedRows) => {
    this.setState({
      selectedRowKeys: newSelectedRowKeys,
      selectedRows: newSelectedRows,
    });
  };

  cleanSelectedKeys = () => {
    this.setState({
      selectedRowKeys: [],
      selectedRows: [],
    });
  };

  getSortOrders = (field, order) => {
    let sortOrders;
    switch (field) {
      case 'clientName':
        sortOrders = { ...initialSortState, sortClientName: order };
        break;
      case 'clientOrderSn':
        sortOrders = { ...initialSortState, sortClientOrderSn: order };
        break;
      case 'clientOrderSn2':
        sortOrders = { ...initialSortState, sortClientOrderSn2: order };
        break;
      case 'createTime':
        sortOrders = { ...initialSortState, sortCreateTime: order };
        break;
      case 'totalPrice':
        sortOrders = { ...initialSortState, sortTotalPrice: order };
        break;
      case 'flowSn':
        sortOrders = { ...initialSortState, sortFlowSn: order };
        break;
      case 'autoIncreaseSn':
        sortOrders = { ...initialSortState, sortAutoIncreaseSn: order };
        break;
      default:
        sortOrders = initialSortState;
    }
    return sortOrders;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search, startDate, endDate } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const {
      isPrinted: isPrintedFilter = null,
      isSatisfied: isSatisfiedFilter = null,
      'owner.name': customerFilter = null,
      orderStatus: orderStatusFilter = null,
      receiveType: receiveTypeFilter = null,
    } = filters;
    const orderBy = field !== undefined ? `${field},${order}` : null;

    const sortOrders = this.getSortOrders(field, order);

    this.cleanSelectedKeys();
    this.setState({
      currentPage,
      pageSize,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
      ...sortOrders,
    });
    this.handleQuery(
      dispatch,
      false,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter
    );
  };

  showSingleModal = () => {
    this.setState({
      singleModalVisible: true,
    });
  };

  handleSingleDone = () => {
    this.setState({
      done: false,
      singleModalVisible: false,
    });
  };

  handleSingleCancel = () => {
    this.setState({
      singleModalVisible: false,
    });
  };

  handleSingleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;
    const { selectedRowKeys } = this.state;
    form.validateFields(['cancelDescription'], (err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleSingleDone();
      dispatch({
        type: 'order/cancelByIds',
        payload: { ...fieldsValue, ids: selectedRowKeys },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            const { countSucceed, countFailed } = response;
            if (countSucceed !== 0) {
              message.success(`成功完成${countSucceed}项内容操作`);
            }
            if (countFailed !== 0) {
              message.error(`${countFailed}项内容操作失败`);
            }
            this.reloadPage();
          }
        },
      });
    });
  };

  showCompleteModal = () => {
    this.setState({
      completeModalVisible: true,
    });
  };

  handleCompleteDone = () => {
    this.setState({
      done: false,
      completeModalVisible: false,
    });
  };

  handleCompleteCancel = () => {
    this.setState({
      completeModalVisible: false,
    });
  };

  handleCompleteSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;

    form.validateFields(
      ['id', 'completePrice', 'receiveType', 'completeDescription'],
      (err, fieldsValue) => {
        if (err) {
          return;
        }
        this.handleCompleteDone();
        dispatch({
          type: 'order/complete',
          payload: fieldsValue,
          callback: response => {
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed !== 0) {
                message.success(`成功完成${countSucceed}项内容操作`);
              }
              if (countFailed !== 0) {
                message.error(`${countFailed}项内容操作失败`);
              }
              this.reloadPage();
            }
          },
        });
      }
    );
  };

  showUpdateCompleteModal = () => {
    this.setState({
      updateCompleteModalVisible: true,
    });
  };

  handleUpdateCompleteDone = () => {
    this.setState({
      done: false,
      updateCompleteModalVisible: false,
    });
  };

  handleUpdateCompleteCancel = () => {
    this.setState({
      updateCompleteModalVisible: false,
    });
  };

  handleUpdateCompleteSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;

    form.validateFields(
      ['id', 'updateCompletePrice', 'receiveType', 'updateCompleteDescription'],
      (err, fieldsValue) => {
        if (err) {
          return;
        }
        this.handleUpdateCompleteDone();
        dispatch({
          type: 'order/updateComplete',
          payload: fieldsValue,
          callback: response => {
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed !== 0) {
                message.success(`成功完成${countSucceed}项内容操作`);
              }
              if (countFailed !== 0) {
                message.error(`${countFailed}项内容操作失败`);
              }
              this.reloadPage();
            }
          },
        });
      }
    );
  };

  showPrintModal = () => {
    this.setState({
      printModalVisible: true,
    });
  };

  handlePrintDone = () => {
    this.setState({
      done: false,
      printModalVisible: false,
    });
  };

  handlePrintCancel = () => {
    this.setState({
      printModalVisible: false,
    });
    this.reloadPage();
  };

  handlePrintSubmit = () => {
    const { pdf } = this.props;
    print(pdf);
  };

  handleAddOrder = () => {
    router.push({
      pathname: '/order/addOrder',
      query: {
        queryParams: this.getQueryParams(),
      },
    });
  };

  handleImportOrder = () => {
    router.push('/order/importOrder');
  };

  handlePrint = () => {
    const { dispatch } = this.props;
    const { selectedRowKeys } = this.state;
    dispatch({
      type: 'order/printByIds',
      payload: selectedRowKeys,
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        }
      },
    });
    this.showPrintModal();
  };

  handlePrintOrigin = () => {
    const { dispatch } = this.props;
    const { selectedRowKeys } = this.state;
    dispatch({
      type: 'order/printOriginByIds',
      payload: selectedRowKeys,
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        }
      },
    });
    this.showPrintModal();
  };

  editOrder = () => {
    const { selectedRowKeys } = this.state;
    if (selectedRowKeys.length === 1) {
      router.push({
        pathname: `/order/editOrder/${selectedRowKeys[0]}`,
        query: {
          queryParams: this.getQueryParams(),
        },
      });
    }
  };

  viewOrder = item => {
    router.push({
      pathname: `/order/viewOrder/${item.id}`,
      query: {
        queryParams: this.getQueryParams(),
      },
    });
  };

  handleOrderStatusFilters = () => {
    const orderStatusFilter = [];
    orderStatusFilter.push({ text: '生成订单', value: 0 });
    orderStatusFilter.push({ text: '匹配出库', value: 1 });
    orderStatusFilter.push({ text: '正在分拣', value: 2 });
    orderStatusFilter.push({ text: '分拣完成', value: 3 });
    orderStatusFilter.push({ text: '复核分拣', value: 4 });
    orderStatusFilter.push({ text: '整理打包', value: 5 });
    orderStatusFilter.push({ text: '物流派送', value: 6 });
    orderStatusFilter.push({ text: '签收确认', value: 7 });
    orderStatusFilter.push({ text: '回执完成', value: 8 });
    orderStatusFilter.push({ text: '订单作废', value: 9 });
    return orderStatusFilter;
  };

  handleReceiveTypeFilters = () => {
    const receiveTypeFilter = [];
    receiveTypeFilter.push({ text: '全部签收', value: '0' });
    receiveTypeFilter.push({ text: '部分签收 ', value: '1' });
    receiveTypeFilter.push({ text: '全部拒收 ', value: '2' });
    return receiveTypeFilter;
  };

  getProgress = orderStatus => {
    let percents;
    switch (orderStatus) {
      case 'INIT':
        percents = 15;
        break;
      case 'FETCH_STOCK':
        percents = 20;
        break;
      case 'GATHERING_GOODS':
        percents = 30;
        break;
      case 'GATHER_GOODS':
        percents = 40;
        break;
      case 'CONFIRM':
        percents = 50;
        break;
      case 'PACKAGE':
        percents = 60;
        break;
      case 'SENDING':
        percents = 75;
        break;
      case 'CLIENT_SIGNED':
        percents = 90;
        break;
      case 'COMPLETE':
        percents = 100;
        break;
      case 'CANCEL':
        percents = 0;
        break;
      default:
        percents = 0;
        break;
    }
    return percents;
  };

  handleIsPrintedFilters = () => {
    const isPrintedFilter = [];
    isPrintedFilter.push({ text: '已打印', value: true });
    isPrintedFilter.push({ text: '未打印 ', value: false });
    return isPrintedFilter;
  };

  handleIsSatisfiedFilters = () => {
    const isSatisfiedFilter = [];
    isSatisfiedFilter.push({ text: '未匹配', value: 'undefined' });
    isSatisfiedFilter.push({ text: '全匹配 ', value: 'true' });
    isSatisfiedFilter.push({ text: '部分匹配 ', value: 'false' });
    return isSatisfiedFilter;
  };

  handleFetch = () => {
    this.setState({ loadingFetchStockAndReturnStock: true });
    const { selectedRowKeys } = this.state;
    if (selectedRowKeys.length >= 1) {
      const { dispatch } = this.props;
      dispatch({
        type: 'order/fetchStocksByIds',
        payload: selectedRowKeys,
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            const { countSucceed, countFailed } = response;
            if (countSucceed !== 0) {
              message.success(`成功完成${countSucceed}项内容操作`);
            }
            if (countFailed !== 0) {
              message.error(`${countFailed}项内容操作失败`);
            }
            this.reloadPage();
          }
          this.setState({ loadingFetchStockAndReturnStock: false });
        },
      });
    }
  };

  handleReturn = () => {
    this.setState({ loadingFetchStockAndReturnStock: true });
    const { selectedRowKeys } = this.state;
    if (selectedRowKeys.length >= 1) {
      const { dispatch } = this.props;
      dispatch({
        type: 'order/returnStocksByIds',
        payload: selectedRowKeys,
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            const { countSucceed, countFailed } = response;
            if (countSucceed !== 0) {
              message.success(`成功完成${countSucceed}项内容操作`);
            }
            if (countFailed !== 0) {
              message.error(`${countFailed}项内容操作失败`);
            }
            this.reloadPage();
          }
          this.setState({ loadingFetchStockAndReturnStock: false });
        },
      });
    }
  };

  handleDelete = () => {
    const { selectedRowKeys } = this.state;
    if (selectedRowKeys.length >= 1) {
      const { dispatch } = this.props;
      dispatch({
        type: 'order/deleteByIds',
        payload: selectedRowKeys,
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            const { countSucceed, countFailed } = response;
            if (countSucceed !== 0) {
              message.success(`成功完成${countSucceed}项内容操作`);
            }
            if (countFailed !== 0) {
              message.error(`${countFailed}项内容操作失败`);
            }
            this.reloadPage();
          }
        },
      });
    }
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter,
    } = this.state;
    this.handleQuery(
      dispatch,
      true,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      orderStatusFilter,
      receiveTypeFilter,
      customerFilter
    );
  };

  render() {
    const { list, total, loading } = this.props;
    const { pageSize, currentPage } = this.state;
    const { loadingFetchStockAndReturnStock, search, startDate, endDate } = this.state;
    const {
      isPrintedFilter,
      isSatisfiedFilter,
      customerFilter,
      orderStatusFilter,
      receiveTypeFilter,
    } = this.state;
    const { selectedRowKeys = [], selectedRows = [] } = this.state;
    const {
      sortClientName,
      sortClientOrderSn,
      sortClientOrderSn2,
      sortTotalPrice,
      sortCreateTime,
      sortAutoIncreaseSn,
    } = this.state;

    const paginationProps = {
      showSizeChanger: true,
      showQuickJumper: true,
      showTotal: this.handleTotal,
      current: currentPage,
      total,
      pageSize,
      position: 'both',
    };

    const rowSelectionProps = {
      columnWidth: '1%',
      onChange: this.handleSelectRows,
      selectedRowKeys,
      selectedRows,
    };

    const { done } = this.state;
    const {
      form: { getFieldDecorator },
    } = this.props;

    const searchContent = (
      <div className={styles.extraContent}>
        <Search
          value={search}
          className={styles.extraContentSearch}
          placeholder="客户名, 说明，操作人姓名"
          onChange={this.handleSearchChange}
          onSearch={this.handleSearch}
        />
        <RangePicker
          style={{ marginLeft: 10, marginRight: 10 }}
          onChange={this.handleDateRangeChange}
          value={[startDate, endDate]}
        />
        <Button htmlType="button" type="primary" icon="export" onClick={this.handleExportExcel}>
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
        title: '打印',
        dataIndex: 'isPrinted',
        key: 'isPrinted',
        width: '1%',
        align: 'center',
        filters: this.handleIsPrintedFilters(),
        filteredValue: isPrintedFilter,
        filterMultiple: false,
        render: text => {
          if (text) {
            return <Tag color="blue">已打印</Tag>;
          }
          return <Tag color="#A9A9A9">未打印</Tag>;
        },
      },
      {
        title: '出货',
        dataIndex: 'isSatisfied',
        key: 'isSatisfied',
        width: '1%',
        align: 'center',
        filters: this.handleIsSatisfiedFilters(),
        filteredValue: isSatisfiedFilter,
        filterMultiple: false,
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
        filters: this.handleOrderStatusFilters(),
        filteredValue: orderStatusFilter,
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
        title: '进度',
        dataIndex: 'orderStatusProgress',
        key: 'orderStatusProgress',
        width: '1%',
        align: 'center',
        render: (text, record) => {
          if (record.orderStatus === 'CANCEL') {
            return <Progress type="circle" percent={0} width={30} status="exception" />;
          }
          return (
            <Progress type="circle" percent={this.getProgress(record.orderStatus)} width={30} />
          );
        },
      },
      {
        title: '客户',
        dataIndex: 'owner.shortNameCn',
        key: 'owner.name',
        width: '8%',
        filters: this.handleCustomerFilters(),
        filteredValue: customerFilter,
      },
      {
        title: '打印标题',
        dataIndex: 'printTitle',
        key: 'printTitle',
        width: '10%',
      },
      {
        title: '订单客户',
        dataIndex: 'clientName',
        key: 'clientName',
        width: '10%',
        sorter: true,
        sortOrder: sortClientName,
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
        sorter: true,
        sortOrder: sortClientOrderSn,
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
        title: '客户单据号',
        dataIndex: 'clientOrderSn2',
        key: 'clientOrderSn2',
        width: '10%',
        sorter: true,
        sortOrder: sortClientOrderSn2,
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
        title: '金额',
        dataIndex: 'totalPrice',
        key: 'totalPrice',
        width: '1%',
        align: 'right',
        sorter: true,
        sortOrder: sortTotalPrice,
        render: text => {
          return <Tag color="blue">{accounting.formatMoney(text, '￥')}</Tag>;
        },
      },
      {
        title: '提交时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: '1%',
        sorter: true,
        sortOrder: sortCreateTime,
        render: text => {
          return <Tag>{moment(text).format('YY/MM/DD/HH:mm')}</Tag>;
        },
      },
      {
        title: '自编号',
        dataIndex: 'autoIncreaseSn',
        key: 'autoIncreaseSn',
        width: '1%',
        sorter: true,
        sortOrder: sortAutoIncreaseSn,
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
        title: '制单',
        dataIndex: 'userCreator.username',
        key: 'userCreator.username',
        width: '6%',
      },
      {
        title: '接收',
        dataIndex: 'receiveType',
        key: 'receiveType',
        width: '6%',
        align: 'center',
        filters: this.handleReceiveTypeFilters(),
        filteredValue: receiveTypeFilter,
        render: text => {
          let result;
          let color;
          switch (text) {
            case 'ALL_SEND':
              result = '全部签收';
              color = '#DC143C';
              break;
            case 'PARTIAL_REJECT':
              result = '部分拒收';
              color = '#191970';
              break;
            case 'ALL_REJECT':
              result = '全部拒收';
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
                this.viewOrder(row);
              }}
            >
              查看
            </Button>
          );
        },
      },
    ];

    const singleModalFooter = done
      ? { footer: null, onCancel: this.handleSingleDone }
      : { okText: '作废订单', onOk: this.handleSingleSubmit, onCancel: this.handleSingleCancel };

    const completeModalFooter = done
      ? { footer: null, onCancel: this.handleCompleteDone }
      : {
          okText: '确认完成',
          onOk: this.handleCompleteSubmit,
          onCancel: this.handleCompleteCancel,
        };

    const updateCompleteModalFooter = done
      ? { footer: null, onCancel: this.handleUpdateCompleteDone }
      : {
          okText: '确认更新',
          onOk: this.handleUpdateCompleteSubmit,
          onCancel: this.handleUpdateCompleteCancel,
        };

    const printModalFooter = done
      ? { footer: null, onCancel: this.handlePrintDone }
      : { okText: '开始打印', onOk: this.handlePrintSubmit, onCancel: this.handlePrintCancel };

    const {
      singleModalVisible,
      completeModalVisible,
      updateCompleteModalVisible,
      printModalVisible,
    } = this.state;

    const getSingleModalContent = () => {
      if (selectedRows === null || selectedRows.length < 1) {
        return null;
      }
      if (done) {
        message.success('操作成功');
        this.handleSingleDone();
      }

      return (
        <Form>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('ids', {
              initialValue: selectedRows.map(item => item.id),
            })(<Input hidden />)}
          </FormItem>
          <FormItem label="作废说明" {...this.formLayout}>
            {getFieldDecorator('cancelDescription', {
              rules: [{ required: true, message: '必须填写作废说明' }],
              initialValue: null,
            })(<TextArea rows={4} />)}
          </FormItem>
        </Form>
      );
    };

    const handleReceiveTypeConvert = type => {
      switch (type) {
        case 'ALL_SEND':
          return 0;
        case 'PARTIAL_REJECT':
          return 1;
        case 'ALL_REJECT':
          return 2;
        default:
          return 0;
      }
    };

    const getUpdateCompleteModalContent = () => {
      if (selectedRowKeys === null || selectedRowKeys.length !== 1) {
        return null;
      }
      if (done) {
        message.success('操作成功');
        this.handleUpdateCompleteDone();
      }

      return (
        <Form>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('id', {
              initialValue: selectedRowKeys[0],
            })(<Input hidden />)}
          </FormItem>
          <FormItem label="回执金额" {...this.formLayout}>
            {getFieldDecorator('updateCompletePrice', {
              rules: [{ required: true, message: '必须填写回执金额' }],
              initialValue: selectedRows[0].completePrice,
            })(
              <InputNumber
                size="large"
                min={0}
                step={0.01}
                formatter={value => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                parser={value => value.replace(/\$\s?|(,*)/g, '')}
              />
            )}
          </FormItem>
          <FormItem label="接收情况" {...this.formLayout}>
            {getFieldDecorator('receiveType', {
              rules: [{ required: true, message: '必须填写接收情况' }],
              initialValue: handleReceiveTypeConvert(selectedRows[0].receiveType),
            })(
              <Radio.Group>
                <Radio value={0}>全部接收</Radio>
                <Radio value={1}>部分拒收</Radio>
                <Radio value={2}>全部拒收</Radio>
              </Radio.Group>
            )}
          </FormItem>
          <FormItem label="回执说明" {...this.formLayout}>
            {getFieldDecorator('updateCompleteDescription', {
              rules: [{ required: false, message: '选填' }],
              initialValue: selectedRows[0].completeDescription,
            })(<TextArea rows={4} />)}
          </FormItem>
        </Form>
      );
    };

    const getCompleteModalContent = () => {
      if (selectedRowKeys === null || selectedRowKeys.length !== 1) {
        return null;
      }
      if (done) {
        message.success('操作成功');
        this.handleUpdateCompleteDone();
      }

      return (
        <Form>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('id', {
              initialValue: selectedRowKeys[0],
            })(<Input hidden />)}
          </FormItem>
          <FormItem label="回执金额" {...this.formLayout}>
            {getFieldDecorator('completePrice', {
              rules: [{ required: false, message: '必须填写回执金额' }],
              initialValue: selectedRows[0].totalPrice,
            })(
              <InputNumber
                size="large"
                min={0}
                step={0.01}
                formatter={value => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                parser={value => value.replace(/\$\s?|(,*)/g, '')}
              />
            )}
          </FormItem>
          <FormItem label="接收情况" {...this.formLayout}>
            {getFieldDecorator('receiveType', {
              rules: [{ required: true, message: '必须填写接收情况' }],
              initialValue: 0,
            })(
              <Radio.Group>
                <Radio value={0}>全部接收</Radio>
                <Radio value={1}>部分拒收</Radio>
                <Radio value={2}>全部拒收</Radio>
              </Radio.Group>
            )}
          </FormItem>
          <FormItem label="回执说明" {...this.formLayout}>
            {getFieldDecorator('completeDescription', {
              rules: [{ required: false, message: '选填' }],
              initialValue: '',
            })(<TextArea rows={4} />)}
          </FormItem>
        </Form>
      );
    };

    const onDocumentLoadSuccess = document => {
      const { numPages } = document;
      this.setState({
        numPages,
      });
    };

    const getPrintModalContent = () => {
      if (selectedRows === null || selectedRows.length < 1) {
        return null;
      }
      if (done) {
        message.success('操作成功');
        this.handlePrintDone();
      }
      const { pdf } = this.props;
      const { numPages } = this.state;
      return (
        <Document file={pdf} loading="载入中，请稍等..." onLoadSuccess={onDocumentLoadSuccess}>
          {Array.from(new Array(numPages), (el, index) => (
            <Page width={900} key={`page_${index + 1}`} pageNumber={index + 1} />
          ))}
        </Document>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="订单管理"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <div className={styles.tableList}>
              <div className={styles.tableListOperator}>
                <Button icon="plus" htmlType="button" type="primary" onClick={this.handleAddOrder}>
                  新增订单
                </Button>
                <Button
                  icon="import"
                  htmlType="button"
                  type="dashed"
                  onClick={this.handleImportOrder}
                >
                  导入订单
                </Button>
                <Button icon="search" htmlType="button" onClick={this.handleResetSearch}>
                  重置查询参数
                </Button>
                {selectedRowKeys.length >= 1 &&
                  selectedRows.every(
                    row => row.orderStatus !== 'INIT' && row.orderStatus !== 'CANCEL'
                  ) && (
                    <span>
                      <Button
                        icon="printer"
                        htmlType="button"
                        type="primary"
                        onClick={this.handlePrint}
                      >
                        打印出货单
                      </Button>
                      <Button
                        icon="printer"
                        htmlType="button"
                        type="primary"
                        onClick={this.handlePrintOrigin}
                      >
                        打印原始单
                      </Button>
                    </span>
                  )}
                {selectedRowKeys.length === 1 &&
                  selectedRows.every(row =>
                    ['INIT', 'FETCH_STOCK', 'CONFIRM'].includes(row.orderStatus)
                  ) && (
                    <span>
                      <Button icon="edit" htmlType="button" type="primary" onClick={this.editOrder}>
                        修改订单
                      </Button>
                    </span>
                  )}
                {selectedRowKeys.length >= 1 &&
                  selectedRows.every(row => row.orderStatus === 'INIT') && (
                    <span>
                      <Popconfirm title="是否确认批量出库？" onConfirm={this.handleFetch}>
                        <Button
                          icon="select"
                          htmlType="button"
                          type="dashed"
                          loading={loadingFetchStockAndReturnStock}
                        >
                          批量出库
                        </Button>
                      </Popconfirm>
                    </span>
                  )}
                {selectedRowKeys.length >= 1 &&
                  selectedRows.every(
                    row => row.orderStatus === 'INIT' || row.orderStatus === 'CANCEL'
                  ) && (
                    <span>
                      <Popconfirm title="是否确认删除订单？" onConfirm={this.handleDelete}>
                        <Button icon="close" htmlType="button" type="danger">
                          删除订单
                        </Button>
                      </Popconfirm>
                    </span>
                  )}
                {selectedRowKeys.length >= 1 &&
                  selectedRows.every(row =>
                    ['FETCH_STOCK', 'GATHER_GOODS', 'CONFIRM'].includes(row.orderStatus)
                  ) && (
                    <span>
                      <Popconfirm title="是否确认批量回库？" onConfirm={this.handleReturn}>
                        <Button
                          icon="sync"
                          htmlType="button"
                          type="danger"
                          loading={loadingFetchStockAndReturnStock}
                        >
                          批量回库
                        </Button>
                      </Popconfirm>
                    </span>
                  )}
                {selectedRowKeys.length > 0 &&
                  selectedRows.every(row =>
                    ['INIT', 'FETCH_STOCK', 'GATHER_GOODS', 'CONFIRM'].includes(row.orderStatus)
                  ) && (
                    <Button
                      icon="stop"
                      htmlType="button"
                      type="danger"
                      onClick={this.showSingleModal}
                    >
                      作废订单
                    </Button>
                  )}
                {selectedRowKeys.length === 1 &&
                  selectedRows.every(row => ['CLIENT_SIGNED'].includes(row.orderStatus)) && (
                    <Button
                      icon="check"
                      htmlType="button"
                      type="danger"
                      onClick={this.showCompleteModal}
                    >
                      回执完成
                    </Button>
                  )}
                {selectedRowKeys.length === 1 &&
                  selectedRows.every(row => ['COMPLETE'].includes(row.orderStatus)) && (
                    <Button
                      icon="edit"
                      htmlType="button"
                      type="danger"
                      onClick={this.showUpdateCompleteModal}
                    >
                      更新回执信息
                    </Button>
                  )}
              </div>
              <div className={styles.tableAlert}>
                <Alert
                  message={
                    <Fragment>
                      已选择 <a style={{ fontWeight: 600 }}>{selectedRows.length}</a> 项&nbsp;&nbsp;
                      订单总价&nbsp;
                      <a style={{ fontWeight: 600 }}>
                        {accounting.formatMoney(
                          selectedRows.reduce((sum, item) => {
                            return sum + item.totalPrice;
                          }, 0),
                          '￥'
                        )}
                      </a>
                      <a onClick={this.cleanSelectedKeys} style={{ marginLeft: 24 }}>
                        清空
                      </a>
                    </Fragment>
                  }
                  type="info"
                  showIcon
                />
              </div>
              <Table
                columns={columns}
                dataSource={list}
                rowKey="id"
                loading={loading}
                pagination={paginationProps}
                onChange={this.handleTableChange}
                size="middle"
                rowSelection={rowSelectionProps}
                onRow={record => {
                  return {
                    onDoubleClick: () => {
                      this.viewOrder(record);
                    },
                    onClick: () => {
                      if (selectedRowKeys.includes(record.id)) {
                        const indexKey = selectedRowKeys.indexOf(record.id);
                        const indexRecord = selectedRows.indexOf(record);
                        if (indexKey > -1) {
                          selectedRowKeys.splice(indexKey, 1);
                        }
                        if (indexRecord > -1) {
                          selectedRows.splice(indexRecord, 1);
                        }
                      } else {
                        selectedRowKeys.push(record.id);
                        selectedRows.push(record);
                      }
                      this.setState(prevState => {
                        const newState = prevState;
                        delete newState.selectedRowKeys;
                        delete newState.selectedRows;
                        return newState;
                      });
                      this.setState({
                        selectedRowKeys,
                        selectedRows,
                      });
                    },
                  };
                }}
              />
            </div>
            <BackTop />
          </Card>
        </div>
        <Modal
          title="作废订单"
          width={640}
          destroyOnClose
          visible={singleModalVisible}
          {...singleModalFooter}
        >
          {getSingleModalContent()}
        </Modal>
        <Modal
          title="回执完成"
          width={640}
          destroyOnClose
          visible={completeModalVisible}
          {...completeModalFooter}
        >
          {getCompleteModalContent()}
        </Modal>
        <Modal
          title="更新回执信息"
          width={640}
          destroyOnClose
          visible={updateCompleteModalVisible}
          {...updateCompleteModalFooter}
        >
          {getUpdateCompleteModalContent()}
        </Modal>
        <Modal
          title="打印订单"
          width={1000}
          destroyOnClose
          visible={printModalVisible}
          {...printModalFooter}
        >
          {getPrintModalContent()}
        </Modal>
      </PageHeaderWrapper>
    );
  }
}

export default Order;
