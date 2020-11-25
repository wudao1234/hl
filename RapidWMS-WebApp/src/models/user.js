import {
  queryUsers,
  queryCurrent,
  deleteUser,
  updateUser,
  addUser,
  resetPassword,
  updateCurrent,
  updatePassword,
  queryUsersByRoleNames,
} from '@/services/user';

export default {
  namespace: 'user',

  state: {
    list: [],
    currentUser: {},
  },

  effects: {
    *fetch(payload, { call, put }) {
      const response = yield call(queryUsers, payload);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *fetchCurrent(_, { call, put }) {
      const response = yield call(queryCurrent);
      yield put({
        type: 'saveCurrentUser',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deleteUser : updateUser;
      } else {
        methodsName = addUser;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *resetPassword({ payload, callback }, { call }) {
      const response = yield call(resetPassword, payload);
      if (callback) callback(response);
    },
    *updateCurrent({ payload, callback }, { call }) {
      const response = yield call(updateCurrent, payload);
      if (callback) callback(response);
    },
    *updatePassword({ payload, callback }, { call }) {
      const response = yield call(updatePassword, payload);
      if (callback) callback(response);
    },
    *fetchByRoleNames(payload, { call, put }) {
      const response = yield call(queryUsersByRoleNames, payload);
      yield put({
        type: 'saveListByRoleNames',
        payload: response,
      });
    },
  },

  reducers: {
    save(state, action) {
      return {
        ...state,
        list: action.payload ? action.payload.content : [],
      };
    },
    saveCurrentUser(state, action) {
      return {
        ...state,
        currentUser: action.payload || {},
      };
    },
    changeNotifyCount(state, action) {
      return {
        ...state,
        currentUser: {
          ...state.currentUser,
          notifyCount: action.payload.totalCount,
          unreadCount: action.payload.unreadCount,
        },
      };
    },
    saveListByRoleNames(state, action) {
      return {
        ...state,
        listByRoleNames: action.payload ? action.payload : [],
      };
    },
  },
};
