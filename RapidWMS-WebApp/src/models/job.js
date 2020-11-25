import { queryJob, addJob, updateJob, deleteJob } from '@/services/job';

export default {
  namespace: 'job',

  state: {
    list: [],
  },

  effects: {
    *fetch(_, { call, put }) {
      const response = yield call(queryJob);
      yield put({
        type: 'save',
        payload: response,
      });
    },
    *submit({ payload, callback }, { call }) {
      let methodsName;
      if (payload.id) {
        methodsName = Object.keys(payload).length === 1 ? deleteJob : updateJob;
      } else {
        methodsName = addJob;
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
