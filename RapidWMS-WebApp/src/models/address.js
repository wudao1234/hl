import {
  queryAddress,
  addAddress,
  updateAddress,
  deleteAddress,
  queryAllAddress,
} from '@/services/address';

export default {
  namespace: 'address',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryAddress, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteAddress : updateAddress;
      } else {
        methodsName = addAddress;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *fetchAll(_, { call, put }) {
      const response = yield call(queryAllAddress);
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
