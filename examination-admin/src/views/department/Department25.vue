<script setup lang="ts">
import $axios from "@/axios";
import { forEach } from "lodash";
import type { Row } from "view-ui-plus";
import { ref, reactive, getCurrentInstance, Suspense} from "vue";
const { proxy } = getCurrentInstance() as any;

//响应式变量state，包括回传数据组datax、按钮控件buttonx、按钮文字textx
let department_id=25,category_id=1;
const state = reactive({
  info: {
    modal:false,
    data1:[{item_id:0,value_type:0,value:Math.random(),text:"请输入"}],//&*&,按category编号
    button1:true,
    text1:"无该项目",
    div1:""
  }
});


//获取该科室就诊人相关信息、控制按钮
let examinee_info = (await $axios.post("queue/examinee_info",{department_id:department_id})).data[0]//&*&
if(examinee_info.name!="无"){
  for(var i=0;i<examinee_info.assRes.length;i ++){
    // 判断当前体检人是否已经体检过该项目
    if (examinee_info.assRes[i].category_id === category_id && examinee_info.assRes[i].status === 0) {
      state.info.button1=false;state.info.text1="提交";
    }
  }
}


//获取项目x检查指标、随机填数
let item_1 = (await $axios.post("item/list",{category_id:category_id})).data; //&*&
for (var i = 1; i < item_1.length; i++) { //&*&
    if(item_1[i].value_type==0){//&*&
      state.info.data1.push({item_id:i,value_type:0,value:Math.random(),text:""});//&*&
    }
    else{
      state.info.data1.push({item_id:i,value_type:1,value:0,text:"请输入"});//&*&
    }
}


//提交项目x
async function submit1(){//&*&
  if(!state.info.button1){
    let data=state.info.data1;//&*&
    let order_id=examinee_info.order_id;
    let start_id=item_1[0].id;
    let doctor_id=localStorage.getItem('uid');
    const send={category_id:category_id,data:data,order_id:order_id,start_id:start_id,doctor_id:doctor_id};
    await $axios.post("examination_result/add",send);//assignment添加医生id、examination_result添加若干记录
    await proxy.$Message.success({ content: "提交成功" });
    state.info.button1=true;
    state.info.text1="已提交";
  }
  else{
    await proxy.$Message.error({ content: "请勿重复提交" });
  }
}

//查看所有排队人员

//有请下一位~天才上单
async function next_examinee(){//&*&
  if(state.info.button1){
    await $axios.post("queue/delete",{order_id:examinee_info.order_id,department_id:department_id});
    await proxy.$Message.success({ content: "项目已全部完成！正在加载下一位......" });
    await $axios.post("assignment/intel",{examinee_id:examinee_info.examinee_id});
    location.reload();
  }
  else{
    await proxy.$Message.error({ content: "请完成所有项目后提交" });
  }
}

</script>

<template>
  <div>
    <b style="font-size: 20px;display: inline-block;margin-left: 2%;color:blue;">当前体检人：{{ examinee_info.name }}</b>
    <Button class="button" type="warning" @click="next_examinee()" >下一位体检人</Button>
    <br><br>


    <Grid :col="1">

      <!--第一框格:血常规-->
      <GridItem>
        <Form :style="{ 'visibility' : state.info.div1  }">
          <FormItem >
              <b style="text-align: left;display: inline-block;font-size: 20px;">项目一：外科检查</b>
              <Button class="button" :disabled='state.info.button1' type="primary" @click="submit1()">{{state.info.text1}}</Button>
          </FormItem>
          <!--&*&-->
          <FormItem v-for="(i, index) in item_1" class="item"> 
            <Row class="text">
              <Col span="2">{{ index+1 }}</Col>
              <Col span="8">{{ i.name }}</Col>
              <!--&*&-->
              <Col v-if="i.value_type==0" span="10"><Input v-model="state.info.data1[index].value"></Input></Col>
              <!--&*&-->
              <Col v-else span="10"><Input v-model="state.info.data1[index].text"></Input></Col>
              <Col span="3">{{ i.unit }}</Col>
            </Row>
          </FormItem>
        </Form>
      </GridItem>
    </Grid>


  </div>
</template>

<style lang="scss" scoped>
.item {
  width: auto;
  height: 10px;
}
.text {
  font-size: 15px;
  height: 50%;
}
.button{
  font-size: 20px;
  float: right;
}
.queue{
  font-size: 25px;
  text-align:center;
  color: red;
  font-weight:bolder;
  margin: auto;
}
.span{
  text-align: center;
  margin: auto;
}
</style>