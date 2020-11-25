import request from '@/utils/request';

export async function queryRolesTree() {
  return request('/api/roles/tree');
}

export async function queryRoles(params) {
  let queryString = '/api/roles?sort=id,desc&size=1000';
  if (params.payload !== undefined) {
    queryString += params.payload.query;
  }
  return request(queryString);
}

export async function addRole(payload) {
  return request('/api/roles', {
    method: 'POST',
    body: payload,
  });
}

export async function updateRole(payload) {
  return request('/api/roles', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteRole(params) {
  return request(`/api/roles/${params.id}`, {
    method: 'DELETE',
  });
}

export async function updatePermission(params) {
  return request('/api/roles/permission', {
    method: 'PUT',
    body: params,
  });
}

export async function updateMenu(params) {
  return request('/api/roles/menu', {
    method: 'PUT',
    body: params,
  });
}
