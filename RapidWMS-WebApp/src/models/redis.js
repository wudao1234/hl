import { queryRedis, deleteAllRedis } from '@/services/redis';

export default {
  namespace: 'redis',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryRedis, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *deleteAll({ callback }, { call }) {
      const response = yield call(deleteAllRedis);
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
