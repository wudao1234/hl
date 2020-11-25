import {
  queryPack,
  addPack,
  updatePack,
  deletePack,
  queryPackDetail,
  queryPackStockFlows,
  auditPack,
  packagePack,
  cancelPackByIds,
  deletePackByIds,
  sendingPackByIds,
  sendingPackByMe,
  returnPackByIds,
  signedPackByIds,
  completePackByIds,
  updateCompletePackByIds,
  printPackByIds,
} from '@/services/pack';

export default {
  namespace: 'pack',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryPack, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchDetail(state, { call, put }) {
      const response = yield call(queryPackDetail, { id: state.payload });
      yield put({
        type: 'saveDetail',
        payload: response,
      });
    },
    *fetchStockFlows(state, { call, put }) {
      const response = yield call(queryPackStockFlows, { id: state.payload });
      yield put({
        type: 'saveStockFlows',
        payload: response,
      });
    },
    *package({ payload, callback }, { call }) {
      const response = yield call(packagePack, payload);
      if (callback) callback(response);
    },
    *submit({ payload, callback }, { call }) {
      const methodsName = payload.isEdit ? updatePack : addPack;
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *delete({ payload, callback }, { call }) {
      const response = yield call(deletePack, payload);
      if (callback) callback(response);
    },
    *audit({ payload, callback }, { call }) {
      const response = yield call(auditPack, payload);
      if (callback) callback(response);
    },
    *cancelByIds({ payload, callback }, { call }) {
      const response = yield call(cancelPackByIds, payload);
      if (callback) callback(response);
    },
    *deleteByIds({ payload, callback }, { call }) {
      const response = yield call(deletePackByIds, payload);
      if (callback) callback(response);
    },
    *sendingByIds({ payload, callback }, { call }) {
      const response = yield call(sendingPackByIds, payload);
      if (callback) callback(response);
    },
    *sendingByMe({ payload, callback }, { call }) {
      const response = yield call(sendingPackByMe, payload);
      if (callback) callback(response);
    },
    *returnByIds({ payload, callback }, { call }) {
      const response = yield call(returnPackByIds, payload);
      if (callback) callback(response);
    },
    *signedByIds({ payload, callback }, { call }) {
      const response = yield call(signedPackByIds, payload);
      if (callback) callback(response);
    },
    *completeByIds({ payload, callback }, { call }) {
      const response = yield call(completePackByIds, payload);
      if (callback) callback(response);
    },
    *updateCompleteByIds({ payload, callback }, { call }) {
      const response = yield call(updateCompletePackByIds, payload);
      if (callback) callback(response);
    },
    *printByIds({ payload, callback }, { call, put }) {
      const response = yield call(printPackByIds, payload);
      yield put({
        type: 'savePdf',
        payload: response,
      });
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
    saveStockFlows(state, action) {
      return {
        ...state,
        stockFlows: action.payload,
      };
    },
    savePdf(state, action) {
      return {
        ...state,
        pdf: action.payload,
      };
    },
  },
};
