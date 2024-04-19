<script setup lang="ts">
import $axios from "@/axios";
import { forEach } from "lodash";
import { ref, reactive, getCurrentInstance, Suspense} from "vue";
//import { Permission } from "@/model";
const { proxy } = getCurrentInstance() as any;

//表格格式
const columns = [
  {
    title: "体检机构名称",
    key: "n",
  },
  {
    title: "区县",
    key: "name"
  },
  {
    title: "地址",
    key: "address",
  },
  {
    title: "最近的交通站点",
    key: "nearby",
  },
  {
    title: "联系电话",
    key: "telephone",
  },
  {
    title: "公告",
    key: "announcement",
  },
  {
    title: "响应时间",
    key: "responseTime",
  },
  {
    title: "咨询人数",
    key: "consultNum",
  },
  {
    title: "体检人数限制",
    key: "morningLimit",
  },
  {
    title: "操作",
    width: 200,
    slot: "operation",
  },
];

//响应式变量page
const page = reactive({
  params: {
    curPage:1,
    pageSize:20,
  }
});

//响应式变量state
const state = reactive({
  info: {
    name:'',
    modal1:false,
    data:[],
  },
  isOpen: false
});

getData();

async function getData() {
  //初次获得数据
  console.log("@@@@", page.params);
  let res = await $axios.post("examination_center/list", page.params);
  state.info.data = res.data;  
  get_pagesize();
}



//从数据库删除指定行数据
async function del(cname:string) {
  state.info.modal1 = true;
  state.info.name=cname;
  await $axios.post("examination_center/del",state.info);
}

//翻页
async function change_data(event:any){
  page.params.curPage=event;
  const res = await $axios.post("examination_center/list",page.params);
  state.info.data = res.data;
  get_pagesize();
}

async function get_pagesize(){
  const res = await $axios.post("examination_center/count");
  page.params.pageSize=res.data.total * 2;  
}

const formState = reactive({
  name: "",
  address: "",
  nearby: "",
  telephone: "",
  morningLimit: undefined,
  centerId: undefined
});

const validateRules = {
  name: [{ required: true, trigger: "blur" }],
  address: [{ required: true, trigger: "blur" }],
  nearby: [{ required: true, trigger: "blur" }],
  telephone: [{ required: true, trigger: "blur" }],
  morningLimit: [{ required: true, trigger: "blur" }]
};

async function handleEdit(row:Object) {
  formState.name = row.n;
  formState.address = row.address;
  formState.nearby = row.nearby;
  formState.telephone = row.telephone;
  formState.morningLimit = row.morningLimit;
  formState.centerId = row.id;
  state.isOpen = true;
}

async function handleSubmit () {
  console.log(formState);
  const res = await $axios.post("examination_center/updateCenter", formState);
  if (res.status === 200) {
    proxy.$Message.success("保存成功！");
    state.isOpen = false;
  }
  getData();
}

</script>

<template>
  <div>
    <!-- <Input search enter-button="Search" placeholder="Enter something..." /> -->
    <!-- Center主表格 -->
    <Table
      class="table"
      :columns="columns"
      :data="state.info.data"
    >
      <template #operation="{ row, index }">
          <div class="operation">
            <!-- <Button type="error"  @click="del(row.n)">
              <Icon type="md-trash" size="18" />
            </Button> -->
    
            <!-- modal1: 确认从数据库删除指定行数据 -->
            <Button type="primary" style="margin-right: 8px; display: inline-block;" @click="handleEdit(row)">编辑</Button>
            <Button type="error" style="display: inline-block;" @click="state.info.modal1 = true">删除</Button>
            <Modal
                v-model="state.info.modal1"
                title="啊？真删？！"
                @on-ok="del(row.n)"
                @on-cancel="state.info.modal1 = false">
            </Modal>
          </div>
      </template>
    </Table>
    <Page :total="page.params.pageSize"  @on-change='change_data($event)'/>

    <Modal v-model="state.isOpen" title="编辑角色" @on-ok="handleSubmit">
    <Form class="form" :model="formState" :label-width="130" :rules="validateRules">
      <FormItem label="体检机构名称" prop="name">
        <Input v-model="formState.name" placeholder="请输入体检机构名称"></Input>
      </FormItem>
      <FormItem label="地址">
        <Input v-model="formState.address" placeholder="请输入地址"></Input>
      </FormItem>
      <FormItem label="最近的交通站点">
        <Input v-model="formState.nearby" placeholder="请输入最近的交通站点"></Input>
      </FormItem>
      <FormItem label="联系电话">
        <Input v-model="formState.telephone" placeholder="请输入联系电话"></Input>
      </FormItem>
      <FormItem label="体检人数限制">
        <InputNumber v-model="formState.morningLimit" :max="100" :min="1"></InputNumber>
      </FormItem>
    </Form>
  </Modal>
  </div>
</template>

<style lang="scss" scoped>
.table-top {
  margin-bottom: 16px;

  button {
    margin-right: 20px;
  }
}
</style>
