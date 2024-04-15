<template>
  <div>
    <van-nav-bar title="缴费" />
    <div>
      <no-data v-if="payList.length == 0" />
      <template v-else>
        <van-card v-for="(item, index) in payList" :key="index" currency="" :price="'￥' + item.amount"
          :desc="'缴费方式：' + item.pay_method" :title="'缴费项：' + item.pay_type"
          :thumb="item.photos && JSON.parse(item.photos).length != 0 ? JSON.parse(item.photos)[0] : defaultImg">
          <div slot="footer">
            <van-button v-if="!item.pay_status" type="primary" size="mini" @click="handlePay(item)">支付</van-button>
            <span v-else>已支付</span>
          </div>
          <div slot="tags">
            <span>备注：{{ item.notes }}</span>
          </div>
        </van-card>
      </template>
    </div>
  </div>
</template>

<script>
import noData from '@/components/noData';
import { getPayment, updatePayment } from '@/api/pay';
export default {
  name: "Pay",
  components: {
    noData
  },
  data() {
    return {
      imageURL: "../../../assets/noPhoto",
      payList: [],
      defaultImg: require('@/assets/noPhoto.png')
    }
  },
  created() {
    this.fetchData();
  },
  methods: {
    handlePay({ id }) {
      const _this = this;
      this.$dialog.confirm({
        title: '支付提示',
        message: '确定支付该缴费项吗？'
      }).then(
        async () => {
          const res = await updatePayment({
            id,
            payStatus: 1
          })
          if (res.data.code == 20000) {
            this.$toast('支付成功');
            _this.fetchData();
          }
        }
      ).catch(() => {
        this.$toast('取消支付');
      })
    },
    async fetchData() {
      const vm = this
      var res = await getPayment({
        userId: this.$store.state.user.id
      })
      vm.payList = res.data.data.map(item => {
        return {
          ...item,
          pay_method: 
            item.pay_method == "zhifubao"
            ? '支付宝'
            : item.pay_method == "weixin"
            ? '微信'
            : '银行卡',
          pay_type: this.getPayTypeText(item.pay_type)
        }
      });
    },
    getPayTypeText(type) {
      let text;
      switch (type) {
        case 'dianfei':
          text = '电费';
          break;
        case 'shuifei':
          text = '水费';
          break;
        case 'ranqifei':
          text = '燃气费';
          break;
        case 'nuanqifei':
          text = '暖气费';
          break;
        case 'wuyefei':
          text = '物业费';
          break;
        case 'tingchefei':
          text = '停车费';
          break;
        default:
          text = '';
      }
      return text;
    }
  }
}
</script>

<style lang="scss" scoped></style>