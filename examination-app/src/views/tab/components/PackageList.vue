<template>
  <div>
    <template v-for="item in packageList">
      <van-text-box style="position: relative;" :key="item.id" :cover="item.imgSrc" type="5" :title="item.packageName"
        sub-title=" " :tip="'￥' + item.packagePrice" :content="'适合人群：' + item.applicableGroup">
        <div style="position: absolute; bottom: 0; width: 96vw; height: 100%;" @click="handleDetail(item.packageId, item.centerId)">
          <van-row type="flex" justify="end" style="position: absolute; bottom: 2vh; left: 28vw;" class="padding-right14">
            <van-icon name="location-o" style="margin-top: 3px;" />{{ item.centerName }}<van-icon name="arrow" style="margin-top: 3px;" />
          </van-row>
        </div>
      </van-text-box>
    </template>
  </div>
</template>

<script>
import ChangGui from '@/assets/package/ChangGui.jpg';
import FuMu from '@/assets/package/FuMu.jpg';
import LaoNian from '@/assets/package/LaoNian.jpg';
import QuanShen from '@/assets/package/QuanShen.jpg';
import RuZhi from '@/assets/package/RuZhi.jpg';


export default {
  name: "PackageList",
  props: {
    list: {
      type: Array,
      default: () => []
    }
  },
  data: () => {
    return {
      packageList: [],
      imageMap: {
        "ChangGui.jpg": ChangGui,
        "FuMu.jpg": FuMu,
        "LaoNian.jpg": LaoNian,
        "QuanShen.jpg": QuanShen,
        "RuZhi.jpg": RuZhi
      }
    }
  },
  watch: {
    list() {
      this.packageList = this.list.map(item => {
        item.imgSrc = this.imageMap[item.imgSrc];
        return item;
      });
    }
  },
  created() {
  },
  methods: {
    handleDetail(id, centerId) {
      console.log(id, centerId, "&&&&&");
      this.$router.push({
        path: '/packageDetail',
        query: {
          id,
          centerId
        }
      })
    }
  }

}
</script>

<style lang="scss" scoped>
.van-text-box {
    padding-top: 8px;

    /deep/ .van-divider {
        border-style: none;
    }
    /deep/ .van-text-box__header {
        position: absolute;
        right: 0;
    }
    /deep/ .van-text-box__cover {
        width: 100px;
        height: 100px;
    }
    /deep/ .van-text-box__title {
        font-size: 20px;
    }
}
</style>