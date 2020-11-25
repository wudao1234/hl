import request from '@/utils/request';

export async function queryLog(params) {
  const {
    payload: { current, pageSize, search },
  } = params;
  let queryString = `/api/logs?page=${current - 1}&size=${pageSize}&sort=id,desc`;
  if (search && search !== '') {
    queryString += `&username=${search}`;
  }
  return request(queryString);
}

export async function deleteAllLog() {
  return request('/api/logs', {
    method: 'DELETE',
  });
}
