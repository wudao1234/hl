import queryPickMatch from '@/services/receiveGoodsPieceStatistics';

export default {
  namespace: 'receiveGoodsPieceStatistics',

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
