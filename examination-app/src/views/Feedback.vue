<template>
  <div>
    <van-nav-bar title="问题反馈" left-text="返回" left-arrow @click-left="onClickLeft" />
    <van-cell-group>
      <van-field v-model="form.message" required label="留言" type="textarea" placeholder="请输入留言" rows="3" autosize />
      <van-field v-model="form.name" required clearable label="姓名" placeholder="请输入姓名" />
      <van-field v-model="form.phone" required clearable label="电话" placeholder="请输入手机号" />
    </van-cell-group>
    <van-button class="submit" size="large" type="info" @click="handleSubmit">提交</van-button>
  </div>
</template>

<script>
import { Toast } from 'vant';
import {
  submitFeedback
} from '@/api/user'
export default {
  name: 'Feedback',
  data() {
    return {
      form: {
        message: '',
        name: '',
        phone: ''
      }
    }
  },
  methods: {
    onClickLeft() {
      this.$router.back();
    },
    handleSubmit() {
      const form = { ...this.form };
      if (form.message && form.name && form.phone) {
        // submitFeedback(form).then(res => {
        //   if (res.data.code == '20000') {
            Toast.success('提交成功');
            this.onClickLeft();
        //   } else {
        //     Toast.fail(res.data.msg)
        //   }
        // })
      } else {
        Toast.fail('请完善表单信息')
      }
    }
  },
  mounted() {
    //
  }
}
</script>

<style lang="scss" scoped>
.submit {
  width: 95%;
  margin: 30px auto 0;
  display: block;
}
</style>