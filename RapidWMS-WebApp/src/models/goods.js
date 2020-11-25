import { queryGoods, addGoods, updateGoods, deleteGoods } from '@/services/goods';

export default {
  namespace: 'goods',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryGoods, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteGoods : updateGoods;
      } else {
        methodsName = addGoods;
      }
      const response = yield call(methodsName, payload);
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
