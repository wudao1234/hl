import { queryPickMatch, updatePickMatch } from '@/services/dispatch';

export default {
  namespace: 'dispatch',

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
    *submit({ payload, callback }, { call }) {
      const response = yield call(updatePickMatch, payload);
      if (callback) callback(response);
    },
  },

  reducers: {
    save(state, action) {
      console.log(action);
      return {
        ...state,
        list: action.payload ? action.payload : [],
      };
    },
    saveAllList(state, action) {
      return {
        ...state,
        allList: action.payload ? action.payload : [],
      };
    },
  },
};
