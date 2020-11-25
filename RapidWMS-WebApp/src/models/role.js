import {
  queryRolesTree,
  queryRoles,
  addRole,
  deleteRole,
  updateRole,
  updatePermission,
  updateMenu,
} from '@/services/role';

import { queryPermissionTree } from '@/services/permission';

import { queryMenuTree } from '@/services/sysMenu';

export default {
  namespace: 'role',

  state: {
    list: [],
  },

  effects: {
    *fetch(payload, { call, put }) {
      const response = yield call(queryRoles, payload);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *fetchTree(_, { call, put }) {
      const response = yield call(queryRolesTree);
      yield put({
        type: 'saveTree',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deleteRole : updateRole;
      } else {
        methodsName = addRole;
      }
      const response = yield call(methodsName, payload);
      if (callback) callback(response);
    },
    *updatePermission({ payload, callback }, { call }) {
      const response = yield call(updatePermission, payload);
      if (callback) callback(response);
    },
    *updateMenu({ payload, callback }, { call }) {
      const response = yield call(updateMenu, payload);
      if (callback) callback(response);
    },
    *fetchPermissionTree(_, { call, put }) {
      const response = yield call(queryPermissionTree);
      yield put({
        type: 'savePermissionTree',
        payload: response,
      });
    },
    *fetchMenuTree(_, { call, put }) {
      const response = yield call(queryMenuTree);
      yield put({
        type: 'saveMenuTree',
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
    saveTree(state, action) {
      return {
        ...state,
        list: action.payload || [],
      };
    },
    savePermissionTree(state, action) {
      return {
        ...state,
        permissions: action.payload || [],
      };
    },
    saveMenuTree(state, action) {
      return {
        ...state,
        menus: action.payload || [],
      };
    },
  },
};
