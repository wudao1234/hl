import React, { Component } from 'react';
import { FormattedMessage } from 'umi/locale';
import { Form, Input, Button, message, notification } from 'antd';
import { connect } from 'dva';
import { findDOMNode } from 'react-dom';
import router from 'umi/router';

import styles from './SecurityView.less';

const FormItem = Form.Item;
const md5 = require('md5');

@connect(({ user }) => ({
  currentUser: user.currentUser,
}))
@Form.create()
class SecurityView extends Component {
  handleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;

    setTimeout(() => this.updateBtn.blur(), 0);
    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      const { oldPassword, newPassword } = fieldsValue;
      const payload = { oldPassword: md5(oldPassword), newPassword: md5(newPassword) };
      dispatch({
        type: 'user/updatePassword',
        payload,
        callback: response => {
          if (response && response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            router.push('/user/login');
            message.success('修改密码成功，请用新密码重新登录！');
          }
        },
      });
    });
  };

  render() {
    const {
      form: { getFieldDecorator },
    } = this.props;
    return (
      <div className={styles.baseView}>
        <div className={styles.left}>
          <Form layout="vertical" onSubmit={this.handleSubmit} hideRequiredMark>
            <FormItem label="原密码">
              {getFieldDecorator('oldPassword', {
                rules: [
                  { required: true, message: '请输入当前用户密码' },
                  { min: 6, message: '密码不少于6位' },
                ],
              })(<Input.Password placeholder="密码不少于6位" />)}
            </FormItem>
            <FormItem label="新密码">
              {getFieldDecorator('newPassword', {
                rules: [
                  { required: true, message: '请输入新密码' },
                  { min: 6, message: '密码不少于6位' },
                ],
              })(<Input.Password placeholder="密码不少于6位" />)}
            </FormItem>
            <Button htmlType="submit" type="primary">
              <FormattedMessage
                id="button.system.updatePassword"
                defaultMessage="更新密码"
                ref={component => {
                  /* eslint-disable */
                  this.updateBtn = findDOMNode(component);
                  /* eslint-enable */
                }}
              />
            </Button>
          </Form>
        </div>
      </div>
    );
  }
}

export default SecurityView;
