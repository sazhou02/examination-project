<template>
  <div class="goods">
    <van-nav-bar title="机构详情" left-text="返回" left-arrow @click-left="onClickLeft" />
    <div style="height: 35vh;">
      <img style="height: 100%;width: 100%;position: relative; z-index: 1;" :src="centerInfo.imgSrc">
    </div>
    <div class="card">
      <div class="card-title">{{ centerInfo.centerName }}</div>
      <div class="card-des">
        <span>{{ centerInfo.centerNearby }}</span>
        <span>{{ centerInfo.announcement }}</span>
        <span>人气值{{ centerInfo.consult_num }}</span>
      </div>
      <div class="card-tag">
        <span>医保定点</span>
        <span>可刷卡</span>
        <span>可停车</span>
      </div>
    </div>

    <van-cell-group class="goods-cell-group">
      <van-cell :title="centerInfo.centerAddress" icon="location-o" is-link @click="sorry" />
    </van-cell-group>

    <div>
      <div style="font-size: 20px; font-weight: 600; margin-left: 8px;">套餐</div>
      <package-list :list="packageList" />
    </div>

  </div>
</template>

<script>
import DiEr from '@/assets/institution/DiEr.jpg';
import DiSi from '@/assets/institution/DiSi.jpg';
import DiYi from '@/assets/institution/DiYi.jpg';
import ErQiEr from '@/assets/institution/ErQiEr.jpg';
import HuangHe from '@/assets/institution/HuangHe.png';
import JiuHua from '@/assets/institution/JiuHua.jpg';
import MeiNian from '@/assets/institution/MeiNian.jpg';
import MinZhong from '@/assets/institution/MinZhong.png';
import NanKai from '@/assets/institution/NanKai.jpg';
import {
  getPackageInCenter
} from '@/api/package';
import PackageList from '../components/PackageList.vue';
export default {
  components: {
    PackageList
  },
  data() {
    return {
      centerInfo: {},
      packageList: [],
      imageMap: {
        "DiEr.jpg": DiEr,
        "DiSi.jpg": DiSi,
        "DiYi.jpg": DiYi,
        "ErQiEr.jpg": ErQiEr,
        "HuangHe.png": HuangHe,
        "JiuHua.jpg": JiuHua,
        "MeiNian.jpg": MeiNian,
        "MinZhong.png": MinZhong,
        "NanKai.jpg": NanKai
      }
    };
  },

  mounted() {
    getPackageInCenter(this.$route.query.id).then(({ data }) => {
      const { centerInfo, packages } = data;
      this.packageList = packages.map(item => {
        item.centerName = centerInfo.centerName;
        item.centerId = centerInfo.centerId;
        return item;
      });
      this.centerInfo = centerInfo;
      this.centerInfo.imgSrc = this.imageMap[this.centerInfo.centerImg];
    });
  },

  methods: {
    formatPrice() {
      return '¥' + (this.goods.price / 100).toFixed(2);
    },

    onClickCart() {
      this.$router.push('cart');
    },

    sorry() {
      Toast('暂无后续逻辑~');
    },
    onClickLeft() {
      this.$router.push({
        name: 'institution'
      })
    }
  }
};
</script>

<style lang="scss">
.goods {
  padding-bottom: 50px;
  .card {
    margin-top: -20px;
    position: relative;
    z-index: 99;
    width: 100%;
    display: flex;
    flex-direction: column;
    background: linear-gradient(to right, #fef4dc, #ecce94);
    box-shadow: 5px 5px 5px 0px rgba(0, 0, 0, 0.3);
    padding: 8px;
    border-radius: 15px;
    &-title {
      margin-left: 8px;
      font-size: 20px;
      font-weight: bold;
    }
    &-des {
      display: flex;
      justify-content: start;
      span {
        margin-left: 8px;
      }
    }
    &-tag {
      display: flex;
      span {
        margin-left: 8px;
        color: #fff;
        background-color: #c59559;
        padding: 5px;
        border-radius: 5px;
      }
    }
    div {
      padding: 5px;
    }
  }

  &-swipe {
    img {
      width: 100%;
      display: block;
    }
  }

  &-title {
    font-size: 16px;
  }

  &-price {
    color: #f44;
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