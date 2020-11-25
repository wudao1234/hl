import React, { Component } from 'react';
import { connect } from 'dva';
import { formatMessage, FormattedMessage } from 'umi/locale';
import { Alert, Checkbox, message, notification } from 'antd';
import Login from '@/components/Login';
import styles from './Login.less';
import { removeToken } from '../../models/login';

const md5 = require('md5');

const { Tab, UserName, Password, Submit } = Login;

const loginNameStoreName = 'loginName';

@connect(({ login, loading }) => ({
  login,
  submitting: loading.effects['login/login'],
}))
class LoginPage extends Component {
  state = {
    type: 'account',
    autoLogin: true,
  };

  onTabChange = type => {
    this.setState({ type });
  };

  handleSubmit = (err, values) => {
    removeToken();
    const { userName, password } = values;
    const { autoLogin } = this.state;
    if (!err) {
      if (autoLogin) {
        localStorage.setItem(loginNameStoreName, userName);
      }
      const { dispatch } = this.props;

      dispatch({
        type: 'login/login',
        payload: {
          username: userName,
          password: md5(password),
        },
        callback: response => {
          if (response.status === 400) {
            notification.error({
              message: '登录发生错误',
              description: response.message,
            });
          } else {
            message.success('登录成功！');
          }
        },
      });
    }
  };

  changeAutoLogin = e => {
    this.setState({
      autoLogin: e.target.checked,
    });
  };

  renderMessage = content => (
    <Alert style={{ marginBottom: 24 }} message={content} type="error" showIcon />
  );

  render() {
    const { login, submitting } = this.props;
    const { type, autoLogin } = this.state;
    const loginName = localStorage.getItem(loginNameStoreName);

    return (
      <div className={styles.main}>
        <Login
          defaultActiveKey={type}
          onTabChange={this.onTabChange}
          onSubmit={this.handleSubmit}
          ref={form => {
            this.loginForm = form;
          }}
        >
          <Tab key="account" tab={formatMessage({ id: 'app.login.tab-login-credentials' })}>
            {login.status === 'error' &&
              login.type === 'account' &&
              !submitting &&
              this.renderMessage(formatMessage({ id: 'app.login.message-invalid-credentials' }))}
            <UserName
              name="userName"
              defaultValue={loginName}
              placeholder={`${formatMessage({ id: 'app.login.userName' })}: 请输入用户名`}
              rules={[
                {
                  required: true,
                  message: formatMessage({ id: 'validation.userName.required' }),
                },
              ]}
            />
            <Password
              name="password"
              placeholder={`${formatMessage({ id: 'app.login.password' })}: 请输入密码`}
              rules={[
                {
                  required: true,
                  message: formatMessage({ id: 'validation.password.required' }),
                },
              ]}
              onPressEnter={e => {
                e.preventDefault();
                this.loginForm.validateFields(this.handleSubmit);
              }}
            />
          </Tab>
          <div>
            <Checkbox checked={autoLogin} onChange={this.changeAutoLogin}>
              记住登录名
            </Checkbox>
          </div>
          <Submit loading={submitting}>
            <FormattedMessage id="app.login.login" />
          </Submit>
        </Login>
      </div>
    );
  }
}

export default LoginPage;
