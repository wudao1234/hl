import {
  queryStock,
  singleStock,
  addStock,
  updateStock,
  deleteStock,
  activateStock,
  singleOperateStock,
  multipleOperateStock,
} from '@/services/stock';

export default {
  namespace: 'stock',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryStock, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *singleFetch(state, { call, put }) {
      const response = yield call(singleStock, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deleteStock : updateStock;
      } else {
        methodsName = addStock;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *activate({ payload, callback }, { call }) {
      const response = yield call(activateStock, payload);
      if (callback) callback(response);
    },
    *singleOperate({ payload, callback }, { call }) {
      const response = yield call(singleOperateStock, payload);
      if (callback) callback(response);
    },
    *multipleOperate({ payload, callback }, { call }) {
      const response = yield call(multipleOperateStock, payload);
      if (callback) callback(response);
    },
    *fetchNone(_, { put }) {
      yield put({
        type: 'saveNone',
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
    saveNone(state) {
      return {
        ...state,
        list: [],
      };
    },
  },
};
