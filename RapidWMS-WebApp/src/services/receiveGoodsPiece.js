import request from '@/utils/request';

export async function queryPickMatch(params) {
  const {
    payload: { search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/receive_goods_piece?';
  if (search && search !== '') queryString += `search=${search}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  return request(queryString);
}

export async function updatePickMatch(payload) {
  return request('/api/receive_goods_piece', {
    method: 'PUT',
    body: payload,
  });
}
