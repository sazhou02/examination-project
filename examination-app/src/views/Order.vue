<template>
  <div class="order">
    <van-nav-bar title="我的报告" left-text="返回" left-arrow @click-left="onClickLeft">
    </van-nav-bar>
    <van-nodata v-if="orderList.length === 0" :figure="16" title="暂无报告" />
    <template v-else>
      <div class="card" v-for="item in orderList" :key="item.id" @click="handleReport(item.id, item.package_name)">
        <div class="left">
          <div class="left-content">
            <div class="name">{{ item.name }}</div>
            <div class="relation">自己</div>
          </div>
        </div>
        <div class="right">
          <div class="right-content">
            <div class="row"><span class="property">套餐名称</span><span class="value">{{ item.package_name }}</span></div>
            <div class="row"><span class="property">体检地点</span><span class="value">{{ item.center_name }}</span></div>
            <div class="row"><span class="property">体检时间</span><span class="value">{{ formatTime(item.examine_date)
            }}</span></div>
            <div class="row"><span class="property">状态</span><span class="value success">{{ item.status === 5 ? "已完成" :
              "未完成" }}</span></div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import {
  getOrderList
} from '@/api/order.js';
import moment from 'moment';
import { Nodata } from 'vant-green';
export default {
  components: {
    Nodata
  },
  data() {
    return {
      userInfo: JSON.parse(localStorage.getItem('userInfo')),
      orderList: []
    }
  },
  created() {
    getOrderList({ dname: this.userInfo.name }).then(res => {
      this.orderList = res.data;
    })
  },
  methods: {
    onClickLeft() {
      this.$router.back();
    },
    formatTime(time) {
      return moment(time).format('YYYY-MM-DD');
    },
    handleReport(orderId, packageName) {
      this.$router.push({
        path: '/reportDetail',
        query: {
          orderId,
          packageName
        }
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.order {
  width: 100%;
  height: 100%;
  background-color: #f8f8f8;
}

.card {
  display: flex;
  position: relative;
  margin: 10px auto;
  width: 90%;
  height: 120px;
  background-color: white;
  border-radius: 8px;

  .left {
    display: flex;
    width: 100px;
    justify-content: center;
    align-items: center;

    .left-content {
      padding-right: 0px;
      height: 60px;
      width: 80px;
      text-align: center;
      border-right: 1px solid #c8c7cc;
    }

    .name {
      font-size: 18px;
      font-weight: 500;
    }

    .relation {
      margin-top: 6px;
      font-size: 14px;
      color: #c0c0c0;
    }
  }

  .right {
    display: flex;
    justify-content: center;
    align-items: center;

    .row {
      margin: 4px;
      font-size: 14px;

      .property {
        margin-right: 10px;
        font-weight: 500;
        color: #333;
      }

      .value {
        color: #999;
      }
    }
  }
}</style>