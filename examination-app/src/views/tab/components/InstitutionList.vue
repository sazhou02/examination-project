<template>
  <van-list
    v-model="loading"
    :finished="finished"
    finished-text="没有更多了"
  >
    <van-doctor-card
      v-for="(item, index) in instList"
      :key="index"
      :avatar-offset-top="4"
      :avatar-figure="item.imgSrc"
      :avatar-size="68"
      :avatar-radius="4"
      :name="item.n"
      :hospital-level="item.hospitalLevel"
      :hospital="item.name + item.address"
      :department="item.nearby"
      :skill-tag="item.announcement"
      :receive-num="item.morningLimit"
      :response-time="item.responseTime"
      :consult-num="item.consultNum"
      button-text="立即咨询"
      @clickCard="clickCard(item.id)"
      @clickButton="clickCard(item.id)"
    >
      <span slot="corner" class="bold van-color-warning">
        {{ item.price }}
        <i class="font-size-3" style="margin-left: -5px">元</i>
      </span>
    </van-doctor-card>
  </van-list>
</template>

<script>
import { getInstList, getInstCount } from '@/api/home';
import DiEr from '@/assets/institution/DiEr.jpg';
import DiSi from '@/assets/institution/DiSi.jpg';
import DiYi from '@/assets/institution/DiYi.jpg';
import ErQiEr from '@/assets/institution/ErQiEr.jpg';
import HuangHe from '@/assets/institution/HuangHe.png';
import JiuHua from '@/assets/institution/JiuHua.jpg';
import MeiNian from '@/assets/institution/MeiNian.jpg';
import MinZhong from '@/assets/institution/MinZhong.png';
import NanKai from '@/assets/institution/NanKai.jpg';

export default {
  name: "InstitutionList",
  props: {
    showHot: {
      type: Boolean,
      default: false
    },
    districtId: {
      type: Number,
      default: 0
    },
    orderRule: {
      type: String,
      default: ""
    },
    searchValue: {
      type: String,
      default: ""
    }
  },
  data: () => {
    return {
      loading: false,
      finished: false,
      pageParams: {
        curPage:1,
        pageSize:99,
      },
      total: 0,
      instList: [],
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
    }
  },
  watch: {
    districtId() {
      this.pageParams.curPage = 1;
      this.instList = [];
      this.onLoad();
    },
    orderRule() {
      this.pageParams.curPage = 1;
      this.instList = [];
      this.onLoad();
    }
  },
  created() {
    this.onLoad();
    getInstCount().then(res => {
      this.total = res.data.total;
    })
  },
  methods: {
    clickCard(id) {
      this.$router.push({ path: '/institutionDetail', query: { id } })
    },
    clickButton() {
      
    },
    onLoad() {
      const { pageParams, searchValue } = this;
      this.instList = [];
      getInstList({...pageParams, searchValue}).then(res => {
        this.instList = this.instList.concat(res.data);
        this.instList.map(item => {
          item.imgSrc = this.imageMap[item.imgSrc];
          return item;
        })
        // 显示热门机构
        if (this.showHot) {
          this.instList = this.instList.filter(item => item.isHot === 1);
        }
        // 过滤地区
        if(this.districtId > 0) {
          this.instList = this.instList.filter(item => item.districtId === this.districtId);
        }
        // 排序
        if(this.orderRule === "lowPrice") {
          this.instList = this.instList.sort((a, b) => a.price - b.price);
        } else if(this.orderRule === "highPrice") {
          this.instList = this.instList.sort((a, b) => b.price - a.price);
        }

        if(this.instList.length >= this.total) {
          this.finished = true;
        }
      }).finally(() => {
        this.loading = false;
      })
    }
  }
}
</script>

<style lang="scss" scoped></style>