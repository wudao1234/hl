import {
  queryOrder,
  queryOrderForComplete,
  addOrder,
  updateOrder,
  deleteOrder,
  queryOrderDetail,
  queryOrderDetailForEdit,
  auditOrder,
  fetchStocksByIds,
  cancelOrderByIds,
  deleteOrderByIds,
  returnOrderStocksByIds,
  gatherOrderByIds,
  unGatherOrderByIds,
  completeGatherOrderByIds,
  unCompleteGatherOrderByIds,
  completeOrderByIds,
  confirmOrderByIds,
  unConfirmOrderByIds,
  completeOrder,
  updateCompleteOrder,
  importOrderByKingdee,
  importOrderByKingdee2,
  importOrderByHtml,
  importOrderByGeneral,
  queryOrderForPack,
  queryOrderForConfirm,
  printOrderByIds,
  printOriginOrderByIds,
} from '@/services/order';

export default {
  namespace: 'order',

  state: {
    list: [],
  },

  effects: {
    *fetch(state, { call, put }) {
      const response = yield call(queryOrder, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchComplete(state, { call, put }) {
      const response = yield call(queryOrderForComplete, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchForConfirm(state, { call, put }) {
      const response = yield call(queryOrderForConfirm, state);
      if (response !== undefined && response !== null) {
        yield put({
          type: 'save',
          payload: response,
        });
      }
    },
    *fetchForPack(state, { call, put }) {
      const response = yield call(queryOrderForPack, state);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *fetchDetail(state, { call, put }) {
      const response = yield call(queryOrderDetail, { id: state.payload });
      yield put({
        type: 'saveDetail',
        payload: response,
      });
    },
    *fetchDetailForEdit(state, { call, put }) {
      const response = yield call(queryOrderDetailForEdit, { id: state.payload });
      yield put({
        type: 'saveDetail',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      const methodsName = payload.isEdit ? updateOrder : addOrder;
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *delete({ payload, callback }, { call }) {
      const response = yield call(deleteOrder, payload);
      if (callback) callback(response);
    },
    *audit({ payload, callback }, { call }) {
      const response = yield call(auditOrder, payload);
      if (callback) callback(response);
    },
    *fetchStocksByIds({ payload, callback }, { call }) {
      const response = yield call(fetchStocksByIds, payload);
      if (callback) callback(response);
    },
    *cancelByIds({ payload, callback }, { call }) {
      const response = yield call(cancelOrderByIds, payload);
      if (callback) callback(response);
    },
    *deleteByIds({ payload, callback }, { call }) {
      const response = yield call(deleteOrderByIds, payload);
      if (callback) callback(response);
    },
    *returnStocksByIds({ payload, callback }, { call }) {
      const response = yield call(returnOrderStocksByIds, payload);
      if (callback) callback(response);
    },
    *gatherByIds({ payload, callback }, { call }) {
      const response = yield call(gatherOrderByIds, payload);
      if (callback) callback(response);
    },
    *unGatherByIds({ payload, callback }, { call }) {
      const response = yield call(unGatherOrderByIds, payload);
      if (callback) callback(response);
    },
    *completeGatherByIds({ payload, callback }, { call }) {
      const response = yield call(completeGatherOrderByIds, payload);
      if (callback) callback(response);
    },
    *unCompleteGatherByIds({ payload, callback }, { call }) {
      const response = yield call(unCompleteGatherOrderByIds, payload);
      if (callback) callback(response);
    },
    *confirmByIds({ payload, callback }, { call }) {
      const response = yield call(confirmOrderByIds, payload);
      if (callback) callback(response);
    },
    *unConfirmByIds({ payload, callback }, { call }) {
      const response = yield call(unConfirmOrderByIds, payload);
      if (callback) callback(response);
    },
    *complete({ payload, callback }, { call }) {
      const response = yield call(completeOrder, payload);
      if (callback) callback(response);
    },
    *updateComplete({ payload, callback }, { call }) {
      const response = yield call(updateCompleteOrder, payload);
      if (callback) callback(response);
    },
    *printByIds({ payload, callback }, { call, put }) {
      const response = yield call(printOrderByIds, payload);
      yield put({
        type: 'savePdf',
        payload: response,
      });
      if (callback) callback(response);
    },
    *printOriginByIds({ payload, callback }, { call, put }) {
      const response = yield call(printOriginOrderByIds, payload);
      yield put({
        type: 'savePdf',
        payload: response,
      });
      if (callback) callback(response);
    },
    *completeByIds({ payload, callback }, { call }) {
      const response = yield call(completeOrderByIds, payload);
      if (callback) callback(response);
    },
    *importKingdee({ payload, callback }, { call }) {
      const response = yield call(importOrderByKingdee, payload);
      if (callback) callback(response);
    },
    *importKingdee2({ payload, callback }, { call }) {
      const response = yield call(importOrderByKingdee2, payload);
      if (callback) callback(response);
    },
    *importHtml({ payload, callback }, { call }) {
      const response = yield call(importOrderByHtml, payload);
      if (callback) callback(response);
    },
    *importGeneral({ payload, callback }, { call }) {
      const response = yield call(importOrderByGeneral, payload);
      if (callback) callback(response);
    },
    *fetchNone(_, { put }) {
      yield put({
        type: 'saveNone',
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
    saveDetail(state, action) {
      return {
        ...state,
        detail: action.payload,
      };
    },
    savePdf(state, action) {
      return {
        ...state,
        pdf: action.payload,
      };
    },
    saveNone(state) {
      return {
        ...state,
        list: [],
      };
    },
  },
};
