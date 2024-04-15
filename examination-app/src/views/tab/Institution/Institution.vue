<template>
	<div>
		<van-nav-bar title="体检机构" />
		<van-search v-model="searchValue" placeholder="请输入体检机构关键词" :show-action="showAction" reverse-color @search="onSearch"
      @cancel="onCancel" @focus="onFocus" />
		<!-- 筛选排序 -->
		<van-dropdown-menu class="dropdown">
			<van-dropdown-item v-model="orderValue" :options="orderOptions" />
			<van-dropdown-item v-model="districtValue" :options="districtOptions" />
		</van-dropdown-menu>
		<!-- 机构列表 -->
		<InstitutionList ref="institution" :districtId="districtId" :orderRule="orderRule" :searchValue="searchValue" />

	</div>
</template>

<script>
import InstitutionList from '../components/InstitutionList';
import { getDistrict } from "@/api/institution";

export default {
	name: "Vehicle",
	components: {
		InstitutionList
	},
	data() {
		return {
			districtId: 0,
			orderRule: "",
			searchValue: "",
			showAction: false,
			orderValue: 'default',
      districtValue: 0,
			orderOptions: [
        { text: '默认排序', value: 'default' },
        { text: '低价优先', value: 'lowPrice' },
        { text: '高价优先', value: 'highPrice' }
      ],
      districtOptions: []
		}
	},
	watch: {
		districtValue(newVal) {
			this.districtId = newVal;
		},
		orderValue(newVal) {
			this.orderRule = newVal;
		}
	},
	created() {
		getDistrict().then(res => {
			this.districtOptions = res.data.map(item => {
				return { text: item.name, value: item.id };
			});
			this.districtOptions.unshift({ text: '区域', value: 0 });
		})
	},
	methods: {
		onSearch() {
			this.$toast(this.searchValue);
			this.$refs.institution.onLoad();
		},
		onFocus() {
			this.showAction = true;
		},
		onCancel() {
			this.showAction = false;
		}
	}
}
</script>

<style lang="scss" scoped>
.dropdown {
	/deep/ .van-popup--top {
		left: 50%;
	}
}
</style>