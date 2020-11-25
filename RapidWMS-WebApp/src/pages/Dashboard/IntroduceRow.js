import React, { memo } from 'react';
import { Col, Icon, Row, Tooltip } from 'antd';
import { ChartCard, Field } from '@/components/Charts';
import numeral from 'numeral';
import accounting from 'accounting';

const topColResponsiveProps = {
  xs: 24,
  sm: 12,
  md: 12,
  lg: 12,
  xl: 6,
  style: { marginBottom: 24 },
};

const IntroduceRow = memo(({ loading, chart }) => (
  <Row gutter={24}>
    <Col {...topColResponsiveProps}>
      <ChartCard
        bordered={false}
        title="今日销售额"
        action={
          <Tooltip title="今日所有订单之和">
            <Icon type="info-circle-o" />
          </Tooltip>
        }
        loading={loading}
        total={() => accounting.formatMoney(chart.totalPriceToday, '￥')}
        footer={
          <Field label="今日订单数" value={`${numeral(chart.orderCountToday).format('0,0')}`} />
        }
        contentHeight={46}
      />
    </Col>

    <Col {...topColResponsiveProps}>
      <ChartCard
        bordered={false}
        loading={loading}
        title="待分拣订单数"
        action={
          <Tooltip title="未进行拣货确认的订单">
            <Icon type="info-circle-o" />
          </Tooltip>
        }
        total={numeral(chart.unConfirmOrders).format('0,0')}
        footer={
          <Field label="今日已分拣订单数" value={numeral(chart.confirmOrdersToday).format('0,0')} />
        }
        contentHeight={46}
      />
    </Col>
    <Col {...topColResponsiveProps}>
      <ChartCard
        bordered={false}
        loading={loading}
        title="今日打包数量"
        action={
          <Tooltip title="今日打包数量">
            <Icon type="info-circle-o" />
          </Tooltip>
        }
        total={numeral(chart.packCountDetailToday).format('0,0')}
        footer={<Field label="今日打包单数" value={numeral(chart.packCountToday).format('0,0')} />}
        contentHeight={46}
      />
    </Col>
    <Col {...topColResponsiveProps}>
      <ChartCard
        loading={loading}
        bordered={false}
        title="待派送打包数量"
        action={
          <Tooltip title="待派送打包数量">
            <Icon type="info-circle-o" />
          </Tooltip>
        }
        total={numeral(chart.packCountDetailSending).format('0,0')}
        footer={
          <Field label="待派送打包单数" value={numeral(chart.packCountSending).format('0,0')} />
        }
        contentHeight={46}
      />
    </Col>
  </Row>
));

export default IntroduceRow;
