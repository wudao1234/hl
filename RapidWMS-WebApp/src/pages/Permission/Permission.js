import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
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
  Tag,
  Tree,
  TreeSelect,
  InputNumber,
} from 'antd';

import moment from 'moment';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './Permission.less';

const FormItem = Form.Item;
const { TreeNode } = Tree;
const SelectTreeNode = TreeSelect.TreeNode;

@connect(({ permission, loading }) => ({
  list: permission.list,
  loading: loading.models.role,
}))
@Form.create()
class PermissionTree extends PureComponent {
  state = {
    visible: false,
    done: false,
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  columns = [
    {
      title: '名称',
      dataIndex: 'name',
      key: 'name',
      width: '25%',
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
      title: '描述',
      dataIndex: 'alias',
      key: 'alias',
      width: '15%',
      render: text => {
        return <Tag color="blue">{text}</Tag>;
      },
    },
    {
      title: '排序',
      dataIndex: 'sort',
      key: 'sort',
      width: '5%',
      render: text => {
        return <Tag color="red">{text}</Tag>;
      },
    },
    {
      title: '创建时间',
      dataIndex: 'createTime',
      key: 'createTime',
      width: '15%',
      render: text => {
        return text ? moment(text).format('lll') : '';
      },
    },
    {
      title: '操作',
      width: '15%',
      render: (text, row) => {
        return (
          <span className={styles.buttons}>
            <Button
              type="primary"
              onClick={e => {
                e.preventDefault();
                this.showEditModal(row);
              }}
            >
              编辑
            </Button>
            <Popconfirm
              title="确定删除该权限吗？"
              onConfirm={() => this.confirmDelete(row)}
              okText="删除"
              cancelText="取消"
            >
              <Button type="danger" href="#">
                删除
              </Button>
            </Popconfirm>
          </span>
        );
      },
    },
  ];

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'permission/fetch',
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

  getCurrent = (items, id) => {
    let result = null;
    /* eslint-disable */
    for (const item of items) {
      /* eslint-enable */
      // console.log(`item.id === id -> ${item.id} === ${id} -> ${item.id === id}`);
      if (result) {
        break;
      }
      if (item.id === id) {
        result = item;
        break;
      } else if (item.children) {
        result = this.getCurrent(item.children, id);
      }
    }
    return result;
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
        type: 'permission/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建权限成功！' : '修改权限成功！');
            dispatch({
              type: 'permission/fetch',
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
      type: 'permission/submit',
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
            type: 'permission/fetch',
          });
        }
      },
    });
  };

  renderTreeNodes = data => {
    let result;
    if (Array.isArray(data)) {
      result = data.map(item => {
        if (item.children) {
          return (
            <TreeNode title={`${item.name} - ${item.alias}`} key={item.id} dataRef={item}>
              {this.renderTreeNodes(item.children)}
            </TreeNode>
          );
        }
        return <TreeNode title={`${item.name} - ${item.alias}`} key={item.id} dataRef={item} />;
      });
    }
    return result;
  };

  renderSelectTreeNodes = data => {
    let result;
    if (Array.isArray(data)) {
      result = data.map(item => {
        if (item.children) {
          return (
            <SelectTreeNode
              title={`${item.name} - ${item.alias}`}
              value={item.id}
              key={`tree-${item.id}`}
            >
              {this.renderSelectTreeNodes(item.children)}
            </SelectTreeNode>
          );
        }
        return (
          <SelectTreeNode
            title={`${item.name} - ${item.alias}`}
            value={item.id}
            key={`tree-${item.id}`}
          />
        );
      });
    }
    return result;
  };

  renderTreeNodesWithTopNode = data => {
    const newData = [{ id: 0, name: '顶级类目', alias: '顶级类目', children: data }];
    return this.renderSelectTreeNodes(newData);
  };

  render() {
    const { list, loading } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, current = {} } = this.state;

    const modalFooter = done
      ? { footer: null, onCancel: this.handleDone }
      : { okText: '保存', onOk: this.handleSubmit, onCancel: this.handleCancel };

    const getModalContent = () => {
      if (done) {
        message.success('保存权限成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="权限名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入权限名' }],
              initialValue: current.name,
            })(<Input placeholder="请输入权限名，一般用英文大写" />)}
          </FormItem>
          <FormItem label="权限别名" {...this.formLayout} hasFeedback>
            {getFieldDecorator('alias', {
              rules: [{ required: true, message: '请输入权限别名' }],
              initialValue: current.alias,
            })(<Input placeholder="请输入权限别名，可用中文描述" />)}
          </FormItem>
          <FormItem label="排序" {...this.formLayout} hasFeedback>
            {getFieldDecorator('sort', {
              rules: [{ required: true, message: '排序' }],
              initialValue: current.sort,
            })(<InputNumber min={1} max={99999} step={1} />)}
          </FormItem>
          <FormItem label="上级类目" {...this.formLayout}>
            {getFieldDecorator('pid', {
              rules: [{ required: true, message: '请输入权限别名' }],
              initialValue: current.pid ? current.pid : 0,
            })(
              <TreeSelect treeDefaultExpandAll dropdownStyle={{ maxHeight: 400, overflow: 'auto' }}>
                {this.renderTreeNodesWithTopNode(list)}
              </TreeSelect>
            )}
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="权限树"
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
              创建新权限
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
          title={done ? null : `${current.id ? '编辑' : '添加'}权限`}
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

export default PermissionTree;
