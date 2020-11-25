import { queryDashboardToday, queryOrderSales } from '@/services/chart';

export default {
  namespace: 'chart',

  state: {
    confirmOrdersToday: 0,
    orderCountToday: 0,
    packCountDetailSending: 0,
    packCountDetailToday: 0,
    packCountSending: 0,
    packCountToday: 0,
    totalPriceToday: 0,
    unConfirmOrders: 0,
    visitData: [],
    visitData2: [],
    salesData: [],
    searchData: [],
    offlineData: [],
    offlineChartData: [],
    salesTypeData: [],
    salesTypeDataOnline: [],
    salesTypeDataOffline: [],
    radarData: [],
    loading: false,
  },

  effects: {
    *fetch(_, { call, put }) {
      const response = yield call(queryDashboardToday);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *fetchByDateRange({ payload }, { call, put }) {
      const response = yield call(queryOrderSales, payload);
      yield put({
        type: 'save',
        payload: response,
      });
    },
  },

  reducers: {
    save(state, { payload }) {
      return {
        ...state,
        ...payload,
      };
    },
    clear() {
      return {
        visitData: [],
        visitData2: [],
        salesData: [],
        searchData: [],
        offlineData: [],
        offlineChartData: [],
        salesTypeData: [],
        salesTypeDataOnline: [],
        salesTypeDataOffline: [],
        radarData: [],
      };
    },
  },
};
