import {
  queryStockFlows,
  queryStockFlowForOrders,
  queryByOrderId,
  queryByReceiveGoodsId,
} from '@/services/stockFlow';

export default {
  namespace: 'stockFlow',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryStockFlows, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchForOrders(state, { call, put }) {
      const response = yield call(queryStockFlowForOrders, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchByOrderId(state, { call, put }) {
      const response = yield call(queryByOrderId, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *findByReceiveGoodsId(state, { call, put }) {
      const response = yield call(queryByReceiveGoodsId, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
  },

  reducers: {
    save(state, action) {
      return {
        ...state,
        list: action.payload ? action.payload : [],
      };
    },
  },
};
