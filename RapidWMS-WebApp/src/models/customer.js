import {
  addCustomer,
  deleteCustomer,
  queryAllCustomer,
  queryCustomer,
  updateCustomer,
  queryMyCustomer,
} from '@/services/customer';

export default {
  namespace: 'customer',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryCustomer, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteCustomer : updateCustomer;
      } else {
        methodsName = addCustomer;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *fetchAll(_, { call, put }) {
      const response = yield call(queryAllCustomer);
      yield put({
        type: 'saveList',
        payload: response,
      });
    },
    *fetchMy(_, { call, put }) {
      const response = yield call(queryMyCustomer);
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
