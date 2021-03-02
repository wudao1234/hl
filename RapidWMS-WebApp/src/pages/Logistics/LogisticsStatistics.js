import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { Card, Form, Input, Table, DatePicker } from 'antd';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import styles from '../Common.less';

const { Search } = Input;
const { RangePicker } = DatePicker;

@connect(({ logisticsDetail, loading }) => ({
  list: logisticsDetail.list.content,
  total: logisticsDetail.list.totalElements,
  loading: loading.models.logisticsDetail,
}))
@Form.create()
class LogisticsStatistics extends PureComponent {
  state = {
    currentPage: 1,
    pageSize: 10,
    orderBy: null,
    search: null,
    startDate: null,
    endDate: null,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  columns = [
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
      width: '15%',
    },
    {
      title: '金额',
      dataIndex: 'totalPrice',
      key: 'totalPrice',
      width: '10%',
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, startDate, endDate } = this.state;
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, currentPage, orderBy);
  }

  handleSearchByName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, startDate, endDate } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, 1, null);
  };

  handleQuery = (dispatch, search, startDate, endDate, pageSize, currentPage, orderBy) => {
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
      type: 'logisticsDetail/static',
      payload: {
        search,
        startDate: startDateString,
        endDate: endDateString,
        pageSize,
        currentPage,
        orderBy,
      },
    });
  };

  handleTotal = (total, range) => {
    return `总共${total}条数据，当前为${range[0]}-${range[1]}条`;
  };

  handleTableChange = (pagination, filters, sorter) => {
    const { dispatch } = this.props;
    const { search, startDate, endDate } = this.state;
    const { current: currentPage, pageSize } = pagination;
    const { field, order } = sorter;
    const orderBy = field !== undefined ? `${field},${order}` : null;
    this.setState({
      currentPage,
      pageSize,
      orderBy,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, currentPage, orderBy);
  };

  handleDateRangeChange = date => {
    const startDate = date[0];
    const endDate = date[1];
    this.setState({
      startDate,
      endDate,
    });
    const { dispatch } = this.props;
    const { pageSize, search } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, search, startDate, endDate, pageSize, 1, null);
  };

  render() {
    const { list, total, loading } = this.props;
    const { startDate, endDate } = this.state;
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
          className={styles.extraContentSearch}
          placeholder="请输入姓名进行搜索"
          onSearch={this.handleSearchByName}
        />
        <RangePicker
          style={{ marginLeft: 10, marginRight: 10 }}
          onChange={this.handleDateRangeChange}
          value={[startDate, endDate]}
        />
      </div>
    );

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="物流统计"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={searchContent}
          >
            <Table
              columns={this.columns}
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

export default LogisticsStatistics;
