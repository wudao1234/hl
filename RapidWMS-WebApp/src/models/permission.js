import {
  queryPermission,
  addPermission,
  updatePermission,
  deletePermission,
} from '@/services/permission';

export default {
  namespace: 'permission',

  state: {
    list: [],
  },

  effects: {
    *fetch(_, { call, put }) {
      const response = yield call(queryPermission);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deletePermission : updatePermission;
      } else {
        methodsName = addPermission;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
  },

  reducers: {
    save(state, action) {
      return {
        ...state,
        list: action.payload ? action.payload.content : [],
      };
    },
  },
};
