import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import { connect } from 'dva';
import {
  Card,
  Input,
  Button,
  Modal,
  Form,
  message,
  Popconfirm,
  notification,
  Table,
  TreeSelect,
  Tag,
  Icon,
  InputNumber,
  Switch,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './SysMenu.less';

const FormItem = Form.Item;
const SelectTreeNode = TreeSelect.TreeNode;

@connect(({ sysMenu, loading }) => ({
  list: sysMenu.list,
  loading: loading.models.role,
}))
@Form.create()
class MenuTable extends PureComponent {
  state = {
    visible: false,
    done: false,
    iconVisible: false,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  icons = [
    'lock',
    'unlock',
    'bars',
    'book',
    'calendar',
    'cloud',
    'cloud-download',
    'code',
    'copy',
    'credit-card',
    'delete',
    'desktop',
    'download',
    'ellipsis',
    'more',
    'file',
    'file-text',
    'file-unknown',
    'file-pdf',
    'file-word',
    'file-excel',
    'file-jpg',
    'file-ppt',
    'file-markdown',
    'file-add',
    'folder',
    'folder-open',
    'folder-add',
    'hdd',
    'frown',
    'meh',
    'smile',
    'inbox',
    'laptop',
    'appstore',
    'link',
    'mail',
    'mobile',
    'notification',
    'paper-clip',
    'picture',
    'poweroff',
    'reload',
    'search',
    'setting',
    'share-alt',
    'shopping-cart',
    'tablet',
    'tag',
    'tags',
    'to-top',
    'upload',
    'user',
    'video-camera',
    'home',
    'loading',
    'loading-3-quarters',
    'cloud-upload',
    'star',
    'heart',
    'environment',
    'eye',
    'eye-invisible',
    'camera',
    'save',
    'team',
    'solution',
    'phone',
    'filter',
    'exception',
    'import',
    'export',
    'customer-service',
    'qrcode',
    'scan',
    'like',
    'dislike',
    'message',
    'pay-circle',
    'calculator',
    'pushpin',
    'bulb',
    'select',
    'switcher',
    'rocket',
    'bell',
    'disconnect',
    'database',
    'compass',
    'barcode',
    'hourglass',
    'key',
    'flag',
    'layout',
    'printer',
    'sound',
    'usb',
    'skin',
    'tool',
    'sync',
    'wifi',
    'car',
    'schedule',
    'user-add',
    'user-delete',
    'usergroup-add',
    'usergroup-delete',
    'man',
    'woman',
    'shop',
    'gift',
    'idcard',
    'medicine-box',
    'red-envelope',
    'coffee',
    'copyright',
    'trademark',
    'safety',
    'wallet',
    'bank',
    'trophy',
    'contacts',
    'global',
    'shake',
    'api',
    'fork',
    'dashboard',
    'table',
    'profile',
    'alert',
    'audit',
    'branches',
    'build',
    'border',
    'crown',
    'experiment',
    'fire',
    'money-collect',
    'property-safety',
    'read',
    'reconciliation',
    'rest',
    'security-scan',
    'insurance',
    'interation',
    'safety-certificate',
    'project',
    'thunderbolt',
    'block',
    'cluster',
    'deployment-unit',
    'dollar',
    'euro',
    'pound',
    'file-done',
    'file-exclamation',
    'file-protect',
    'file-search',
    'file-sync',
    'gateway',
    'gold',
    'robot',
    'shopping',
    'question',
    'question-circle',
    'plus',
    'plus-circle',
    'pause',
    'pause-circle',
    'minus',
    'minus-circle',
    'plus-square',
    'minus-square',
    'info',
    'info-circle',
    'exclamation',
    'exclamation-circle',
    'close',
    'close-circle',
    'close-square',
    'check',
    'check-circle',
    'check-square',
    'clock-circle',
    'warning',
    'issues-close',
    'stop',
    'area-chart',
    'pie-chart',
    'bar-chart',
    'dot-chart',
    'line-chart',
    'radar-chart',
    'heat-map',
    'fall',
    'rise',
    'stock',
    'box-plot',
    'fund',
    'sliders',
    'android',
    'apple',
    'windows',
    'ie',
    'chrome',
    'github',
    'aliwangwang',
    'dingding',
    'weibo-square',
    'weibo-circle',
    'taobao-circle',
    'html5',
    'weibo',
    'twitter',
    'wechat',
    'youtube',
    'alipay-circle',
    'taobao',
    'skype',
    'qq',
    'medium-workmark',
    'gitlab',
    'medium',
    'linkedin',
    'google-plus',
    'dropbox',
    'facebook',
    'codepen',
    'code-sandbox',
    'amazon',
    'google',
    'codepen-circle',
    'alipay',
    'ant-design',
    'aliyun',
    'zhihu',
    'slack',
    'slack-square',
    'behance',
    'behance-square',
    'dribbble',
    'dribbble-square',
    'instagram',
    'yuque',
    'alibaba',
    'yahoo',
  ];

  columns = [
    {
      title: '名称',
      dataIndex: 'name',
      key: 'name',
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
      title: '图标',
      dataIndex: 'icon',
      key: 'icon',
      width: '5%',
      render: text => {
        return text ? <Icon type={text} /> : '';
      },
    },
    {
      title: '排序',
      dataIndex: 'sort',
      key: 'sort',
      width: '5%',
      render: text => {
        return <Tag color="#2db7f5">{text}</Tag>;
      },
    },
    {
      title: '链接地址',
      dataIndex: 'path',
      key: 'path',
      width: '15%',
    },
    {
      title: '组件路径',
      dataIndex: 'component',
      key: 'component',
      width: '15%',
    },
    {
      title: '内部菜单',
      dataIndex: 'iframe',
      key: 'iframe',
      width: '8%',
      render: text => {
        if (text) {
          return <Tag color="red">外部</Tag>;
        }
        return <Tag color="green">内部</Tag>;
      },
    },
    {
      title: '操作',
      width: '15%',
      render: (text, row) => {
        return (
          <span className={styles.buttons}>
            <Button
              onClick={e => {
                e.preventDefault();
                this.showEditModal(row);
              }}
            >
              编辑
            </Button>
            <Popconfirm
              title="确定删除该菜单吗？"
              onConfirm={() => this.confirmDelete(row)}
              okText="删除"
              cancelText="取消"
            >
              <Button href="#">删除</Button>
            </Popconfirm>
          </span>
        );
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'sysMenu/fetch',
    });
  }

  showModal = () => {
    this.setState({
      visible: true,
      current: undefined,
    });
  };

  showEditModal = item => {
    this.setState({
      visible: true,
      current: item,
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
    const { current } = this.state;
    const id = current ? current.id : '';

    setTimeout(() => this.addBtn.blur(), 0);
    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      this.handleDone();
      dispatch({
        type: 'sysMenu/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            // console.log(id);
            message.success(id === undefined ? '创建菜单成功！' : '修改菜单成功！');
            dispatch({
              type: 'sysMenu/fetch',
            });
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
      type: 'sysMenu/submit',
      payload: { id },
      callback: response => {
        if (response.status === 400) {
          notification.error({
            message: '操作发生错误',
            description: response.message,
          });
        } else {
          message.success('删除成功！');
          dispatch({
            type: 'sysMenu/fetch',
          });
        }
      },
    });
  };

  renderSelectTreeNodes = data => {
    let result;
    if (Array.isArray(data)) {
      result = data.map(item => {
        if (item.children) {
          return (
            <SelectTreeNode title={item.name} value={item.id} key={item.id}>
              {this.renderSelectTreeNodes(item.children)}
            </SelectTreeNode>
          );
        }
        return <SelectTreeNode title={item.name} value={item.id} key={item.id} />;
      });
    }
    return result;
  };

  renderTreeNodesWithTopNode = data => {
    const newData = [{ id: 0, name: '顶级类目', alias: '顶级类目', children: data }];
    return this.renderSelectTreeNodes(newData);
  };

  handleSelectIcon = () => {
    this.setState({
      iconVisible: true,
    });
  };

  render() {
    const { list, loading } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, current = {} } = this.state;
    const { iconVisible } = this.state;

    const modalFooter = done
      ? { footer: null, onCancel: this.handleDone }
      : { okText: '保存', onOk: this.handleSubmit, onCancel: this.handleCancel };

    const getModalContent = () => {
      if (done) {
        message.success('保存菜单成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="菜单名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入菜单名' }],
              initialValue: current.name,
            })(<Input placeholder="请输入菜单名" />)}
          </FormItem>
          <FormItem label="菜单图标" {...this.formLayout}>
            {getFieldDecorator('icon', {
              initialValue: current.icon,
            })(<Input hidden />)}
            {current.icon ? <Icon type={current.icon} /> : ''}
            <Button
              htmlType="button"
              type="dashed"
              style={{ marginLeft: '10px' }}
              onClick={this.handleSelectIcon}
            >
              点击选择图标
            </Button>
          </FormItem>
          <FormItem label="菜单排序" {...this.formLayout} hasFeedback>
            {getFieldDecorator('sort', {
              rules: [{ required: true, message: '请输入菜单排序' }],
              initialValue: current.sort,
            })(<InputNumber placeholder="请输入菜单排序号" />)}
          </FormItem>
          <FormItem label="外部链接菜单" {...this.formLayout}>
            {getFieldDecorator('iframe', {
              initialValue: current.iframe !== undefined ? current.iframe : false,
            })(<Switch defaultChecked={current.iframe !== undefined ? current.iframe : false} />)}
          </FormItem>
          <FormItem label="链接地址" {...this.formLayout} hasFeedback>
            {getFieldDecorator('path', {
              rules: [{ required: true, message: '请输入链接地址' }],
              initialValue: current.path,
            })(<Input placeholder="请输入链接地址" />)}
          </FormItem>
          <FormItem label="组件地址" {...this.formLayout}>
            {getFieldDecorator('component', {
              initialValue: current.component,
            })(<Input placeholder="请输入组件地址" />)}
          </FormItem>
          <FormItem label="上级目录" {...this.formLayout} hasFeedback>
            {getFieldDecorator('pid', {
              rules: [{ required: true, message: '请选择上级目录' }],
              initialValue: current.pid,
            })(
              <TreeSelect treeDefaultExpandAll dropdownStyle={{ maxHeight: 500, overflow: 'auto' }}>
                {this.renderTreeNodesWithTopNode(list)}
              </TreeSelect>
            )}
          </FormItem>
        </Form>
      );
    };

    const getIconContent = () => {
      return this.icons.map(icon => {
        return (
          <a
            href="#"
            key={icon}
            onClick={() => {
              setTimeout(() => this.addBtn.blur(), 0);
              this.setState({
                iconVisible: false,
                current: { ...current, icon },
              });
            }}
          >
            <Icon type={icon} style={{ width: '30px', height: '30px' }} />
          </a>
        );
      });
    };

    const handleIconCancel = () => {
      setTimeout(() => this.addBtn.blur(), 0);
      this.setState({
        iconVisible: false,
      });
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="菜单树"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
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
              创建新菜单
            </Button>
            <Table
              columns={this.columns}
              dataSource={list}
              rowKey="id"
              loading={loading}
              pagination={false}
            />
          </Card>
        </div>
        <Modal
          title={done ? null : `${current.id ? '编辑' : '添加'}菜单`}
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
        <Modal
          title="点击图片选择"
          width={480}
          bodyStyle={{ padding: '28px 0 0' }}
          destroyOnClose
          visible={iconVisible}
          footer={null}
          onCancel={handleIconCancel}
        >
          {getIconContent()}
        </Modal>
      </PageHeaderWrapper>
    );
  }
}

export default MenuTable;
