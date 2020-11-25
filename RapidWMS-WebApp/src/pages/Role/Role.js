import React, { PureComponent } from 'react';
import { findDOMNode } from 'react-dom';
import moment from 'moment';
import { connect } from 'dva';
import {
  List,
  Card,
  Input,
  Button,
  Modal,
  Form,
  message,
  Popconfirm,
  notification,
  Tree,
} from 'antd';

import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './Role.less';

const FormItem = Form.Item;
const { Search } = Input;
const { TreeNode } = Tree;

@connect(({ role, loading }) => ({
  list: role.list,
  permissions: role.permissions,
  menus: role.menus,
  loading: loading.models.role,
}))
@Form.create()
class RoleList extends PureComponent {
  state = {
    visible: false,
    done: false,
    visiblePermission: false,
    visibleMenu: false,
    selectedPermissionKeys: [],
    selectedMenuKeys: [],
  };

  formLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 13 },
  };

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'role/fetch',
    });
    dispatch({
      type: 'role/fetchPermissionTree',
    });
    dispatch({
      type: 'role/fetchMenuTree',
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
        type: 'role/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建角色成功！' : '修改角色成功！');
            dispatch({
              type: 'role/fetch',
            });
          }
        },
      });
    });
  };

  confirmDelete = id => {
    const { dispatch } = this.props;
    dispatch({
      type: 'role/submit',
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
            type: 'role/fetch',
          });
        }
      },
    });
  };

  handleSearchByRoleName = value => {
    const { dispatch } = this.props;
    dispatch({
      type: 'role/fetch',
      payload: { query: `&name=${value}` },
    });
  };

  handlePermissionEdit = item => {
    this.setState({
      visiblePermission: true,
      selectedPermissionKeys: item.permissions.map(p => `${p.id}`),
      current: item,
    });
  };

  handlePermissionSubmit = () => {
    const { selectedPermissionKeys, current } = this.state;
    const { dispatch } = this.props;
    dispatch({
      type: 'role/updatePermission',
      payload: {
        id: current.id,
        permissions: selectedPermissionKeys.map(key => {
          return { id: key };
        }),
      },
      callback: () => {
        message.success('更新权限成功！');
        dispatch({
          type: 'role/fetch',
        });
      },
    });
    this.setState({
      current: undefined,
      visiblePermission: false,
    });
  };

  handlePermissionCancel = () => {
    setTimeout(() => this.addBtn.blur(), 0);
    this.setState({
      visiblePermission: false,
    });
  };

  handleCheckPermission = keys => {
    this.setState({
      selectedPermissionKeys: keys,
    });
  };

  handleMenuEdit = item => {
    this.setState({
      visibleMenu: true,
      selectedMenuKeys: item.menus.map(p => `${p.id}`),
      current: item,
    });
  };

  handleMenuSubmit = () => {
    const { selectedMenuKeys, current } = this.state;
    const { dispatch } = this.props;
    dispatch({
      type: 'role/updateMenu',
      payload: {
        id: current.id,
        menus: selectedMenuKeys.map(key => {
          return { id: key };
        }),
      },
      callback: () => {
        message.success('更新菜单成功！');
        dispatch({
          type: 'role/fetch',
        });
      },
    });
    this.setState({
      current: undefined,
      visibleMenu: false,
    });
  };

  handleMenuCancel = () => {
    setTimeout(() => this.addBtn.blur(), 0);
    this.setState({
      visibleMenu: false,
    });
  };

  handleCheckMenu = keys => {
    // 因为使用了 checkStrictly 模式，所以这里获取的keys变成了一个对象
    this.setState({
      selectedMenuKeys: keys.checked,
    });
  };

  renderTreeNodes = data => {
    let result;
    if (Array.isArray(data)) {
      result = data.map(item => {
        if (item.children) {
          return (
            <TreeNode title={item.label} key={item.id} dataRef={item}>
              {this.renderTreeNodes(item.children)}
            </TreeNode>
          );
        }
        return <TreeNode title={item.label} key={item.id} dataRef={item} />;
      });
    }
    return result;
  };

  render() {
    const { list, permissions, menus, loading } = this.props;
    const {
      form: { getFieldDecorator },
    } = this.props;
    const { visible, done, current = {} } = this.state;
    const { visiblePermission, selectedPermissionKeys } = this.state;
    const { visibleMenu, selectedMenuKeys } = this.state;

    const modalFooter = done
      ? { footer: null, onCancel: this.handleDone }
      : { okText: '保存', onOk: this.handleSubmit, onCancel: this.handleCancel };

    const modalPermissionFooter = {
      okText: '保存',
      onOk: this.handlePermissionSubmit,
      onCancel: this.handlePermissionCancel,
    };

    const modalMenuFooter = {
      okText: '保存',
      onOk: this.handleMenuSubmit,
      onCancel: this.handleMenuCancel,
    };

    const extraContent = (
      <div className={styles.extraContent}>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入角色名进行搜索"
          onSearch={this.handleSearchByRoleName}
        />
      </div>
    );

    const paginationProps = {
      showSizeChanger: true,
      showQuickJumper: true,
      pageSize: 10,
      total: list.length,
    };

    const ListContent = ({ data: createTime }) => (
      <div className={styles.listContent}>
        <div className={styles.listContentItem}>
          <span>创建时间</span>
          <p />
          {moment(createTime).format('lll')}
        </div>
      </div>
    );

    const getModalContent = () => {
      if (done) {
        message.success('保存角色成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="角色名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('name', {
              rules: [{ required: true, message: '请输入角色名' }],
              initialValue: current.name,
            })(<Input placeholder="请输入角色名" />)}
          </FormItem>
          <FormItem label="说明" {...this.formLayout}>
            {getFieldDecorator('remark', {
              initialValue: current.remark,
            })(<Input placeholder="角色说明" />)}
          </FormItem>
        </Form>
      );
    };

    const getModalCollectionContent = (collections, selectedKeys, checkMethod, strict) => {
      return (
        <Form>
          <FormItem {...this.formLayout}>
            <Tree
              className={styles.center}
              checkable
              checkedKeys={selectedKeys}
              onCheck={checkMethod}
              checkStrictly={strict}
              blockNode
            >
              {this.renderTreeNodes(collections)}
            </Tree>
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            className={styles.listCard}
            bordered={false}
            title="角色列表"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px' }}
            extra={extraContent}
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
              创建新角色
            </Button>
            <List
              size="small"
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
              dataSource={list}
              renderItem={item => (
                <List.Item
                  actions={[
                    <Button
                      htmlType="button"
                      type="dashed"
                      onClick={e => {
                        e.preventDefault();
                        this.handlePermissionEdit(item);
                      }}
                    >
                      配置权限
                    </Button>,
                    <Button
                      htmlType="button"
                      type="dashed"
                      onClick={e => {
                        e.preventDefault();
                        this.handleMenuEdit(item);
                      }}
                    >
                      配置菜单
                    </Button>,
                    <a
                      onClick={e => {
                        e.preventDefault();
                        this.showEditModal(item);
                      }}
                    >
                      编辑
                    </a>,
                    <Popconfirm
                      title="确定删除该角色吗？"
                      onConfirm={() => this.confirmDelete(item.id)}
                      okText="删除"
                      cancelText="取消"
                    >
                      <a href="#">删除</a>
                    </Popconfirm>,
                  ]}
                >
                  <List.Item.Meta
                    title={
                      <a
                        onClick={e => {
                          e.preventDefault();
                          this.showEditModal(item);
                        }}
                      >
                        {item.name}
                      </a>
                    }
                    description={item.remark}
                  />
                  <ListContent data={item.createTime} />
                </List.Item>
              )}
            />
          </Card>
        </div>
        <Modal
          title={done ? null : `${current.id ? '编辑' : '添加'}角色`}
          className={styles.standardListForm}
          width={640}
          bodyStyle={done ? { padding: '72px 0' } : { padding: '28px 0 0' }}
          destroyOnClose
          visible={visible}
          {...modalFooter}
        >
          {getModalContent()}
        </Modal>
        <Modal
          title={`编辑 ${current.name} 权限`}
          className={styles.standardListForm}
          width={640}
          bodyStyle={{ padding: '28px 0 0' }}
          destroyOnClose
          visible={visiblePermission}
          {...modalPermissionFooter}
        >
          {getModalCollectionContent(
            permissions,
            selectedPermissionKeys,
            this.handleCheckPermission,
            false
          )}
        </Modal>
        <Modal
          title={`编辑 ${current.name} 菜单`}
          className={styles.standardListForm}
          width={640}
          bodyStyle={{ padding: '28px 0 0' }}
          destroyOnClose
          visible={visibleMenu}
          {...modalMenuFooter}
        >
          {getModalCollectionContent(menus, selectedMenuKeys, this.handleCheckMenu, true)}
        </Modal>
      </PageHeaderWrapper>
    );
  }
}

export default RoleList;
