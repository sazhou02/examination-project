import http from './index';
const domin  = '/user';

export const login = user => {
    return http.post(`/userLogin`, user)
}

export const createUser = data => {
    return http.post(`${domin}/addUser`, data)
}

export const getUserInfo = id => {
    return http.get(`${domin}/${id}`)
}

export const updateUserInfo = data => {
    return http.post(`${domin}/userInfo`, {id: data.id, nick_name: data.nick_name, tel: data.tel, password: data.password})
}


export const checkPassword = info => {
    return http.get(`${domin}/checkPassword`, {params: info})
}

export const submitFeedback = data => {
    return http.post(`${domin}/feedback`, data)
}