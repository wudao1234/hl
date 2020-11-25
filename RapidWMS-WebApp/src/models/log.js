import { queryLog, deleteAllLog } from '@/services/log';

export default {
  namespace: 'log',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryLog, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *deleteAll({ callback }, { call }) {
      const response = yield call(deleteAllLog);
      if (callback) callback(response);
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
