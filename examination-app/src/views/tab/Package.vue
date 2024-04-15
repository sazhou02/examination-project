<template>
    <div>
        <van-nav-bar title="体检套餐">
        </van-nav-bar>
        <div>
            <van-search v-model="packageName" placeholder="请输入搜索关键词" show-action @search="onSearch">
                <div slot="action" @click="onSearch">搜索</div>
            </van-search>
            <PackageList :list="packageList"/>
        </div>

    </div>
</template>
<script>
import noData from '@/components/noData'
import PackageList from './components/PackageList.vue';
import {
    Toast,
    Dialog
} from 'vant';
import {
    Component,
    Prop,
    Vue,
} from 'vue-property-decorator';
import {
    getPackage
} from '@/api/package'
@Component({
    components: {
        noData,
        PackageList
    }
})
export default class Main extends Vue {
    packageName = "";
    packageList = [];

    async fetchData() {
        Toast.loading();
        const { packageName } = this;
        const { data } = await getPackage({ packageName });
        this.packageList = data;
        Toast.clear();
    };
    onSearch() {
        this.fetchData()
    };
    created() {
        const packageName = this.$route.query.packageName;
        if (packageName) {
            this.packageName = packageName;
            this.fetchData();
        }
    }
    mounted() {
        this.fetchData();
    }

}
</script>
<style lang="scss" scoped>
</style>