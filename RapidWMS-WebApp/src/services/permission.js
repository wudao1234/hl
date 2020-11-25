import request from '@/utils/request';

export async function queryPermissionTree() {
  return request('/api/permissions/tree');
}

export async function queryPermission() {
  return request('/api/permissions');
}

export async function addPermission(payload) {
  return request('/api/permissions', {
    method: 'POST',
    body: payload,
  });
}

export async function updatePermission(payload) {
  return request('/api/permissions', {
    method: 'PUT',
    body: payload,
  });
}

export async function deletePermission(params) {
  return request(`/api/permissions/${params.id}`, {
    method: 'DELETE',
  });
}
