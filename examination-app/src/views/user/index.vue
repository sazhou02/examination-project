<template>
  <div>
    <div style="width: 100vw; height: 25vh; display: flex; justify-content: center; align-items: center; background-color: gainsboro;">
      <van-avatar :figure="5" size="100" round :radius="4" />
    </div>
    <van-cell-group class="user-group">
      <van-cell icon="records" title="个人信息" is-link @click="handleInfo" />
      <van-cell icon="records" title="体检报告" is-link @click="handleOrder" />
    </van-cell-group>

    <van-cell-group>
      <van-cell icon="points" title="意见反馈" is-link @click="handleFeedbcak" />
      <van-cell icon="gold-coin-o" title="我的优惠券" is-link />
      <van-cell icon="gift-o" title="我的收藏" is-link />
    </van-cell-group>
    <van-button type="danger" block @click="logOut">退出登录</van-button>
  </div>
</template>

<script>
import { Row, Col, Icon, Cell, CellGroup } from 'vant';
import { Dialog } from 'vant-green';

export default {
  components: {
    [Row.name]: Row,
    [Col.name]: Col,
    [Icon.name]: Icon,
    [Cell.name]: Cell,
    [CellGroup.name]: CellGroup
  },
  methods: {
    handleOrder() {
      this.$router.push('/order');
    },
    handleFeedbcak() {
      this.$router.push('/feedback');
    },
    handleInfo() {
      this.$router.push('/userInfo');
    },
    logOut() {
      Dialog.confirm({
        message: '是否确认退出登录？'
      })
        .then(async () => {
          // on confirm
          await this.$store.dispatch('LOG_OUT')
          this.$router.push({
            path: '/login'
      })
        })
        .catch(() => {
          // on cancel
        });
      
    }
  }
};
</script>

<style lang="scss">
.user {
  &-poster {
    width: 100%;
    height: 53vw;
    display: block;
  }

  &-group {
    margin-bottom: 15px;
  }

  &-links {
    padding: 15px 0;
    font-size: 12px;
    text-align: center;
    background-color: #fff;

    .van-icon {
      display: block;
      font-size: 24px;
    }
  }
}
</style>