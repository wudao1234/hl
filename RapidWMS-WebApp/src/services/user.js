import request from '@/utils/request';

export async function queryUsers(params) {
  let queryString = '/api/users?sort=id,desc&size=1000';
  if (params.payload !== undefined) {
    queryString += params.payload.query;
  }
  return request(queryString);
}

export async function queryCurrent() {
  return request('/auth/info');
}

export async function deleteUser(params) {
  return request(`/api/users/${params.id}`, {
    method: 'DELETE',
  });
}

const sendAddOrUpdateRequest = (params, method) => {
  const roles = [];
  params.roles.forEach(role => roles.push({ id: role }));
  return request('/api/users', {
    method,
    body: { ...params, roles },
  });
};

export async function updateUser(params) {
  return sendAddOrUpdateRequest(params, 'PUT');
}

export async function addUser(params) {
  return sendAddOrUpdateRequest(params, 'POST');
}

export async function resetPassword(params) {
  return request(`/api/users/${params.id}/resetPassword`, {
    method: 'PUT',
  });
}

export async function updateCurrent(params) {
  return request('/api/users/current/update', {
    method: 'PUT',
    body: params,
  });
}

export async function updatePassword(params) {
  return request('/api/users/updatePassword', {
    method: 'PUT',
    body: params,
  });
}

export async function queryUsersByRoleNames(params) {
  let queryString = '/api/users/list_by_role_names?names=';
  if (params.payload !== undefined) {
    queryString += params.payload;
  }
  return request(queryString);
}
