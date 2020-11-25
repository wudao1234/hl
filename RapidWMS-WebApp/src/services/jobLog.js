import request from '@/utils/request';

export async function queryJobLog(params) {
  const {
    payload: { current, pageSize, search },
  } = params;
  let queryString = `/api/jobLogs?page=${current - 1}&size=${pageSize}&sort=id,desc`;
  if (search && search !== '') {
    queryString += `&username=${search}`;
  }
  return request(queryString);
}

export async function deleteAllJobLog() {
  return request('/api/jobLogs', {
    method: 'DELETE',
  });
}
