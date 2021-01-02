import React, { PureComponent } from 'react';
import {
  Button,
  Card,
  DatePicker,
  Form,
  Icon,
  Upload,
  Select,
  Switch,
  Tabs,
  notification,
  message,
  Divider,
  Input,
} from 'antd';
import { FormattedMessage } from 'umi/locale';

import { connect } from 'dva';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import { getToken } from '../../models/login';
import styles from './Order.less';

const FormItem = Form.Item;
const { TabPane } = Tabs;
const { Option } = Select;

@connect(({ customer, wareZone }) => ({
  customerList: customer.allList,
  wareZoneList: wareZone.allList,
}))
@Form.create()
class ImportOrder extends PureComponent {
  state = {
    customerFilter: null,
    fetchAll: false,
    submitting: false,
  };

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'customer/fetchMy',
    });
    dispatch({
      type: 'wareZone/fetchAll',
    });
  }

  render() {
    const { dispatch } = this.props;
    const {
      form,
      form: { getFieldDecorator },
    } = this.props;

    const { customerList, wareZoneList } = this.props;

    const { submitting, customerFilter, fetchAll, uploadFileList = [] } = this.state;

    const formItemLayout = {
      labelCol: {
        xs: { span: 24 },
        sm: { span: 7 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 12 },
        md: { span: 10 },
      },
    };

    const submitFormLayout = {
      wrapperCol: {
        xs: { span: 24, offset: 0 },
        sm: { span: 10, offset: 7 },
      },
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

    const handleSelectCustomer = value => {
      this.setState({
        customerFilter: value,
      });
    };

    const handleFetchAllSwitch = value => {
      this.setState({
        fetchAll: value,
      });
    };

    const handleKingdeeSubmit = e => {
      e.preventDefault();
      form.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        message.info('导入时间较长，请耐心等待');
        this.setState({ submitting: true });
        dispatch({
          type: 'order/importKingdee',
          payload: { ...fieldsValue, uploadFileList },
          callback: response => {
            this.setState({ submitting: false });
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed === 0) {
                notification.error({
                  message: '未能导入订单',
                  description: `有${countFailed}个订单导入失败，请检查是否已经导入`,
                });
              }
              message.success(`成功导入${countSucceed}个订单`);
              if (countFailed !== 0) {
                message.error(`${countFailed}个订单导入失败，请检查是否已经导入`);
              }
            }
          },
        });
      });
    };

    const handleKingdee2Submit = e => {
      e.preventDefault();
      form.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        message.info('导入时间较长，请耐心等待');
        this.setState({ submitting: true });
        dispatch({
          type: 'order/importKingdee2',
          payload: { ...fieldsValue, uploadFileList },
          callback: response => {
            this.setState({ submitting: false });
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed === 0) {
                notification.error({
                  message: '未能导入订单',
                  description: `有${countFailed}个订单导入失败，请检查是否已经导入`,
                });
              }
              message.success(`成功导入${countSucceed}个订单`);
              if (countFailed !== 0) {
                message.error(`${countFailed}个订单导入失败，请检查是否已经导入`);
              }
            }
          },
        });
      });
    };

    const handleGeneralSubmit = e => {
      e.preventDefault();
      form.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        message.info('导入时间较长，请耐心等待');
        this.setState({ submitting: true });
        dispatch({
          type: 'order/importGeneral',
          payload: { ...fieldsValue, uploadFileList },
          callback: response => {
            this.setState({ submitting: false });
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed === 0) {
                notification.error({
                  message: '未能导入订单',
                  description: `有${countFailed}个订单导入失败，请检查是否已经导入`,
                });
              }
              message.success(`成功导入${countSucceed}个订单`);
              if (countFailed !== 0) {
                message.error(`${countFailed}个订单导入失败，请检查是否已经导入`);
              }
            }
          },
        });
      });
    };

    const handleHtmlSubmit = e => {
      e.preventDefault();
      form.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        message.info('导入时间较长，请耐心等待');
        this.setState({ submitting: true });
        dispatch({
          type: 'order/importHtml',
          payload: { ...fieldsValue, uploadFileList },
          callback: response => {
            this.setState({ submitting: false });
            if (response.status === 400) {
              notification.error({
                message: '操作发生错误',
                description: response.message,
              });
            } else {
              const { countSucceed, countFailed } = response;
              if (countSucceed === 0) {
                notification.error({
                  message: '未能导入订单',
                  description: `有${countFailed}个订单导入失败，请检查是否已经导入`,
                });
              }
              message.success(`成功导入${countSucceed}个订单`);
              if (countFailed !== 0) {
                message.error(`${countFailed}个订单导入失败，请检查是否已经导入`);
              }
            }
          },
        });
      });
    };

    const handleUploadChange = info => {
      let { fileList } = info;
      fileList = fileList.map(file => {
        if (file.response) {
          return file.response;
        }
        return null;
      });
      fileList = fileList.filter(file => {
        return typeof file === 'string';
      });
      this.setState({ uploadFileList: fileList });
    };

    const uploadExcelProps = {
      name: 'file',
      action: '/api/customer_orders/upload_excel_file',
      headers: {
        Authorization: `Bearer ${getToken()}`,
      },
      onChange: handleUploadChange,
      multiple: true,
      accept:
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel',
    };

    const getKingdeeForm = () => {
      return (
        <Form {...formItemLayout} onSubmit={handleKingdeeSubmit} style={{ marginTop: 8 }}>
          <FormItem label="选择客户" {...this.formLayout} hasFeedback>
            {getFieldDecorator('customer', {
              rules: [{ required: true, message: '请选择所属客户' }],
              initialValue: customerFilter,
            })(
              <Select
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
          <FormItem label="指定库区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('wareZone')(
              <Select
                mode="multiple"
                allowClear
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="可以指定库区匹配出库"
                style={{ width: '100%' }}
              >
                {getWareZoneOptions(wareZoneList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="最低保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMin')(<DatePicker />)}
          </FormItem>
          <FormItem label="最高保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMax')(<DatePicker />)}
          </FormItem>
          <FormItem label="质保指数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('qualityAssuranceExponent')(<Input />)}
          </FormItem>
          <FormItem label="必须全部匹配" {...this.formLayout}>
            {getFieldDecorator('fetchAll', {
              initialValue: fetchAll !== undefined && fetchAll,
            })(
              <Switch
                checked={fetchAll !== undefined && fetchAll}
                checkedChildren="是"
                unCheckedChildren="否"
                onChange={handleFetchAllSwitch}
              />
            )}
          </FormItem>
          <FormItem label="强制匹配商品规格" {...this.formLayout}>
            {getFieldDecorator('usePackCount', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="重置自定编号" {...this.formLayout}>
            {getFieldDecorator('useNewAutoIncreaseSn', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="立即匹配出库" {...this.formLayout}>
            {getFieldDecorator('fetchStocks', {
              initialValue: true,
            })(<Switch checkedChildren="是" unCheckedChildren="否" defaultChecked />)}
          </FormItem>
          <FormItem label="选择上传文件" {...this.formLayout}>
            {getFieldDecorator('originalFileList', {
              rules: [{ required: true, message: '请选择导入文件' }],
            })(
              <Upload {...uploadExcelProps}>
                <Button>
                  <Icon type="upload" /> 点击选择文件
                </Button>
              </Upload>
            )}
          </FormItem>
          <FormItem {...submitFormLayout} style={{ marginTop: 32 }}>
            <Button type="primary" htmlType="submit" loading={submitting}>
              <FormattedMessage id="form.submit" />
            </Button>
          </FormItem>
          <Divider />
          <a href="/template/美倩出库单.zip">下载导入文件样表</a>
        </Form>
      );
    };

    const getKingdee2Form = () => {
      return (
        <Form {...formItemLayout} onSubmit={handleKingdee2Submit} style={{ marginTop: 8 }}>
          <FormItem label="选择客户" {...this.formLayout} hasFeedback>
            {getFieldDecorator('customer', {
              rules: [{ required: true, message: '请选择所属客户' }],
              initialValue: customerFilter,
            })(
              <Select
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
          <FormItem label="指定库区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('wareZone')(
              <Select
                mode="multiple"
                allowClear
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="可以指定库区匹配出库"
                style={{ width: '100%' }}
              >
                {getWareZoneOptions(wareZoneList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="最低保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMin')(<DatePicker />)}
          </FormItem>
          <FormItem label="最高保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMax')(<DatePicker />)}
          </FormItem>
          <FormItem label="质保指数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('qualityAssuranceExponent')(<Input />)}
          </FormItem>
          <FormItem label="必须全部匹配" {...this.formLayout}>
            {getFieldDecorator('fetchAll', {
              initialValue: fetchAll !== undefined && fetchAll,
            })(
              <Switch
                checked={fetchAll !== undefined && fetchAll}
                checkedChildren="是"
                unCheckedChildren="否"
                onChange={handleFetchAllSwitch}
              />
            )}
          </FormItem>
          <FormItem label="强制匹配商品规格" {...this.formLayout}>
            {getFieldDecorator('usePackCount', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="重置自定编号" {...this.formLayout}>
            {getFieldDecorator('useNewAutoIncreaseSn', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="立即匹配出库" {...this.formLayout}>
            {getFieldDecorator('fetchStocks', {
              initialValue: true,
            })(<Switch checkedChildren="是" unCheckedChildren="否" defaultChecked />)}
          </FormItem>
          <FormItem label="选择上传文件" {...this.formLayout}>
            {getFieldDecorator('originalFileList', {
              rules: [{ required: true, message: '请选择导入文件' }],
            })(
              <Upload {...uploadExcelProps}>
                <Button>
                  <Icon type="upload" /> 点击选择文件
                </Button>
              </Upload>
            )}
          </FormItem>
          <FormItem {...submitFormLayout} style={{ marginTop: 32 }}>
            <Button type="primary" htmlType="submit" loading={submitting}>
              <FormattedMessage id="form.submit" />
            </Button>
          </FormItem>
          <Divider />
          <a href="/template/美倩调拨单.zip">下载导入文件样表</a>
        </Form>
      );
    };

    const getGeneralImportForm = () => {
      return (
        <Form {...formItemLayout} onSubmit={handleGeneralSubmit} style={{ marginTop: 8 }}>
          <FormItem label="选择客户" {...this.formLayout} hasFeedback>
            {getFieldDecorator('customer', {
              rules: [{ required: true, message: '请选择所属客户' }],
              initialValue: customerFilter,
            })(
              <Select
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
          <FormItem label="指定库区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('wareZone')(
              <Select
                mode="multiple"
                allowClear
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="可以指定库区匹配出库"
                style={{ width: '100%' }}
              >
                {getWareZoneOptions(wareZoneList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="最低保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMin')(<DatePicker />)}
          </FormItem>
          <FormItem label="最高保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMax')(<DatePicker />)}
          </FormItem>
          <FormItem label="质保指数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('qualityAssuranceExponent')(<Input />)}
          </FormItem>
          <FormItem label="必须全部匹配" {...this.formLayout}>
            {getFieldDecorator('fetchAll', {
              initialValue: fetchAll !== undefined && fetchAll,
            })(
              <Switch
                checked={fetchAll !== undefined && fetchAll}
                checkedChildren="是"
                unCheckedChildren="否"
                onChange={handleFetchAllSwitch}
              />
            )}
          </FormItem>
          <FormItem label="强制匹配商品规格" {...this.formLayout}>
            {getFieldDecorator('usePackCount', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="重置自定编号" {...this.formLayout}>
            {getFieldDecorator('useNewAutoIncreaseSn', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="立即匹配出库" {...this.formLayout}>
            {getFieldDecorator('fetchStocks', {
              initialValue: true,
            })(<Switch checkedChildren="是" unCheckedChildren="否" defaultChecked />)}
          </FormItem>
          <FormItem label="选择上传文件" {...this.formLayout}>
            {getFieldDecorator('originalFileList', {
              rules: [{ required: true, message: '请选择导入文件' }],
            })(
              <Upload {...uploadExcelProps}>
                <Button>
                  <Icon type="upload" /> 点击选择文件
                </Button>
              </Upload>
            )}
          </FormItem>
          <FormItem {...submitFormLayout} style={{ marginTop: 32 }}>
            <Button type="primary" htmlType="submit" loading={submitting}>
              <FormattedMessage id="form.submit" />
            </Button>
          </FormItem>
          <div>
            <h4>注意事项</h4>
            <ol>
              <li>1.导入订单必须指定客户，不同客户必须分开导入</li>
              <li>2.下载的导入模板中，最后一排的&quot;结束&quot;必须有，否则出错</li>
            </ol>
          </div>
          <Divider />
          <a href="/template/通用导入模板.zip">下载通用导入模板</a>
        </Form>
      );
    };

    const uploadHtmlProps = {
      name: 'file',
      action: '/api/customer_orders/upload_html_file',
      headers: {
        Authorization: `Bearer ${getToken()}`,
      },
      onChange: handleUploadChange,
      multiple: true,
      accept: 'text/html',
    };

    const getHtmlImportForm = () => {
      return (
        <Form {...formItemLayout} onSubmit={handleHtmlSubmit} style={{ marginTop: 8 }}>
          <FormItem label="选择客户" {...this.formLayout} hasFeedback>
            {getFieldDecorator('customer', {
              rules: [{ required: true, message: '请选择所属客户' }],
              initialValue: customerFilter,
            })(
              <Select
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
          <FormItem label="指定库区" {...this.formLayout} hasFeedback>
            {getFieldDecorator('wareZone')(
              <Select
                mode="multiple"
                allowClear
                showSearch
                filterOption={(input, option) =>
                  option.props.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                }
                placeholder="可以指定库区匹配出库"
                style={{ width: '100%' }}
              >
                {getWareZoneOptions(wareZoneList)}
              </Select>
            )}
          </FormItem>
          <FormItem label="最低保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMin')(<DatePicker />)}
          </FormItem>
          <FormItem label="最高保质期" {...this.formLayout} hasFeedback>
            {getFieldDecorator('orderExpireDateMax')(<DatePicker />)}
          </FormItem>
          <FormItem label="质保指数" {...this.formLayout} hasFeedback>
            {getFieldDecorator('qualityAssuranceExponent')(<Input />)}
          </FormItem>
          <FormItem label="必须全部匹配" {...this.formLayout}>
            {getFieldDecorator('fetchAll', {
              initialValue: fetchAll !== undefined && fetchAll,
            })(
              <Switch
                checked={fetchAll !== undefined && fetchAll}
                checkedChildren="是"
                unCheckedChildren="否"
                onChange={handleFetchAllSwitch}
              />
            )}
          </FormItem>
          <FormItem label="强制匹配商品规格" {...this.formLayout}>
            {getFieldDecorator('usePackCount', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="重置自定编号" {...this.formLayout}>
            {getFieldDecorator('useNewAutoIncreaseSn', {
              initialValue: false,
            })(<Switch checkedChildren="是" unCheckedChildren="否" />)}
          </FormItem>
          <FormItem label="立即匹配出库" {...this.formLayout}>
            {getFieldDecorator('fetchStocks', {
              initialValue: true,
            })(<Switch checkedChildren="是" unCheckedChildren="否" defaultChecked />)}
          </FormItem>
          <FormItem label="选择上传文件" {...this.formLayout}>
            {getFieldDecorator('originalFileList', {
              rules: [{ required: true, message: '请选择导入文件' }],
            })(
              <Upload {...uploadHtmlProps}>
                <Button>
                  <Icon type="upload" /> 点击选择文件
                </Button>
              </Upload>
            )}
          </FormItem>
          <FormItem {...submitFormLayout} style={{ marginTop: 32 }}>
            <Button type="primary" htmlType="submit" loading={submitting}>
              <FormattedMessage id="form.submit" />
            </Button>
          </FormItem>
          <Divider />
          <a href="/template/三立HTML入库单.zip">下载导入文件样表</a>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered
            title="导入订单"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
          >
            <Tabs defaultActiveKey="1">
              <TabPane tab="导入通用格式订单" key="1">
                {getGeneralImportForm()}
              </TabPane>
              <TabPane tab="导入金蝶美倩出库单" key="2">
                {getKingdeeForm()}
              </TabPane>
              <TabPane tab="导入金蝶美倩调拨单" key="3">
                {getKingdee2Form()}
              </TabPane>
              <TabPane tab="导入三立HTML订单" key="4">
                {getHtmlImportForm()}
              </TabPane>
            </Tabs>
          </Card>
        </div>
      </PageHeaderWrapper>
    );
  }
}

export default ImportOrder;
