import {
  addAddressType,
  deleteAddressType,
  queryAllAddressType,
  queryAddressType,
  updateAddressType,
} from '@/services/logisticsDetail';

export default {
  namespace: 'logisticsDetail',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryAddressType, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteAddressType : updateAddressType;
      } else {
        methodsName = addAddressType;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *fetchAll(_, { call, put }) {
      const response = yield call(queryAllAddressType);
      yield put({
        type: 'saveAllList',
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
    saveAllList(state, action) {
      return {
        ...state,
        allList: action.payload ? action.payload : [],
      };
    },
  },
};
