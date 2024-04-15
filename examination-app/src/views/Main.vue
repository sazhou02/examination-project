<template>
    <div>
        <router-view style="padding-bottom: 50px;" />
        <div id="nav">
            <van-tabbar v-model="active">
                <van-tabbar-item v-for="(item, index) in tabs" :key="index" :icon="item.icon" :to="{name: item.name}">{{item.label}}</van-tabbar-item>
            </van-tabbar>
        </div>
    </div>
</template>

<script>
    import {
        Component,
        Prop,
        Vue,
        Watch
    } from 'vue-property-decorator';
    @Component
    export default class Main extends Vue {
        active = 0;
        tabs = [{
            label: '首页',
            icon: 'wap-home',
            name: 'home'
        },
        {
            label: '找机构',
            icon: 'hospital-introduce',
            name: 'institution'
        },
        {
            label: '找套餐',
            icon: 'disease-bank',
            name: 'package'
        }, {
            label: '我的',
            icon: 'user-o',
            name: 'user'
        }];
        created() {
            
        };
        @Watch('$route', { immediate: true, deep: true })
        watchRoute(newVal, oldVal) {
            this.active = this.tabs.indexOf(this.tabs.find(item => {
                return item.name == this.$route.name
            }))
        }
    }
</script>


<style lang="scss">
    #nav {
        width: 100%;
        position: fixed;
        bottom: 0;
        background-color: #fff;

        .tab-name {
            padding-top: 3px;
            font-size: 1em;
        }

        .tab-icon {
            font-size: 1.3em;
        }
    }
</style>