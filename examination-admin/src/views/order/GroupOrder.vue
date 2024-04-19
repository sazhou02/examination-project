<script setup lang="ts">
import $axios from "@/axios";
import { reactive, getCurrentInstance} from "vue";
import JsBarcode from 'jsbarcode';
const { proxy } = getCurrentInstance() as any;

const columns = [
  {
    title: "套餐名",
    key: "packageName",
  },
  {
    title: "体检中心",
    key: "centerName",
  },
  {
    title: "开始时间",
    key: "startTime",
  },
  {
    title: "结束时间",
    key: "endTime",
  },
  {
    title: "拼团人数",
    key: "number"
  },
  {
    title: "状态",
    key: "status",
    render: (h:any, params:any) => {
      switch (params.row.number){
        case 3:return '已拼成';break;
        default:return "未拼成";
      }
    },
  }
];

const state = reactive({
  total: 0,
  groups: [] as []
});

getGroups(1);

function formatTime() {
  state.groups.forEach((item: any) => {
    item.startTime = item.startTime.slice(0, 19);
    item.startTime = item.startTime.replace("T", " ");
    item.endTime = item.endTime.slice(0, 19);
    item.endTime = item.endTime.replace("T", " ");
  });
}
async function getGroups(page: number) {
  console.log(page);
  const groupRes = await $axios.post("/group/page", { page, size: 6 });
  state.groups = groupRes.data.rows;
  state.total = groupRes.data.total;
  formatTime();
}

</script>

<template>
  <Table class="table" stripe :columns="columns" :data="state.groups">
  </Table>
  <div class="pagination">
    <Page :total="state.total" :page-size="6" @on-change="getGroups($event)" />
  </div>
</template>


<style lang="scss" scoped>
.button {
  margin: 20px 20px 0 20px;
}
.table {
  margin: 20px;
}
.pagination {
  text-align: right;
  padding-right: 100px;
}
</style>
