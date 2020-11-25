<template>
	<view>
		<checkbox-group class="block" @change="checkboxChange">
			<view class="cu-form-group" v-for="item in wareZones" :key="item.id">
				<view class="title">{{item.name}}</view>
				<checkbox :class="isChecked(item.id) ? 'checked' : ''" :checked="isChecked(item.id)" :value="item.id"></checkbox>
			</view>
		</checkbox-group>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" @click="confirm">确认选择</button>
		</view>
	</view>
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				wareZones: [],
				selectedWareZones: [],
			}
		},
		methods: {
			loadWareZones() {
				this.loading = true;
				this.api.get("/api/ware_zones/all_list").then(res => {
					this.wareZones = res.data;
				});
			},
			checkboxChange(e) {
				this.selectedWareZones = e.detail.value;
			},
			isChecked(id) {
				return this.selectedWareZones.includes(id);
			},
			confirm() {
				uni.$emit('selectedWareZones', this.selectedWareZones);
				uni.navigateBack();
			}
		},
		onLoad(option) {
			this.selectedWareZones = option.selectedWareZones ? option.selectedWareZones.split(',') : [];
			this.loadWareZones();
		}
	}
</script>

<style>

</style>
