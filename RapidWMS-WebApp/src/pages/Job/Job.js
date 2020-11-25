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
  Tag,
  Switch,
} from 'antd';

import moment from 'moment';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';

import styles from './Job.less';

const FormItem = Form.Item;
const { TextArea } = Input;

@connect(({ job, loading }) => ({
  list: job.list,
  loading: loading.models.job,
}))
@Form.create()
class Job extends PureComponent {
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
      dataIndex: 'jobName',
      key: 'jobName',
      width: '10%',
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
      title: 'Bean',
      dataIndex: 'beanName',
      key: 'beanName',
      width: '5%',
      render: text => {
        return <Tag color="blue">{text}</Tag>;
      },
    },
    {
      title: '执行方法',
      dataIndex: 'methodName',
      key: 'methodName',
      width: '8%',
    },
    {
      title: '参数',
      dataIndex: 'params',
      key: 'params',
      width: '5%',
    },
    {
      title: 'Cron表达式',
      dataIndex: 'cronExpression',
      key: 'cronExpression',
      width: '10%',
    },
    {
      title: '状态',
      dataIndex: 'isPause',
      key: 'isPause',
      width: '5%',
      render: text => {
        if (text) {
          return <Tag color="red">已暂定</Tag>;
        }
        return <Tag color="green">运行中</Tag>;
      },
    },
    {
      title: '描述',
      dataIndex: 'remark',
      key: 'remark',
    },
    {
      title: '更新日期',
      dataIndex: 'updateTime',
      key: 'updateTime',
      width: '12%',
      render: text => {
        return moment(text).format('lll');
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
              title="确定删除该任务吗？"
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
      type: 'job/fetch',
    });
  }

  showModal = () => {
    this.setState({
      visible: true,
      current: undefined,
    });
  };

  showEditModal = item => {
    const current = item;
    this.setState({
      visible: true,
      current,
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
        type: 'job/submit',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success(id === '' ? '创建任务成功！' : '修改任务成功！');
            dispatch({
              type: 'job/fetch',
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
      type: 'job/submit',
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
            type: 'job/fetch',
          });
        }
      },
    });
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

    const paginationProps = {
      showSizeChanger: true,
      showQuickJumper: true,
      pageSize: 10,
      total: list.length,
    };

    const getModalContent = () => {
      if (done) {
        message.success('保存任务成功');
        this.handleDone();
      }
      return (
        <Form onSubmit={this.handleSubmit}>
          <FormItem label="任务名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('jobName', {
              rules: [{ required: true, message: '请输入任务名' }],
              initialValue: current.jobName,
            })(<Input placeholder="请输入任务名" />)}
          </FormItem>
          <FormItem label="Bean名称" {...this.formLayout} hasFeedback>
            {getFieldDecorator('beanName', {
              rules: [{ required: true, message: '请输入Bean名' }],
              initialValue: current.beanName,
            })(<Input placeholder="请输入Bean名" />)}
          </FormItem>
          <FormItem label="执行方法" {...this.formLayout} hasFeedback>
            {getFieldDecorator('methodName', {
              rules: [{ required: true, message: '请输入执行方法' }],
              initialValue: current.methodName,
            })(<Input placeholder="请输入执行方法" />)}
          </FormItem>
          <FormItem label="参数内容" {...this.formLayout}>
            {getFieldDecorator('params', {
              initialValue: current.params,
            })(<Input />)}
          </FormItem>
          <FormItem label="Cron表达式" {...this.formLayout} hasFeedback>
            {getFieldDecorator('cronExpression', {
              rules: [{ required: true, message: '请输入Cron表达式' }],
              initialValue: current.cronExpression,
            })(<Input placeholder="请输入Cron表达式" />)}
          </FormItem>
          <FormItem label="是否暂停" {...this.formLayout}>
            {getFieldDecorator('isPause', {
              rules: [{ required: true, message: '决定用户是否可用' }],
              initialValue: current.isPause !== undefined ? current.isPause : true,
            })(<Switch defaultChecked={current.isPause !== undefined ? current.isPause : true} />)}
          </FormItem>
          <FormItem label="描述" {...this.formLayout}>
            {getFieldDecorator('remark', {
              rules: [{ required: true, message: '请输入任务描述' }],
              initialValue: current.remark,
            })(<TextArea rows={3} />)}
          </FormItem>
        </Form>
      );
    };

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="定时任务"
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
              创建新任务
            </Button>
            <Table
              columns={this.columns}
              dataSource={list}
              rowKey="id"
              loading={loading}
              pagination={paginationProps}
            />
          </Card>
        </div>
        <Modal
          title={done ? null : `${current.id ? '编辑' : '添加'}任务`}
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

export default Job;
