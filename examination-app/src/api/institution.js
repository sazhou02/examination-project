import http from './index';

export const getDistrict = data => {
  return http.get('/district/list')
}
