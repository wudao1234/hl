import React, { PureComponent } from 'react';
import { Card } from 'antd';
import PageHeaderWrapper from '@/components/PageHeaderWrapper';
import SockJS from 'sockjs-client';
import Stomp from 'stompjs';
import { apiHost } from '@/defaultSettings';

import { findDOMNode } from 'react-dom';
import styles from './Console.less';

class Console extends PureComponent {
  state = {
    data: [],
  };

  socketApi = `${apiHost}/websocket?token=kl`;

  componentDidMount() {
    this.initWebSocket();
  }

  /* eslint-disable */
  componentDidUpdate(prevProps, prevState, snapshot) {
    /* eslint-enable */
    if (this.consoleDiv !== null) {
      this.consoleDiv.scrollTo(0, this.consoleDiv.scrollHeight);
    }
  }

  componentWillUnmount() {
    this.disconnect();
  }

  initWebSocket = () => {
    this.connection();
    // 断开重连机制,尝试发送消息,捕获异常发生时重连
    this.timer = window.setInterval(() => {
      try {
        this.stompClient.send('test');
      } catch (err) {
        console.log(`失去连接: ${err}`);
        this.connection();
      }
    }, 5000);
  };

  connection = () => {
    const socket = new SockJS(this.socketApi); // 连接服务端提供的通信接口，连接以后才可以订阅广播消息和个人消息
    // 获取STOMP子协议的客户端对象
    this.stompClient = Stomp.over(socket);
    // 定义客户端的认证信息,按需求配置
    const headers = {
      token: 'k1',
    };
    // 向服务器发起websocket连接
    this.stompClient.connect(
      headers,
      () => {
        this.stompClient.subscribe('/topic/logMsg', msg => {
          // 订阅服务端提供的某个topic
          const content = JSON.parse(msg.body);
          const { data } = this.state;
          this.setState({
            data: data.concat(content),
          });
        });
      },
      err => {
        // 连接发生错误时的处理函数
        console.log(err);
      }
    );
  };

  disconnect = () => {
    if (this.stompClient != null) {
      this.stompClient.disconnect();
      window.clearInterval(this.timer);
    }
  };

  format = item => {
    const timeColor = '#AB0D17';
    const threadColor = '#66AB0D';
    const classColor = '#0D66AB';
    const levelColor = '#A00DAB';
    const bodyColor = '#DDDDDD';

    const timestamp = `<span style="color:${timeColor}">${item.timestamp}</span>`;
    const threadName = `<span style="color:${threadColor}">${item.threadName}</span>`;
    const className = `<span style="color:${classColor}">${item.className}</span>`;
    const level = `<span style="color:${levelColor}">${item.level}</span>`;
    const body = `<span style="color:${bodyColor}">${item.body}</span>`;

    return `${timestamp} ${threadName} ${level} ${className} ${body} <br>`;
  };

  render() {
    const { data } = this.state;

    return (
      <PageHeaderWrapper>
        <div className={styles.standardList}>
          <Card
            bordered={false}
            title="服务器实时日志"
            style={{ marginTop: 24 }}
            bodyStyle={{ padding: '0 32px 40px 32px', background: '#222222', color: '#eeeeee' }}
            headStyle={{ background: '#222222', color: '#eeeeee' }}
          >
            <div
              dangerouslySetInnerHTML={{
                __html: data.map(item => {
                  return this.format(item);
                }),
              }}
              style={{ overflow: 'auto', height: '500px' }}
              ref={component => {
                /* eslint-disable */
                this.consoleDiv = findDOMNode(component);
                /* eslint-enable */
              }}
            />
          </Card>
        </div>
      </PageHeaderWrapper>
    );
  }
}

export default Console;
