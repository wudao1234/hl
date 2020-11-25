import {
  addWarePosition,
  deleteWarePosition,
  queryWarePosition,
  updateWarePosition,
} from '@/services/warePosition';

export default {
  namespace: 'warePosition',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryWarePosition, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteWarePosition : updateWarePosition;
      } else {
        methodsName = addWarePosition;
      }
      const response = yield call(methodsName, payload);
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
    saveAllList(state, action) {
      return {
        ...state,
        allList: action.payload ? action.payload : [],
      };
    },
  },
};
