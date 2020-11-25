import request from '@/utils/request';

export async function queryDashboardToday() {
  return request('/api/kpi/dashboard_today');
}

const formatNumber = n => {
  const number = n.toString();
  return number[1] ? number : `0${number}`;
};

const formatTime = date => {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  return [year, month, day].map(formatNumber).join('-');
};

export async function queryOrderSales(params) {
  return request(`/api/kpi/order_sales?type=${params}&date=${formatTime(new Date())}`);
}
