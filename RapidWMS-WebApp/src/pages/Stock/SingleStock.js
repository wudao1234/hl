import React, { Fragment, PureComponent } from 'react';
import { connect } from 'dva';
import {
  Alert,
  Button,
  Card,
  Form,
  Input,
  InputNumber,
  message,
  Modal,
  notification,
  Table,
  Tag,
  Cascader,
  Popconfirm,
  DatePicker,
} from 'antd';
import accounting from 'accounting';

import Highlighter from 'react-highlight-words';

import moment from 'moment';
import FormItem from 'antd/es/form/FormItem';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import styles from './Stock.less';

const { Search } = Input;

const initialSortState = {
  sortGoods: null,
  sortWarePosition: null,
  sortWareZone: null,
  sortQuantity: null,
  sortGoodsType: null,
  sortPrice: null,
  sortExpireDate: null,
  sortWarranty: null,
  sortPackCount: null,
  sortCustomer: null,
  quantityGuarantee: null,
};

const initialModalState = {
  singleModalVisible: false,
  singleType: null,
  multipleModalVisible: false,
  multipleType: null,
  done: false,
};

const initialState = {
  currentPage: 1,
  pageSize: 10,
  orderBy: null,
  search: null,
  quantityGuaranteeSearch: null,
  wareZoneFilter: null,
  customerFilter: null,
  goodsTypeFilter: null,
  isActiveFilter: null,
  selectedRowKeys: [],
  selectedRows: [],
  ...initialSortState,
  ...initialModalState,
};

@connect(({ stock, wareZone, customer, goodsType, loading }) => ({
  list: stock.list.content,
  total: stock.list.totalElements,
  wareZoneList: wareZone.allList,
  wareZoneTree: wareZone.tree,
  customerList: customer.allList,
  goodsTypeList: goodsType.allList,
  loading:
    loading.models.stock &&
    loading.models.wareZone &&
    loading.models.customer &&
    loading.models.goodsType,
}))
@Form.create()
class Stock extends PureComponent {
  state = initialState;

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    const {
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch,
    } = this.state;
    this.handleQuery(
      dispatch,
      false,
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch
    );
    dispatch({
      type: 'wareZone/fetchAll',
    });
    dispatch({
      type: 'wareZone/fetchTree',
    });
    dispatch({
      type: 'customer/fetchMy',
    });
    dispatch({
      type: 'goodsType/fetchAll',
    });
  }

  handleResetSearch = () => {
    this.setState(initialState, () => {
      const { dispatch } = this.props;
      const { pageSize, currentPage } = this.state;
      this.handleQuery(dispatch, false, null, pageSize, currentPage, null, null, null, null, null);
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
    if (customerList) {
      customerList.map(customer => {
        return customerFilters.push({ text: customer.name, value: customer.id });
      });
    }
    return customerFilters;
  };

  handleGoodsTypeFilters = () => {
    const { goodsTypeList } = this.props;
    const goodsTypeFilters = [];
    if (goodsTypeList !== null && goodsTypeList !== undefined) {
      goodsTypeList.map(goodsType => {
        return goodsTypeFilters.push({ text: goodsType.name, value: goodsType.id });
      });
    }
    return goodsTypeFilters;
  };

  handleIsActiveFilters = () => {
    const isActiveFilters = [];
    isActiveFilters.push({ text: '可用', value: true });
    isActiveFilters.push({ text: '冻结', value: false });
    return isActiveFilters;
  };

  handleSearchChange = e => {
    this.setState({
      search: e.target.value,
    });
  };

  handleSearchChange2 = e => {
    this.setState({
      quantityGuaranteeSearch: e.target.value,
    });
  };

  handleSearch = () => {
    const { dispatch } = this.props;
    const {
      pageSize,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
    } = this.state;
    let { search, quantityGuaranteeSearch } = this.state;
    search = search === '' ? '' : search;
    quantityGuaranteeSearch = quantityGuaranteeSearch === '' ? '' : quantityGuaranteeSearch;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.cleanSelectedKeys();
    this.handleQuery(
      dispatch,
      false,
      search,
      pageSize,
      1,
      null,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch
    );
  };

  handleQuery = (
    dispatch,
    exportExcel,
    search,
    pageSize,
    currentPage,
    orderBy,
    wareZoneFilter,
    customerFilter,
    goodsTypeFilter,
    isActiveFilter,
    quantityGuaranteeSearch
  ) => {
    dispatch({
      type: 'stock/singleFetch',
      payload: {
        exportExcel,
        search,
        pageSize,
        currentPage,
        orderBy,
        wareZoneFilter,
        customerFilter,
        goodsTypeFilter,
        isActiveFilter,
        quantityGuaranteeSearch,
      },
    });
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search, quantityGuaranteeSearch } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const {
      'warePosition.wareZone.name': wareZoneFilter = null,
      'goods.customer.name': customerFilter = null,
      'goods.goodsType.name': goodsTypeFilter = null,
      isActive: isActiveFilter = null,
    } = filters;
    const orderBy = field !== undefined ? `${field},${order}` : null;

    let sortOrders;
    switch (field) {
      case 'goods.name':
        sortOrders = { ...initialSortState, sortGoods: order };
        break;
      case 'warePosition.name':
        sortOrders = { ...initialSortState, sortWarePosition: order };
        break;
      case 'warePosition.wareZone.name':
        sortOrders = { ...initialSortState, sortWareZone: order };
        break;
      case 'quantity':
        sortOrders = { ...initialSortState, sortQuantity: order };
        break;
      case 'goods.goodsType.name':
        sortOrders = { ...initialSortState, sortGoodsType: order };
        break;
      case 'goods.price':
        sortOrders = { ...initialSortState, sortPrice: order };
        break;
      case 'expireDate':
        sortOrders = { ...initialSortState, sortExpireDate: order };
        break;
      case 'goods.monthsOfWarranty':
        sortOrders = { ...initialSortState, sortWarranty: order };
        break;
      case 'goods.packCount':
        sortOrders = { ...initialSortState, sortPackCount: order };
        break;
      case 'goods.customer.name':
        sortOrders = { ...initialSortState, sortCustomer: order };
        break;
      case 'quantityGuarantee':
        sortOrders = { ...initialSortState, quantityGuarantee: order };
        break;
      default:
        sortOrders = initialSortState;
    }

    this.setState({
      currentPage,
      pageSize,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      ...sortOrders,
    });
    this.cleanSelectedKeys();
    this.handleQuery(
      dispatch,
      false,
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch
    );
  };

  handleStockList = list => {
    if (!list) {
      return null;
    }
    return list.map(item => {
      return { ...item, customerName: item.customer ? item.customer.name : null };
    });
  };

  handleSelectRows = (selectedRowKeys, selectedRows) => {
    this.setState({
      selectedRowKeys,
      selectedRows,
    });
  };

  cleanSelectedKeys = () => {
    this.setState({
      selectedRowKeys: [],
      selectedRows: [],
    });
  };

  handleActivate = () => {
    this.handleActivateByValue(true);
  };

  handleDeActivate = () => {
    this.handleActivateByValue(false);
  };

  handleActivateByValue = value => {
    const { selectedRowKeys } = this.state;
    const { dispatch } = this.props;
    const {
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch,
    } = this.state;
    dispatch({
      type: 'stock/activate',
      payload: { selectedRowKeys, isActive: value },
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('修改成功！');
          this.handleQuery(
            dispatch,
            false,
            search,
            pageSize,
            currentPage,
            orderBy,
            wareZoneFilter,
            customerFilter,
            goodsTypeFilter,
            isActiveFilter,
            quantityGuaranteeSearch
          );
        }
      },
    });
    this.setState({
      selectedRows: [],
      selectedRowKeys: [],
    });
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

    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleSingleDone();
      dispatch({
        type: 'stock/singleOperate',
        payload: fieldsValue,
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success('操作成功！');
            const {
              search,
              pageSize,
              currentPage,
              orderBy,
              wareZoneFilter,
              customerFilter,
              goodsTypeFilter,
              isActiveFilter,
              quantityGuaranteeSearch,
            } = this.state;
            this.cleanSelectedKeys();
            this.handleQuery(
              dispatch,
              false,
              search,
              pageSize,
              currentPage,
              orderBy,
              wareZoneFilter,
              customerFilter,
              goodsTypeFilter,
              isActiveFilter,
              quantityGuaranteeSearch
            );
          }
        },
      });
    });
  };

  handleSingleMove = () => {
    this.setState({
      singleType: 'move',
    });
    this.showSingleModal();
  };

  handleSingleIncrease = () => {
    this.setState({
      singleType: 'increase',
    });
    this.showSingleModal();
  };

  handleSingleDecrease = () => {
    this.setState({
      singleType: 'decrease',
    });
    this.showSingleModal();
  };

  handleSingleChangeExpireDate = () => {
    this.setState({
      singleType: 'expireDate',
    });
    this.showSingleModal();
  };

  showMultipleModal = () => {
    this.setState({
      multipleModalVisible: true,
    });
  };

  handleMultipleDone = () => {
    this.setState({
      done: false,
      multipleModalVisible: false,
    });
  };

  handleMultipleCancel = () => {
    this.setState({
      multipleModalVisible: false,
    });
  };

  handleMultipleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;

    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleMultipleDone();
      dispatch({
        type: 'stock/multipleOperate',
        payload: fieldsValue,
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success('操作成功！');
            const {
              search,
              pageSize,
              currentPage,
              orderBy,
              wareZoneFilter,
              customerFilter,
              goodsTypeFilter,
              isActiveFilter,
              quantityGuaranteeSearch,
            } = this.state;
            this.cleanSelectedKeys();
            this.handleQuery(
              dispatch,
              false,
              search,
              pageSize,
              currentPage,
              orderBy,
              wareZoneFilter,
              customerFilter,
              goodsTypeFilter,
              isActiveFilter,
              quantityGuaranteeSearch
            );
          }
        },
      });
    });
  };

  handleMultipleMove = () => {
    this.setState({
      multipleType: 'move',
    });
    this.showMultipleModal();
  };

  handleMultipleDecrease = () => {
    this.setState({
      multipleType: 'decrease',
    });
    this.showMultipleModal();
  };

  getWarePositionOptions = () => {
    const { wareZoneTree } = this.props;
    if (wareZoneTree !== null && wareZoneTree !== undefined) {
      const options = [];
      wareZoneTree.forEach(zone => {
        const children = [];
        zone.warePositions.forEach(position => {
          children.push({
            value: position.id,
            label: position.name,
          });
        });
        options.push({
          value: zone.id,
          label: zone.name,
          children,
        });
      });
      return options;
    }
    return [];
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const {
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch,
    } = this.state;
    this.handleQuery(
      dispatch,
      true,
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch
    );
  };

  render() {
    const { list, total, loading } = this.props;
    const { pageSize, currentPage } = this.state;
    const { search, quantityGuaranteeSearch } = this.state;
    const { selectedRowKeys, selectedRows } = this.state;
    const { customerFilter, goodsTypeFilter } = this.state;
    const {
      form: { getFieldDecorator },
    } = this.props;

    const {
      sortGoods,
      sortQuantity,
      sortGoodsType,
      sortPrice,
      sortWarranty,
      sortPackCount,
      sortCustomer,
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

    const { done } = this.state;

    const searchContent = (
      <div className={styles.extraContent}>
        <Search
          value={search}
          className={styles.extraContentSearch}
          placeholder="商品名, 条码,质保指数"
          onChange={this.handleSearchChange}
          onSearch={this.handleSearch}
        />
        <Search
          value={quantityGuaranteeSearch}
          className={styles.extraContentSearch}
          placeholder="质保指数"
          onChange={this.handleSearchChange2}
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

    const rowSelectionProps = {
      onChange: this.handleSelectRows,
      selectedRowKeys,
      selectedRows,
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
        title: '商品名称',
        dataIndex: 'goods.name',
        key: 'goods.name',
        width: '38%',
        sorter: true,
        sortOrder: sortGoods,
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
        title: '存量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '6%',
        align: 'right',
        sorter: true,
        sortOrder: sortQuantity,
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
        width: '10%',
        align: 'center',
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
        title: '价格',
        dataIndex: 'goods.price',
        key: 'goods.price',
        width: '6%',
        align: 'right',
        sorter: true,
        sortOrder: sortPrice,
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
        width: '6%',
        align: 'right',
        sorter: true,
        sortOrder: sortWarranty,
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
        width: '6%',
        align: 'right',
        sorter: true,
        sortOrder: sortPackCount,
        render: text => {
          return <Tag color="#2db7f5">{text}</Tag>;
        },
      },
      {
        title: '单位',
        dataIndex: 'goods.unit',
        key: 'goods.unit',
        width: '3%',
        align: 'center',
      },
      {
        title: '类别',
        dataIndex: 'goods.goodsType.name',
        key: 'goods.goodsType.name',
        width: '8%',
        sorter: true,
        sortOrder: sortGoodsType,
        filters: this.handleGoodsTypeFilters(),
        filteredValue: goodsTypeFilter,
      },
      {
        title: '客户',
        dataIndex: 'goods.customer.shortNameCn',
        key: 'goods.customer.name',
        width: '16%',
        sorter: true,
        sortOrder: sortCustomer,
        filters: this.handleCustomerFilters(),
        filteredValue: customerFilter,
      },
    ];

    const singleModalFooter = done
      ? { footer: null, onCancel: this.handleSingleDone }
      : { okText: '更新', onOk: this.handleSingleSubmit, onCancel: this.handleSingleCancel };

    const multipleModalFooter = done
      ? { footer: null, onCancel: this.handleMultipleDone }
      : { okText: '更新', onOk: this.handleMultipleSubmit, onCancel: this.handleMultipleCancel };

    const { singleModalVisible, multipleModalVisible, singleType, multipleType } = this.state;

    const getSingleModalContent = () => {
      if (selectedRows === null || selectedRows.length < 1) {
        return null;
      }
      const currentItem = selectedRows[0];
      if (done) {
        message.success('操作成功');
        this.handleSingleDone();
      }
      let label;
      let max;
      let msg;
      let initialValue;
      let editExpireDate = false;
      switch (singleType) {
        case 'move':
          label = '移库数量';
          max = currentItem.quantity;
          initialValue = max;
          msg = `数量不得大于${max}`;
          break;
        case 'add':
          label = '新增数量';
          max = 9999999999;
          initialValue = 1;
          msg = `请输入准确的数字`;
          break;
        case 'increase':
          label = '盘盈数量';
          max = 9999999999;
          initialValue = 1;
          msg = `请输入准确的数字`;
          break;
        case 'decrease':
          label = '盘亏数量';
          max = currentItem.quantity;
          initialValue = max;
          msg = `数量不得小于0，大于${max}`;
          break;
        case 'expireDate':
          label = '商品数量';
          max = currentItem.quantity;
          initialValue = currentItem.quantity;
          msg = `数量不得小于0，大于${max}`;
          editExpireDate = true;
          break;
        default:
          return null;
      }

      const options = this.getWarePositionOptions();

      return (
        <Form>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('id', {
              initialValue: currentItem.id,
            })(<Input hidden />)}
          </FormItem>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('operate', {
              initialValue: singleType,
            })(<Input hidden />)}
          </FormItem>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('originWarePosition', {
              initialValue: currentItem.warePosition.id,
            })(<Input hidden />)}
          </FormItem>
          <FormItem label="商品名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              initialValue: currentItem.goods.name,
            })(<Input disabled />)}
          </FormItem>
          <FormItem label={label} {...this.formLayout} hasFeedback>
            {getFieldDecorator('quantity', {
              rules: [{ type: 'number', required: true, min: 1, max, message: msg }],
              initialValue,
            })(<InputNumber size="large" />)}
          </FormItem>
          <FormItem label="目标库位" {...this.formLayout} hasFeedback>
            {getFieldDecorator('warePosition', {
              rules: [{ required: true, message: '选择或输入目标库位' }],
              initialValue: [currentItem.warePosition.wareZone.id, currentItem.warePosition.id],
            })(
              <Cascader
                disabled={singleType !== 'move'}
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                size="large"
                expandTrigger="hover"
                options={options}
                placeholder="选择或输入目标库位"
              />
            )}
          </FormItem>
          <FormItem label="质保日期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('expireDate', {
              rules: [{ required: true, message: '请输入质保过期日期' }],
              initialValue: currentItem.expireDate
                ? moment(new Date(currentItem.expireDate))
                : null,
            })(<DatePicker disabled={!editExpireDate} />)}
          </FormItem>
          <FormItem label="备注" {...this.formLayout} hasFeedback>
            {getFieldDecorator('description')(<Input disabled={editExpireDate} />)}
          </FormItem>
        </Form>
      );
    };

    const getMultipleModalContent = () => {
      if (selectedRows === null || selectedRows.length < 2) {
        return null;
      }
      if (done) {
        message.success('操作成功');
        this.handleMultipleDone();
      }
      const totalCount = selectedRows.reduce((sum, item) => {
        return sum + item.quantity;
      }, 0);
      const options = this.getWarePositionOptions();

      return (
        <Form>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('ids', {
              initialValue: selectedRows.map(item => item.id),
            })(<Input hidden />)}
          </FormItem>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('operate', {
              initialValue: multipleType,
            })(<Input hidden />)}
          </FormItem>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('quantity', {
              initialValue: selectedRows.map(item => item.quantity),
            })(<Input hidden />)}
          </FormItem>
          <FormItem {...this.formLayout}>
            {getFieldDecorator('originWarePosition', {
              initialValue: selectedRows.map(item => item.warePosition.id),
            })(<Input hidden />)}
          </FormItem>
          <FormItem label="总数量" {...this.formLayout}>
            {getFieldDecorator('totalCount', {
              initialValue: totalCount,
            })(<InputNumber disabled size="large" />)}
          </FormItem>
          {multipleType === 'move' ? (
            <FormItem label="目标库位" {...this.formLayout} hasFeedback>
              {getFieldDecorator('warePosition', {
                rules: [{ required: true, message: '选择或输入目标库位' }],
              })(
                <Cascader
                  showSearch
                  size="large"
                  expandTrigger="hover"
                  options={options}
                  placeholder="选择或输入目标库位"
                />
              )}
            </FormItem>
          ) : (
            ''
          )}
          <FormItem label="备注" {...this.formLayout} hasFeedback>
            {getFieldDecorator('description')(<Input />)}
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="实时库存"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <div className={styles.tableList}>
              <div className={styles.tableListOperator}>
                <Button icon="search" htmlType="button" onClick={this.handleResetSearch}>
                  重置查询参数
                </Button>
                {selectedRowKeys.length === 1 && (
                  <span>
                    <Button
                      icon="right-circle"
                      htmlType="button"
                      type="dashed"
                      onClick={this.handleSingleMove}
                    >
                      单品移库
                    </Button>
                    <Button
                      icon="up-circle"
                      htmlType="button"
                      type="primary"
                      onClick={this.handleSingleIncrease}
                    >
                      单品盘盈
                    </Button>
                    <Button
                      icon="down-circle"
                      htmlType="button"
                      type="danger"
                      onClick={this.handleSingleDecrease}
                    >
                      单品盘亏
                    </Button>
                    <Button
                      icon="compass"
                      htmlType="button"
                      type="primary"
                      onClick={this.handleSingleChangeExpireDate}
                    >
                      修改质保日期
                    </Button>
                  </span>
                )}
                {selectedRowKeys.length > 1 && (
                  <span>
                    <Button
                      icon="swap"
                      htmlType="button"
                      type="dashed"
                      onClick={this.handleMultipleMove}
                    >
                      整体移库
                    </Button>
                    <Button
                      icon="retweet"
                      htmlType="button"
                      type="danger"
                      onClick={this.handleMultipleDecrease}
                    >
                      整体盘亏
                    </Button>
                  </span>
                )}
                {selectedRowKeys.length > 0 && (
                  <span>
                    <Popconfirm title="是否确认冻结操作？" onConfirm={this.handleDeActivate}>
                      <Button icon="stop" htmlType="button" type="danger">
                        冻结
                      </Button>
                    </Popconfirm>
                    <Popconfirm title="是否确认解冻操作？" onConfirm={this.handleActivate}>
                      <Button icon="check-circle" htmlType="button" type="primary">
                        取消冻结
                      </Button>
                    </Popconfirm>
                  </span>
                )}
              </div>
              <div className={styles.tableAlert}>
                <Alert
                  message={
                    <Fragment>
                      已选择 <a style={{ fontWeight: 600 }}>{selectedRows.length}</a> 项&nbsp;&nbsp;
                      商品总数&nbsp;
                      <a style={{ fontWeight: 600 }}>
                        {selectedRows.reduce((sum, item) => {
                          return sum + item.quantity;
                        }, 0)}
                      </a>{' '}
                      项&nbsp;&nbsp; 商品总价&nbsp;
                      <a style={{ fontWeight: 600 }}>
                        {accounting.formatMoney(
                          selectedRows.reduce((sum, item) => {
                            return sum + item.goods.price * item.quantity;
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
                dataSource={this.handleStockList(list)}
                rowKey="id"
                loading={loading}
                pagination={paginationProps}
                onChange={this.handleTableChange}
                rowSelection={rowSelectionProps}
                size="middle"
              />
            </div>
          </Card>
        </div>
        <Modal
          title="单个库位操作"
          width={640}
          destroyOnClose
          visible={singleModalVisible}
          {...singleModalFooter}
        >
          {getSingleModalContent()}
        </Modal>
        <Modal
          title="批量库位操作"
          width={640}
          destroyOnClose
          visible={multipleModalVisible}
          {...multipleModalFooter}
        >
          {getMultipleModalContent()}
        </Modal>
      </PageHeaderWrapper>
    );
  }
}

export default Stock;
