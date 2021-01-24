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

const FormItem = Form.Item;
const { Search } = Input;

@connect(({ logisticsDetail, loading }) => ({
  list: logisticsDetail.list.content,
  total: logisticsDetail.list.totalElements,
  loading: loading.models.logisticsDetail,
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
      </PageHeaderWrapper>
    );
  }
}

export default LogisticsDetail;
