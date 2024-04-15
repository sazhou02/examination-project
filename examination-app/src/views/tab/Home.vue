<template>
  <div>
    <van-nav-bar title="健康体检">
    </van-nav-bar>
    <!-- 搜索 -->
    <!-- <van-search v-model="value" placeholder="请输入搜索关键词" :show-action="showAction" reverse-color @search="onSearch"
      @cancel="onCancel" @focus="onFocus" /> -->
    <!-- 轮播图 -->
    <van-swipe type="card" :height="156" :autoplay="3000">
      <van-swipe-item v-for="(item,index) in imageLinks" :key="index" :default="item.image"></van-swipe-item>
    </van-swipe>
    <!-- 快捷菜单 -->
    <van-grid :column-num="4" icon-size="34px">
      <van-grid-item v-for="(i,index) in gridMenu" :key="index" :icon="i.icon" :text="i.text" @click="handleJump(i.path)" />
    </van-grid>
    <!-- 热门体检机构 -->
    <van-row style="text-align: center;">
      <van-col span="8" style="font-weight: bold;">热门体检机构</van-col>
      <van-col span="8"></van-col>
      <van-col span="8" style="font-size: 14px; color: #555;">查看更多></van-col>
    </van-row>
    <InstitutionList :showHot="true" />

  </div>
</template>
<script>
import InstitutionList from './components/InstitutionList'
import {
  Component,
  Prop,
  Vue,
} from 'vue-property-decorator';
@Component({
  components: {
    InstitutionList
  }
})
export default class Main extends Vue {
  imageLinks = [{
    image: require('../../assets/swiper/swiper1.jpeg'),
  },
  {
    image: require('../../assets/swiper/swiper2.jpeg'),
  },
  {
    image: require('../../assets/swiper/swiper3.jpeg'),
  }
  ];

  // 搜索相关
  // value = '';
  // showAction = false;
  // onSearch() {
  //   this.$toast(this.value);
  // };
  // onFocus() {
  //   this.showAction = true;
  // };
  // onCancel() {
  //   this.showAction = false;
  // };

  // 快捷菜单相关
  gridMenu = [
    {
      icon: require("../../assets/icon/icon1.png"),
      text: '体检机构',
      path: "/institution"
    },
    {
      icon: require("../../assets/icon/icon2.png"),
      text: '体检套餐',
      path: "/package"
    },
    {
      icon: require("../../assets/icon/icon3.png"),
      text: '体检报告',
      path: "/order"
    },
    {
      icon: require("../../assets/icon/icon8.png"),
      text: '咨询客服'
    },
    {
      icon: require("../../assets/icon/icon4.png"),
      text: '老年体检',
      path: "/package?packageName=老年体检"
    },
    {
      icon: require("../../assets/icon/icon5.png"),
      text: '常规体检',
      path: "/package?packageName=常规体检"
    }, 
    {
      icon: require("../../assets/icon/icon6.png"),
      text: '全身体检',
      path: "/package?packageName=全身体检"
    }, 
    {
      icon: require("../../assets/icon/icon7.png"),
      text: '入职体检',
      path: "/package?packageName=入职体检"
    }
  ]
  handleJump(path) {
    if (path) {
      this.$router.push(path);
    }
  }

}
</script>
<style lang="scss" scoped>
.complaint {
  width: 95%;
  margin: 0 auto;
  display: block;
}
</style>