import { setToken, removeToken, setUserInfo, removeUserInfo, getUserInfo } from '@/utils/auth';
import { login, updateUserInfo, checkPassword } from '@/api/user';
                            
const user = {
    state: {
        token: '',
        userInfo: getUserInfo() || {}
    },

    mutations: {
        SET_USER: (state, user) => {
            Object.assign(state, user)
        },
        SET_TOKEN: (state, token) => {
            state.token = token;
        },
        SET_USER: (state, userInfo) => {
            state.userInfo = userInfo;
        }
    },

    actions: {
        async LOGIN({ commit }, loginInfo) {
            try {
                const res = await login(loginInfo);
                if (res.data.success) {
                    commit('SET_TOKEN', res.data.token);
                    setToken(res.data.token);

                    commit('SET_USER', res.data.userInfo);
                    setUserInfo(res.data.userInfo)
                }
                return res
            } catch (err) {
                console.log(err);
            }
        },
        async LOG_OUT() {
            try {
                removeToken();
                removeUserInfo();
            } catch (err) {
                console.log(err);
            }
        },
        async UPDATE_INFO({}, data) {
            try {
                const res = await updateUserInfo(data)
                if (res.data.code == '20000') {
                    return res.data.msg
                } else {
                    throw res.data.msg
                }
            } catch (err) {
                throw err
            }
        },
        async CHECK_PASSWORD({state}, password) {
            try {
                const res = await checkPassword({name: state.name, password: password})
                    return res.data
            } catch (err) {
                throw err
            }
        },
    }

}

export default user