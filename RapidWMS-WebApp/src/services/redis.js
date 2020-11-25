import request from '@/utils/request';

export async function queryRedis(params) {
  const {
    payload: { current, pageSize, search },
  } = params;
  let queryString = `/api/redis?page=${current - 1}&size=${pageSize}`;
  if (search && search !== '') {
    queryString += `&key=${search}`;
  } else {
    queryString += `&key=*`;
  }
  return request(queryString);
}

export async function deleteAllRedis() {
  return request('/api/redis/all', {
    method: 'DELETE',
  });
}
