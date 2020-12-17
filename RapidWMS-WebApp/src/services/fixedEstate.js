import request from '@/utils/request';

const basePath = 'fixed_estate';

export async function query(params) {
  const {
    payload: { search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = `/api/${basePath}?`;
  if (search && search !== '') queryString += `search=${search}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  console.log(queryString);
  return request(queryString);
}

export async function add(payload) {
  return request(`/api/${basePath}`, {
    method: 'POST',
    body: payload,
  });
}

export async function update(payload) {
  return request(`/api/${basePath}`, {
    method: 'PUT',
    body: payload,
  });
}

export async function del(params) {
  return request(`/api/${basePath}/${params.id}`, {
    method: 'DELETE',
  });
}
