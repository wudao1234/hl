import request from '@/utils/request';

export async function queryPickMatch(params) {
  const {
    payload: { pageSize, currentPage },
  } = params;

  let queryString = '/api/pick_match?';
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  return request(queryString);
}

export async function updatePickMatch(payload) {
  return request('/api/pick_match', {
    method: 'PUT',
    body: payload,
  });
}
