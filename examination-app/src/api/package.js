import http from './index';

export const getPackage = query => {
    return http.get("/package/allPackageInstitution", { params: query })
}

export const getPackageInCenter = id => {
    return http.post(`/package/packageInCenter`, { centerId: id })
}

export const getPackageDetail = id => {
    return http.get(`/package/${id}`)
}

export const preBookExamination = data => {
    return http.post("/examinee/update", data)
}

export const postNewAssignment = data => {
    return http.post("/examination_order/newAssignment", data)
}

export const groupBuy = data => {
    return http.post("/group/newGroup", data);
}

export const getGroupBuyNum = params => {
    return http.get("/group/groupBuyNum", { params: params });
}