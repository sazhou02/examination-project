<template>
  <div class="login-wrap">
    <p class="header">登录/注册</p>
    <img class="wrap-bg" src="../assets/banner-icon.png" alt="" srcset="">
    <van-tabs v-model="active" :line-width="20" color="#5064eb" title-active-color="#5064eb" animated>
      <van-tab title="登录">
        <van-cell-group class="form">
          <van-field v-model="userName" required clearable left-icon="manager" placeholder="请输入用户名" />
          <van-field v-model="password" type="password" left-icon="lock" placeholder="请输入密码" required />
        </van-cell-group>
        <van-button
          style="margin-top: 30px; width: 90%; left: 50%; transform: translate(-50%, 0); background-color: #5064eb; color: #fff; border-radius: 20px;"
          @click="login">登录</van-button>
        <span class="register">
          <router-link style="text-decoration: underline #000" :to="{ path: '/register' }">点此注册</router-link>
        </span>
      </van-tab>
    </van-tabs>
  </div>
</template>

<script>
import md5 from 'js-md5'
import { Toast } from 'vant';
import {
  createUser
} from '@/api/user'
import {
  Component,
  Prop,
  Vue,
} from 'vue-property-decorator';

@Component
export default class Login extends Vue {
  userName = '13829223132';
  password = '891461';
  active = 0;
  login() {
    const vm = this;
    this.$store.dispatch('LOGIN', {
      phone: vm.userName,
      sms: vm.password
    }).then(res => {
      if (res.data.success) {
        Toast.success('登录成功')
        vm.$router.push({
          path: '/main/home'
        })
      } else {
        Toast.fail(res.data.msg)
      }
    });
  };
  form = {
    name: '',
    password: '',
    nick_name: '',
    sex: '',
    room_id: '',
    tel: ''
  };
  roomList = []; // 选择器的数据
  room = []; // 处理后的数据
  resroom = []; // 数据原型
  selectRoom = '';
  showRoom = false;
  onCancel() {
    this.showRoom = false
  };
  onConfirm(value) {
    this.form.room_id = this.resroom.find(item => item.room_num == value[1]).id
    this.selectRoom = value[0] + '号楼' + this.resroom.find(item => item.room_num == value[1]).room_num + '室'
    this.showRoom = false
  };
  onChange(picker, values) {
    picker.setColumnValues(1, this.room[values[0]]);
  };
  created() {}
}
</script>
<style lang="scss">
.login-wrap {
  padding-top: 50px;
  box-sizing: border-box;
  height: 100%;
  background-color: #5064eb;
  background-size: cover;
  position: relative;

  .header {
    position: absolute;
    left: 0;
    top: 2vh;
    width: 100%;
    color: #fff;
    text-align: center;
    font-size: 18px;
  }

  .wrap-bg {
    display: block;
    width: 60%;
    position: absolute;
    right: 0;
    top: 14vh;
    z-index: 9;
  }

  .van-tabs--line {
    padding-top: 60px;
  }

  .van-tabs {
    position: absolute;
    z-index: 1;
    top: 25%;
    width: 100%;
    height: 75%;
  }

  .van-tab {
    flex: 0.2;
  }

  .van-tabs__wrap {
    width: 95%;
    height: 60px !important;
    margin: 0 auto;
    border-radius: 8px 8px 0 0;
  }

  .van-tabs__wrap .van-tab {
    font-size: 16px;
    line-height: 60px;
  }

  .van-tabs__wrap .van-tab--active {
    font-size: 20px;
  }

  .van-tabs__content {
    height: 100%;
    background-color: #fff;
  }

  p {
    text-align: center;
    color: #fff;
    font-size: 20px;
    margin-bottom: 30px;
  }

  .form {
    height: 150px;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
  }

  .form {
    width: 90%;
    left: 50%;
    transform: translate(-50%, 0);

    .van-cell {
      background-color: rgba(51, 136, 255, 0.2);
      border-radius: 30px;
    }
  }

  .register-form {
    width: 90%;
    margin: 0 auto;
  }

  .register {
    position: absolute;
    right: 5%;
    margin-top: 90px;

    a {
      color: #000;
    }
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
