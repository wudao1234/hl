import {
  queryReceiveGoods,
  addReceiveGoods,
  updateReceiveGoods,
  deleteReceiveGoods,
  queryReceiveGoodsDetail,
  auditReceiveGoods,
  cancelAuditReceiveGoods,
  putInStorage,
} from '@/services/unloadGoods';

export default {
  namespace: 'unloadGoods',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryReceiveGoods, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchDetail(state, { call, put }) {
      const response = yield call(queryReceiveGoodsDetail, { id: state.payload });
      yield put({
        type: 'saveDetail',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      const methodsName = payload.isEdit ? updateReceiveGoods : addReceiveGoods;
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *putInStorage({ payload, callback }, { call }) {
      const response = yield call(putInStorage, payload);
      if (callback) callback(response);
    },
    *delete({ payload, callback }, { call }) {
      const response = yield call(deleteReceiveGoods, payload);
      if (callback) callback(response);
    },
    *audit({ payload, callback }, { call }) {
      const response = yield call(auditReceiveGoods, payload);
      if (callback) callback(response);
    },
    *cancelAudit({ payload, callback }, { call }) {
      const response = yield call(cancelAuditReceiveGoods, payload);
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
    saveDetail(state, action) {
      return {
        ...state,
        detail: action.payload,
      };
    },
  },
};
