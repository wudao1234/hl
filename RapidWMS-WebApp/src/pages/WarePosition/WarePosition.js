import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import {
  Button,
  Card,
  Form,
  Input,
  InputNumber,
  message,
  Modal,
  notification,
  Popconfirm,
  Select,
  Table,
  Tag,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './WarePosition.less';

const FormItem = Form.Item;
const { Search } = Input;
const { Option } = Select;

@connect(({ warePosition, wareZone, loading }) => ({
  list: warePosition.list.content,
  total: warePosition.list.totalElements,
  wareZoneList: wareZone.allList,
  loading: loading.models.warePosition && loading.models.wareZone,
}))
@Form.create()
class WarePosition extends PureComponent {
  state = {
    currentPage: 1,
    pageSize: 10,
    orderBy: null,
    search: null,
    wareZoneFilter: null,
    visible: false,
    done: false,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, wareZoneFilter } = this.state;
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy, wareZoneFilter);
    dispatch({
      type: 'wareZone/fetchAll',
    });
  }

  handleWareZoneFilters = () => {
    const { wareZoneList } = this.props;
    const wareZoneFilters = [];
    if (wareZoneList !== null && wareZoneList !== undefined) {
      wareZoneList.map(wareZone => {
        return wareZoneFilters.push({ text: wareZone.name, value: wareZone.id });
      });
    }
    return wareZoneFilters;
  };

  handleSearchByName = value => {
    this.setState({ search: value });
    const search = value === '' ? '' : value;
    const { dispatch } = this.props;
    const { pageSize, wareZoneFilter } = this.state;
    this.setState({
      currentPage: 1,
      orderBy: null,
    });
    this.handleQuery(dispatch, false, search, pageSize, 1, null, wareZoneFilter);
  };

  handleQuery = (dispatch, exportExcel, search, pageSize, currentPage, orderBy, wareZoneFilter) => {
    dispatch({
      type: 'warePosition/fetch',
      payload: { exportExcel, search, pageSize, currentPage, orderBy, wareZoneFilter },
    });
  };

  showModal = () => {
    this.setState({
      visible: true,
      currentItem: undefined,
    });
  };

  showEditModal = item => {
    this.setState({
      visible: true,
      currentItem: item,
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
      dispatch({
        type: 'warePosition/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建成功！' : '修改成功！');
            const { search, pageSize, currentPage, orderBy, wareZoneFilter } = this.state;
            this.handleQuery(
              dispatch,
              false,
              search,
              pageSize,
              currentPage,
              orderBy,
              wareZoneFilter
            );
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
      type: 'warePosition/submit',
      payload: { id },
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('删除成功！');
          const { search, pageSize, currentPage, orderBy, wareZoneFilter } = this.state;
          this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy, wareZoneFilter);
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
    const { 'wareZone.name': wareZoneFilter = null } = filters;
    this.setState({
      currentPage,
      pageSize,
      orderBy,
      wareZoneFilter,
    });
    this.handleQuery(dispatch, false, search, pageSize, currentPage, orderBy, wareZoneFilter);
  };

  handleExportExcel = () => {
    const { dispatch } = this.props;
    const { search, pageSize, currentPage, orderBy, wareZoneFilter } = this.state;
    this.handleQuery(dispatch, true, search, pageSize, currentPage, orderBy, wareZoneFilter);
  };

  render() {
    const { list, total, wareZoneList, loading } = this.props;
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
          className={styles.extraContentSearch}
          placeholder="库位名称"
          onSearch={this.handleSearchByName}
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

    const getWareZoneOptions = allWareZones => {
      const children = [];
      if (Array.isArray(allWareZones)) {
        allWareZones.forEach(wareZone => {
          children.push(
            <Option key={wareZone.id} value={wareZone.id}>
              {wareZone.name}
            </Option>
          );
        });
      }
      return children;
    };

    const getCurentWareZone = item => {
      if (item !== undefined && item !== null && item.wareZone) {
        return item.wareZone.id;
      }
      return undefined;
    };

    const getModalContent = () => {
      if (done) {
        message.success('保存成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="库位名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入库位名称' }],
              initialValue: currentItem.name,
            })(<Input placeholder="请输入库位名称" />)}
          </FormItem>
          <FormItem label="所属库区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('wareZone', {
              rules: [{ required: true, message: '请选择所属库区' }],
              initialValue: getCurentWareZone(currentItem),
            })(
              <Select
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="请选择所属库区"
                style={{ width: '100%' }}
              >
                {getWareZoneOptions(wareZoneList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="排序" {...this.formLayout} hasFeedback>
            {getFieldDecorator('sortOrder', {
              rules: [{ required: true, message: '请输入排序' }],
              initialValue: currentItem.sortOrder,
            })(<InputNumber placeholder="请输入排序" />)}
          </FormItem>
          <FormItem label="说明" {...this.formLayout}>
            {getFieldDecorator('description', {
              initialValue: currentItem.description,
            })(<Input placeholder="说明" />)}
          </FormItem>
        </Form>
      );
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
        title: '库位名称',
        dataIndex: 'name',
        key: 'name',
        width: '15%',
        sorter: true,
        render: (text, row) => {
          return (
            <a
              href="#"
              onClick={e => {
                e.preventDefault();
                this.showEditModal(row);
              }}
            >
              {text}
            </a>
          );
        },
      },
      {
        title: '库存数量',
        dataIndex: 'stockCount',
        key: 'stockCount',
        width: '3%',
        align: 'right',
        render: text => {
          if (text === 0) {
            return <Tag color="green">{text}</Tag>;
          }
          return <Tag color="red">{text}</Tag>;
        },
      },
      {
        title: '所属库位',
        dataIndex: 'wareZone.name',
        key: 'wareZone.name',
        width: '10%',
        align: 'center',
        filters: this.handleWareZoneFilters(),
      },
      {
        title: '排序',
        dataIndex: 'sortOrder',
        key: 'sortOrder',
        width: '8%',
        align: 'center',
        sorter: true,
      },
      {
        title: '说明',
        dataIndex: 'description',
        key: 'description',
        width: '15%',
        align: 'center',
      },
      {
        title: '操作',
        width: '15%',
        align: 'right',
        render: (text, row) => {
          return (
            <span className={styles.buttons}>
              <Button
                size="small"
                htmlType="button"
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
                <Button size="small" htmlType="button" href="#" type="danger">
                  删除
                </Button>
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
            title="库位管理"
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
              创建新库位
            </Button>
            <Table
              columns={columns}
              dataSource={list}
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
              onChange={this.handleTableChange}
              size="middle"
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

export default WarePosition;
