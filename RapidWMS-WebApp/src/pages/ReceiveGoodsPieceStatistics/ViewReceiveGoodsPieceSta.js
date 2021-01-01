import React, { PureComponent } from 'react';
import { Card, Form, Table, Tag } from 'antd';
import moment from 'moment';
import styles from './ReceiveGoodsPieceStatistics.less';

@Form.create()
class ViewReceiveGoodsPieceSta extends PureComponent {
  columns = [
    {
      title: '#',
      width: '3%',
      key: 'index',
      render: (text, record, index) => `${index + 1}`,
    },
    {
      title: '类别',
      dataIndex: 'type',
      key: 'type',
      width: '1%',
      render: text => {
        let result;
        let color;
        switch (text) {
          case 'UNLOAD':
            result = '收货';
            color = '#DC143C';
            break;
          case 'PUT_IN':
            result = '入库';
            color = '#DDA0DD';
            break;
          default:
            result = '未知';
            color = '#696969';
            break;
        }
        return <Tag color={color}>{result}</Tag>;
      },
    },
    {
      title: '计件单价',
      dataIndex: 'price',
      key: 'price',
      width: '15%',
    },
    {
      title: '件数',
      dataIndex: 'packages',
      key: 'packages',
      width: '10%',
    },
    {
      title: '员工系数',
      dataIndex: 'staffPrice',
      key: 'staffPrice',
      width: '10%',
    },
    {
      title: '总分数',
      dataIndex: 'score',
      key: 'score',
      width: '10%',
    },
    {
      title: '时间',
      dataIndex: 'createTime',
      key: 'createTime',
      width: '1%',
      sorter: true,
      render: text => {
        return <Tag>{moment(text).format('YYYY-MM-DD/HH:mm')}</Tag>;
      },
    },
  ];

  render() {
    const {
      location: {
        query: { receiveGoodsPieces },
      },
    } = this.props;
    return (
      <div className={styles.standardList}>
        <Card
          bordered={false}
          title="入库计件统计明细"
          style={{ marginTop: 24 }}
          bodyStyle={{ padding: '0 32px 40px 32px' }}
        >
          <Table columns={this.columns} dataSource={receiveGoodsPieces} rowKey="id" size="small" />
        </Card>
      </div>
    );
  }
}

export default ViewReceiveGoodsPieceSta;
