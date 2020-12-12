import request from '@/utils/request';

export async function queryPickMatch(params) {
  const {
    payload: { search, startDate, endDate, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/pick_match/statistics?';
  if (search && search !== '') queryString += `search=${search}&`;
  if (startDate && startDate !== '' && endDate && endDate !== '')
    queryString += `startDate=${startDate}&endDate=${endDate}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
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
