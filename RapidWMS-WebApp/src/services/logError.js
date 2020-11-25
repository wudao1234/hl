import request from '@/utils/request';

/* eslint-disable */
export async function queryLogError(params) {
  /* eslint-enable */
  const {
    payload: { current, pageSize, search },
  } = params;
  let queryString = `/api/logs/error?page=${current - 1}&size=${pageSize}&sort=id,desc`;
  if (search && search !== '') {
    queryString += `&username=${search}`;
  }
  return request(queryString);
}
