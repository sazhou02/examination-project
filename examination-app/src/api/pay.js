import http from './index';

export const getPayment = data => {
    return http.post('/getPayment', data)
}

export const updatePayment = data => {
    return http.post('/updatePayment', data)
}

