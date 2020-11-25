import React, { Component, Fragment } from 'react';
import { formatMessage, FormattedMessage } from 'umi/locale';
import { Form, Input, Upload, Button, notification, message } from 'antd';
import { connect } from 'dva';
import { findDOMNode } from 'react-dom';
import { getToken } from '../../models/login';

import styles from './BaseView.less';

const FormItem = Form.Item;

@connect(({ user }) => ({
  currentUser: user.currentUser,
}))
@Form.create()
class BaseView extends Component {
  getAvatarURL() {
    const { currentUser } = this.props;
    if (currentUser.avatar) {
      return currentUser.avatar;
    }
    return `/avatar/no_avatar.jpg`;
  }

  handleSubmit = e => {
    e.preventDefault();
    const { dispatch, form } = this.props;
    const { currentUser } = this.props;
    const { id } = currentUser;

    setTimeout(() => this.updateBtn.blur(), 0);
    form.validateFields((err, fieldsValue) => {
      if (err) {
        return;
      }
      dispatch({
        type: 'user/updateCurrent',
        payload: { id, ...fieldsValue },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '操作发生错误',
              description: response.message,
            });
          } else {
            message.success('修改基础信息成功！');
          }
        },
      });
    });
  };

  handleUpload = info => {
    const { dispatch } = this.props;
    if (info.file.status === 'done') {
      message.success('上传头像成功！');
      dispatch({
        type: 'user/fetchCurrent',
      });
    } else if (info.file.status === 'error') {
      message.error('上传失败！');
    }
  };

  render() {
    const {
      currentUser,
      form: { getFieldDecorator },
    } = this.props;

    const uploadProps = {
      name: 'avatar',
      action: '/api/users/updateAvatar',
      headers: {
        Authorization: `Bearer ${getToken()}`,
      },
    };

    return (
      <div className={styles.baseView}>
        <div className={styles.left}>
          <Form layout="vertical" onSubmit={this.handleSubmit} hideRequiredMark>
            <FormItem label={formatMessage({ id: 'app.settings.basic.nickname' })} hasFeedback>
              {getFieldDecorator('username', {
                rules: [
                  { required: true, message: '请输入用户名' },
                  { min: 2, max: 20, message: '长度介于2和20之间' },
                ],
                initialValue: currentUser.username,
              })(<Input disabled placeholder="用户名长度介于2和20之间" />)}
            </FormItem>
            <FormItem label="电子邮箱" hasFeedback>
              {getFieldDecorator('email', {
                rules: [
                  { required: true, message: '请输入电子邮箱' },
                  {
                    pattern: new RegExp(
                      '^[a-z0-9]+([._\\\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$'
                    ),
                    message: '邮箱格式要求字母全小写',
                  },
                ],
                initialValue: currentUser.email,
              })(<Input disabled />)}
            </FormItem>
            <Button htmlType="submit" type="primary">
              <FormattedMessage
                id="app.settings.basic.update"
                defaultMessage="Update Information"
                ref={component => {
                  /* eslint-disable */
                  this.updateBtn = findDOMNode(component);
                  /* eslint-enable */
                }}
              />
            </Button>
          </Form>
        </div>
        <div className={styles.right}>
          <Fragment>
            <div className={styles.avatar_title}>
              <FormattedMessage id="app.settings.basic.avatar" defaultMessage="Avatar" />
            </div>
            <div className={styles.avatar}>
              <img src={this.getAvatarURL()} alt="avatar" />
            </div>
            <Upload {...uploadProps} onChange={this.handleUpload}>
              <div className={styles.button_view}>
                <Button icon="upload">
                  <FormattedMessage
                    id="app.settings.basic.change-avatar"
                    defaultMessage="Change avatar"
                  />
                </Button>
              </div>
            </Upload>
          </Fragment>
        </div>
      </div>
    );
  }
}

export default BaseView;
