import { queryStore, addStore, updateStore, deleteStore, queryAllStore } from '@/services/store';

export default {
  namespace: 'store',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryStore, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteStore : updateStore;
      } else {
        methodsName = addStore;
      }
      const response = yield call(methodsName, payload);
      if (callback) {
        callback(response);
      }
    },
    *fetchAll(_, { call, put }) {
      const response = yield call(queryAllStore);
      yield put({
        type: 'saveList',
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
    saveList(state, action) {
      return {
        ...state,
        allList: action.payload ? action.payload : [],
      };
    },
  },
};
