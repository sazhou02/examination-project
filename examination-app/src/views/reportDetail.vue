<template>
  <div class="report">
    <van-nav-bar title="体检报告" left-text="返回" left-arrow @click-left="onClickLeft">
    </van-nav-bar>
    <div class="info-card">
      <span class="title">{{ packageName }}</span><span class="right">{{ userName }}</span>
    </div>
    <div class="list">
      <div class="category" v-for="(item, index) in allReportList" :key="index">
        <div class="title">{{ item.categoryName }}</div>
        <div class="item" v-for="j in item.itemRes" :key="j.itemId">
          <span>{{ j.name }}</span>
          <span class="value">{{ j.value }}</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import moment from "moment";
import {
  getReportDeatil
} from '@/api/order.js';
import { Component, Prop, Vue } from "vue-property-decorator";
@Component
export default class RepairDetail extends Vue {
  packageName = "";
  allReportList = [];
  userInfo = JSON.parse(localStorage.getItem("userInfo"));
  userName = "";
  onClickLeft() {
    this.$router.back();
  }
  timestampToTime(timestamp) {
    return moment(timestamp - 0).format("YYYY-MM-DD HH:mm:ss");
  }
  created() {
    this.userName = this.userInfo.name;
    const { orderId, packageName } = this.$route.query;
    this.packageName = packageName;
    getReportDeatil({ orderId }).then(res => {
      this.allReportList = res.data;
    })
  }
}
</script>
<style lang="scss" scoped>
.report {
  width: 100%;
  height: 100%;
  background-color: #f8f8f8;
}

.info-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 40px;
  width: 100%;
  background-color: white;
  margin-bottom: 10px;

  .title {
    margin-left: 10px;
    font-size: 18px;
    font-weight: 500;
  }

  .right {
    font-size: 14px;
    margin-right: 10px;
    color: #999;
  }
}
.list {
    margin: 14px auto;
    padding: 12px;
    width: 90%;
    background-color: white;
    border-radius: 6px;
    .category {
      font-size: 16px;
      font-weight: 500;
      .item {
        display: flex;
        justify-content: space-between;
        margin: 14px 10px 14px 20px;
        font-size: 16px;
        color: #333;
        font-weight: 200;
        .range {
          padding-left: 10px;
          color: #999;
        }
        .value {
            color: #98c185;
        }
      }
    }
    
}
</style>
