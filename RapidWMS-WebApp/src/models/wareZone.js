import {
  addWareZone,
  deleteWareZone,
  queryAllWareZone,
  queryWareZone,
  updateWareZone,
  queryTree,
} from '@/services/wareZone';

export default {
  namespace: 'wareZone',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryWareZone, state);
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
        methodsName = Object.keys(payload).length === 1 ? deleteWareZone : updateWareZone;
      } else {
        methodsName = addWareZone;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *fetchAll(_, { call, put }) {
      const response = yield call(queryAllWareZone);
      yield put({
        type: 'saveAllList',
        payload: response,
      });
    },
    *fetchTree(_, { call, put }) {
      const response = yield call(queryTree);
      yield put({
        type: 'saveTree',
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
    saveTree(state, action) {
      return {
        ...state,
        tree: action.payload ? action.payload : [],
      };
    },
  },
};
