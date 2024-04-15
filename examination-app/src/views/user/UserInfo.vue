<template>
  <div>
    <van-nav-bar title="个人信息" left-text="返回" left-arrow @click-left="onClickLeft" />
    <van-cell-group>
      <van-cell title="姓名" :value="userInfo.name" />
      <van-cell title="身份证号" :value="userInfo.identificationNumber" />
      <van-cell title="性别" :value="userInfo.sex" />
      <van-cell title="手机号" :value="userInfo.phone" />
      <van-cell title="生日" :value="userInfo.birthday" />
    </van-cell-group>
  </div>
</template>

<script>
import {
  getUserInfo
} from '@/api/user.js';
import moment from 'moment';

export default {
  data() {
    return {
      userInfo: {}
    }
  },
  created() {
    this.getUserInfo();
  },
  methods: {
    onClickLeft() {
      this.$router.back();
    },
    async getUserInfo() {
      const info = JSON.parse(localStorage.getItem('userInfo'));
      const id = info.id;
      let res = await getUserInfo(id);
      this.userInfo = res.data;
      this.userInfo.birthday = moment(this.userInfo.birthday).format('YYYY-MM-DD');
    }
  }
}
</script>

<style lang="scss" scoped></style>