import React, { PureComponent } from 'react';
import router from 'umi/router';
import {
  Button,
  Card,
  Col,
  Form,
  Input,
  InputNumber,
  message,
  Modal,
  notification,
  Popconfirm,
  Row,
  Select,
  Steps,
  Table,
  Tag,
} from 'antd';
import accounting from 'accounting';
import moment from 'moment';
import { connect } from 'dva';
import styles from './Pack.less';

const FormItem = Form.Item;
const { Option } = Select;
const { Step } = Steps;
const intformat = require('biguint-format');
const FlakeId = require('flake-idgen');

const flakeIdGen1 = new FlakeId();

@connect(({ customer, address }) => ({
  customerList: customer.allList,
  addressList: address.allList,
}))
@Form.create()
class AssignPackForm extends PureComponent {
  state = {
    packId: null,
    maxNumber: 0,
    customerFilter: null,
    packDescription: null,
    packType: null,
    packages: null,
    trackingNumber: null,
    address: null,
    packStatus: null,
    stockFlows: [],
    packItems: [],
    selectedStockFlow: {},
    singleModalVisible: false,
    done: false,
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
    const { pack, stockFlows, loading } = nextProps;
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
        maxNumber: pack.packages,
        customerFilter: pack.customer.id,
        packDescription: pack.description,
        packType: result,
        packages: pack.packages,
        trackingNumber: pack.trackingNumber,
        address: pack.address,
        packStatus: pack.packStatus,
        packItems: pack.packItems,
      });
    }
    if (stockFlows !== null && stockFlows !== undefined && loading) {
      this.setState({
        stockFlows: pack.packItems !== undefined && pack.packItems.length > 0 ? [] : stockFlows,
      });
    }
  }

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
    const { form } = this.props;
    const { packItems, packId, selectedStockFlow, stockFlows } = this.state;

    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleSingleDone();
      const newItem = {
        id: intformat(flakeIdGen1.next(), 'dec'),
        pack: { id: packId },
        number: fieldsValue.number,
        quantity: fieldsValue.quantity,
        name: selectedStockFlow.name,
        sn: selectedStockFlow.sn,
        expireDate: selectedStockFlow.expireDate,
      };
      let findPackItem = false;
      for (let i = 0; i < packItems.length; i += 1) {
        if (
          packItems[i].sn === newItem.sn &&
          packItems[i].expireDate === newItem.expireDate &&
          packItems[i].number === newItem.number
        ) {
          packItems[i] = { ...packItems[i], quantity: packItems[i].quantity + newItem.quantity };
          findPackItem = true;
          break;
        }
      }
      for (let i = 0; i < stockFlows.length; i += 1) {
        if (stockFlows[i].id === selectedStockFlow.id) {
          if (fieldsValue.quantity >= stockFlows[i].quantity) {
            stockFlows.splice(i, 1);
            break;
          }
          if (fieldsValue.quantity < stockFlows[i].quantity) {
            const updateItem = stockFlows[i];
            updateItem.quantity = stockFlows[i].quantity - fieldsValue.quantity;
            stockFlows[i] = updateItem;
            break;
          }
        }
      }
      if (findPackItem) {
        this.setState({
          packItems,
          stockFlows,
        });
      } else {
        this.setState({
          packItems: [...packItems, newItem],
          stockFlows,
        });
      }
    });
  };

  handleRemovePackItem = itemRemove => {
    const { packItems, stockFlows } = this.state;
    const newPackItems = packItems.filter(
      item => item.id !== itemRemove.id || item.number !== itemRemove.number
    );
    let findItem = false;
    for (let i = 0; i < stockFlows.length; i += 1) {
      if (
        stockFlows[i].sn === itemRemove.sn &&
        stockFlows[i].expireDate === itemRemove.expireDate
      ) {
        stockFlows[i] = {
          ...stockFlows[i],
          quantity: stockFlows[i].quantity + itemRemove.quantity,
        };
        findItem = true;
        break;
      }
    }
    if (!findItem) {
      this.setState({
        stockFlows: [...stockFlows, itemRemove],
        packItems: newPackItems,
      });
    } else {
      this.setState({
        stockFlows,
        packItems: newPackItems,
      });
    }
  };

  render() {
    const {
      dispatch,
      form: { getFieldDecorator },
      customerList,
      addressList,
      isEdit,
      queryParams,
    } = this.props;

    const { packItems = [], stockFlows = [] } = this.state;

    const {
      packId,
      maxNumber,
      customerFilter,
      packDescription,
      packType,
      packages,
      trackingNumber,
      address,
      packStatus,
      singleModalVisible,
      done,
      selectedStockFlow,
    } = this.state;

    const handleSelectCustomer = value => {
      if (!isEdit) {
        this.setState({
          customerFilter: value,
        });
        dispatch({
          type: 'order/fetchNone',
        });
      }
    };

    const singleModalFooter = done
      ? { footer: null, onCancel: this.handleSingleDone }
      : { okText: '添加', onOk: this.handleSingleSubmit, onCancel: this.handleSingleCancel };

    const handleAddItem = item => {
      this.setState({
        selectedStockFlow: item,
        singleModalVisible: true,
      });
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

    const columns = [
      {
        title: '#',
        width: '1%',
        key: 'index',
        render: (text, record, index) => {
          return `${index + 1}`;
        },
      },
      {
        title: '商品名',
        dataIndex: 'name',
        key: 'name',
      },
      {
        title: '商品条码',
        dataIndex: 'sn',
        key: 'sn',
      },
      {
        title: '保质日期',
        dataIndex: 'expireDate',
        key: 'expireDate',
        width: '5%',
        render: text => {
          return <Tag>{moment(text).format('YYYY-MM-DD')}</Tag>;
        },
      },
      {
        title: '数量',
        dataIndex: 'quantity',
        key: 'quantity',
        width: '5%',
        align: 'right',
        render: text => {
          return <Tag color="red">{accounting.formatNumber(text)}</Tag>;
        },
      },
    ];

    const stockFlowOperateColumn = [
      ...columns,
      {
        title: '操作',
        width: '5%',
        align: 'right',
        render: (text, row) => {
          return (
            <Button
              htmlType="button"
              size="small"
              type="primary"
              onClick={e => {
                e.preventDefault();
                handleAddItem(row);
              }}
            >
              添加
            </Button>
          );
        },
      },
    ];

    const packItemColumns = [
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
                onConfirm={() => this.handleRemovePackItem(record)}
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
      dispatch({
        type: 'pack/package',
        payload: { id: packId, packItems },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(isEdit ? '修改商品分包成功！' : '商品分包成功！');
            handleGoBackToList();
          }
        },
      });
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
        allAddress.forEach(customer => {
          children.push(
            <Option key={customer.id} value={customer.id}>
              {customer.name} / {customer.contact} / {customer.phone}
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

    const getSingleModalContent = () => {
      if (done) {
        message.success('操作成功');
        this.handleSingleDone();
      }

      return (
        <Form>
          <FormItem label="包号" {...this.formLayout}>
            {getFieldDecorator('number', {
              initialValue: 1,
            })(<InputNumber min={1} max={maxNumber} step={1} />)}
          </FormItem>
          <FormItem label="数量" {...this.formLayout}>
            {getFieldDecorator('quantity', {
              rules: [{ required: true, message: '必须填写数量' }],
              initialValue: selectedStockFlow.quantity,
            })(<InputNumber min={1} max={selectedStockFlow.quantity} step={1} />)}
          </FormItem>
        </Form>
      );
    };

    const getPackItemsContent = () => {
      const sortedItems = packItems.sort((a, b) => a.number - b.number);
      const subArray = [];
      const resultArray = [];
      let start = 0;
      for (let i = 0; i < sortedItems.length; i += 1) {
        if (i > 0 && sortedItems[i].number !== sortedItems[i - 1].number) {
          subArray.push(sortedItems.slice(start, i));
          start = i;
        }
        if (i === sortedItems.length - 1) {
          subArray.push(sortedItems.slice(start, i + 1));
        }
      }
      let j = 0;
      for (let i = 1; i <= maxNumber; i += 1) {
        if (subArray[j] !== undefined && subArray[j][0].number === i) {
          resultArray.push(subArray[j]);
          j += 1;
        } else {
          resultArray.push([]);
        }
      }
      const result = [];
      resultArray.forEach((array, index) => {
        result.push(
          <Card
            key={intformat(flakeIdGen1.next(), 'dec')}
            title={`第${index + 1}包`}
            style={{ marginTop: 24, marginBottom: 24 }}
            size="small"
          >
            <Table
              columns={packItemColumns}
              dataSource={array}
              pagination={false}
              size="middle"
              rowKey="id"
            />
          </Card>
        );
      });
      return result;
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
          <Form>
            <Row gutter={16}>
              <Col span={5}>
                <FormItem label="选择客户" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('customer', {
                    rules: [{ required: true, message: '请选择所属客户' }],
                    initialValue: customerFilter,
                  })(
                    <Select
                      disabled
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
                      disabled
                      filterOption={(input, option) =>
                        option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                      }
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
                  })(<InputNumber min={1} disabled />)}
                </FormItem>
              </Col>
              <Col span={3}>
                <FormItem label="物流单号" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('trackingNumber', {
                    initialValue: trackingNumber,
                  })(<Input disabled />)}
                </FormItem>
              </Col>
              <Col span={10}>
                <FormItem label="备注" {...this.formLayout} hasFeedback>
                  {getFieldDecorator('description', {
                    initialValue: packDescription,
                  })(<Input disabled />)}
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
                    <Select disabled showSearch allowClear>
                      {getAddressOptions(addressList)}
                    </Select>
                  )}
                </FormItem>
              </Col>
            </Row>
            {getPackItemsContent()}
            <Card title="待装入商品" style={{ marginTop: 24, marginBottom: 24 }} size="small">
              <Table
                columns={stockFlowOperateColumn}
                dataSource={stockFlows}
                pagination={false}
                size="middle"
                rowKey="id"
              />
            </Card>
            <Row>
              <Col span={12} offset={6}>
                <Button
                  htmlType="submit"
                  type="primary"
                  size="large"
                  style={{ width: '70%', marginTop: 24 }}
                  onClick={handleSubmit}
                  disabled={stockFlows.length !== 0}
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
        <Modal
          title="添加商品到包号"
          width={320}
          destroyOnClose
          visible={singleModalVisible}
          {...singleModalFooter}
        >
          {getSingleModalContent()}
        </Modal>
      </div>
    );
  }
}

export default AssignPackForm;
