import http from './index';

export const getInstList = (data) => {
    return http.post(`examination_center/list`, data)
}

export const getInstCount = () => {
    return http.post(`examination_center/count`);
}
