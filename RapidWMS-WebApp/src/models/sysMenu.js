import { queryMenu, addMenu, updateMenu, deleteMenu } from '@/services/sysMenu';

export default {
  namespace: 'sysMenu',

  state: {
    list: [],
  },

  effects: {
    *fetch(_, { call, put }) {
      const response = yield call(queryMenu);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deleteMenu : updateMenu;
      } else {
        methodsName = addMenu;
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
