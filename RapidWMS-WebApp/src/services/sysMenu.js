import request from '@/utils/request';

export async function queryCurrentMenus() {
  return request('/api/menus/build');
}

export async function queryMenuTree() {
  return request('/api/menus/tree');
}

export async function queryMenu() {
  return request('/api/menus');
}

export async function addMenu(payload) {
  return request('/api/menus', {
    method: 'POST',
    body: payload,
  });
}

export async function updateMenu(payload) {
  return request('/api/menus', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteMenu(params) {
  return request(`/api/menus/${params.id}`, {
    method: 'DELETE',
  });
}
