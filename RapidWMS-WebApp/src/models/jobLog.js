import { queryJobLog, deleteAllJobLog } from '@/services/jobLog';

export default {
  namespace: 'jobLog',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryJobLog, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *deleteAll({ callback }, { call }) {
      const response = yield call(deleteAllJobLog);
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
