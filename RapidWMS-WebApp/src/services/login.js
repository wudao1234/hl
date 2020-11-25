import request from '@/utils/request';

export async function accountLogin(params) {
  return request('/auth/login', {
    method: 'POST',
    body: params,
  });
}
