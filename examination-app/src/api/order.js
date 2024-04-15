import http from './index';

export const getOrderList = data => {
  return http.post("/examination_order/list", data)
}

export const getReportDeatil = data => {
  return http.post("/examination_result/getReport", data)
}