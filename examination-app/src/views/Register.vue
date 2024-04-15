<template>
    <div class="wrap">
        <p>用户注册</p>
        <van-cell-group class="form">
            <van-field v-model="form.name" required clearable label="姓名" placeholder="请输入姓名" />
            <van-field v-model="form.identificationNumber" required clearable label="身份证号" placeholder="请输入身份证号" />
            <van-cell title="生日">
                <van-datetime-picker v-model="form.birthday" type="date" :min-date="minDate" />
            </van-cell>
            <van-field v-model="form.phone" label="手机号" placeholder="请输入手机号" required/>
            <van-cell title="性别">
                <van-radio-group v-model="form.sex">
                    <van-radio name="男">男</van-radio>
                    <van-radio name="女">女</van-radio>
                </van-radio-group>
            </van-cell>

        </van-cell-group>
        <van-button block style="" @click="register">注册</van-button>
        <span>
            <router-link style="color: #000; background-color: #fff; padding: 5px;" :to="{ path: '/login' }">返回登录</router-link>
        </span>
    </div>
</template>

<script>
import {
    createUser
} from '@/api/user'
import moment from 'moment';
import {
    Toast
} from 'vant';
import {
    Component,
    Prop,
    Vue,
} from 'vue-property-decorator';

@Component
export default class Register extends Vue {
    form = {
        name: '',
        identificationNumber: '',
        birthday: '',
        sex: '',
        phone: '',
        createTime: new Date().toString()
    };
    minDate = new Date("1950-01-01");
    register() {
        const form = { ...this.form }
        form.birthday = moment(form.birthday).format("YYYY-MM-DD");
        form.createTime = moment(form.birthday).format("YYYY-MM-DD HH:MM:SS");
        console.log(form);
        if (/^1[34578]\d{9}$/.test(form.phone) && form.sex && form.identificationNumber && form.name && form.birthday) {
            createUser(form).then(res => {
                if (res.status === 200) {
                    Toast.success('注册成功, 请登录！');
                    this.$router.push('/login');
                } else {
                    Toast.fail(res.data.msg)
                }
            })
        } else {
            Toast.fail('请正确完善注册信息')
        }
    };
    created() {
    }
}
</script>
<style lang="scss" scoped>
.wrap {
    padding-top: 50px;
    box-sizing: border-box;
    height: 100%;
    background-image: url('../assets/login_bg.jpg');
    background-size: cover;

    p {
        text-align: center;
        color: #fff;
        font-size: 20px;
        margin-bottom: 30px;
    }

    .form {
        width: 90%;
        left: 50%;
        transform: translate(-50%, 0);
    }

    // span {
    //     position: absolute;
    //     right: 5%;
    //     margin-top: 90px;

    //     a {
    //         color: #0000CC;
    //     }
    // }
    .reg-btn {
        margin-top: 30px;
        width: 90%;
        left: 50%;
        transform: translate(-50%, 0)
    }
}

.wrap /deep/ .van-cell-group {
    background-color: rgba(255, 255, 255, 0.8)
}

.form /deep/ .van-cell {
    background-color: rgba(255, 255, 255, 0)
}

.wrap /deep/ .van-button--default {
    background: #3388ff;
    border: 1px solid #3388ff;
    color: #fff
}
</style>