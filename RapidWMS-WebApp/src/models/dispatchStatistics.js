import { queryPickMatch, statisticsAll } from '@/services/dispatchStatistics';

export default {
  namespace: 'dispatchStatistics',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryPickMatch, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchAll(state, { call, put }) {
      const response = yield call(statisticsAll, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
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
