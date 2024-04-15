<template>
  <div class="package-detail">
    <van-nav-bar title="套餐详情" left-text="返回" left-arrow @click-left="onClickLeft" />
    <div style="height: 35vh;">
      <img style="height: 100%;width: 100%;position: relative; z-index: 1;" :src="packages.img_src">
    </div>
    <van-cell-group>
      <van-cell>
        <div class="package-detail-title">{{ packages.name }}</div>
        <div class="package-detail-price">{{ formatPrice(packages.price) }}</div>
      </van-cell>
      <van-cell class="package-detail-express">
        <van-col span="10">适用人：{{ packages.applicable_group }}</van-col>
      </van-cell>
    </van-cell-group>

    <van-cell-group class="package-detail-cell-group">
      <van-cell icon="shop-o" is-link>
        <template #title>
          <span class="van-cell-text">有赞的店</span>
          <van-tag class="package-detail-tag" type="danger">官方</van-tag>
        </template>
      </van-cell>
      <van-cell title="线下门店" icon="location-o" is-link />
    </van-cell-group>

    <van-cell-group class="package-detail-cell-group">
      <van-cell title="查看商品详情" is-link />
    </van-cell-group>

    <van-button style="position: absolute; bottom: 0;" type="primary" @click="handlePreBook" block>立即预约</van-button>
  </div>
</template>

<script>
import {
  getPackageDetail,
  preBookExamination,
  postNewAssignment
} from '@/api/package';
import ChangGui from '@/assets/package/ChangGui.jpg';
import FuMu from '@/assets/package/FuMu.jpg';
import LaoNian from '@/assets/package/LaoNian.jpg';
import QuanShen from '@/assets/package/QuanShen.jpg';
import RuZhi from '@/assets/package/RuZhi.jpg';
import { Dialog } from 'vant-green';
export default {
  data: () => {
    return {
      packages: {},
      imageMap: {
        "ChangGui.jpg": ChangGui,
        "FuMu.jpg": FuMu,
        "LaoNian.jpg": LaoNian,
        "QuanShen.jpg": QuanShen,
        "RuZhi.jpg": RuZhi
      }
    }
  },
  mounted() {
    getPackageDetail(this.$route.query.id).then(({ data }) => {
      this.packages = data;
      this.packages.img_src = this.imageMap[data.img_src];
    });
  },
  methods: {
    formatPrice() {
      return '¥' + (this.packages.price / 100).toFixed(2);
    },
    onClickLeft() {
      this.$router.back();
    },
    async handlePreBook() {
      const packageId = this.$route.query.id;
      const centerId = this.$route.query.centerId;

      const userInfo = this.$store.state.user.userInfo;
      Dialog.confirm({
        message: '是否确认预约？',
        confirmButtonText: '是',
        cancelButtonText: '否'
      }).then(async () => {
        const res = await preBookExamination({
          id: userInfo.id,
          packageId,
          centerId,
          examinee: {
            name: userInfo.name,
            identificationNumber: userInfo.identification_number,
            sex: userInfo.sex,
            birthday: this.formatDate(userInfo.birthday),
            phone: userInfo.phone,
            relationshipId: 1,
            status: "add"
          }
        });
        if(res.status === 200) {
          const orderId = res.data.orderId;
          console.log("@@@@", orderId);
          // await postNewAssignment({ orderId });
          this.onClickLeft();
        }
      });
      
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0'); // 月份是从0开始的
      const day = String(date.getDate()).padStart(2, '0');

      return `${year}-${month}-${day}`;
    }
  }
}
</script>

<style lang="scss" scoped>
.package-detail {
  box-sizing: border-box;
  height: 94vh;
  padding-bottom: 50px;
  position: relative;

  &-swipe {
    img {
      width: 100%;
      display: block;
    }
  }

  &-title {
    font-size: 20px;
    font-weight: 600;
  }

  &-price {
    margin-top: 8px;
    color: #f44;
    font-size: 18px;
  }

  &-express {
    color: #999;
    font-size: 12px;
    padding: 5px 15px;
  }

  &-cell-group {
    margin: 15px 0;

    .van-cell__value {
      color: #999;
    }
  }

  &-tag {
    margin-left: 5px;
  }
}
</style>