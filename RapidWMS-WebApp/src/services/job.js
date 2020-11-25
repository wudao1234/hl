import request from '@/utils/request';

export async function queryJob() {
  return request('/api/jobs?sort=id,desc');
}

export async function addJob(payload) {
  return request('/api/jobs', {
    method: 'POST',
    body: payload,
  });
}

export async function updateJob(payload) {
  return request('/api/jobs', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteJob(params) {
  return request(`/api/jobs/${params.id}`, {
    method: 'DELETE',
  });
}
