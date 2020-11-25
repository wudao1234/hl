<template>
	<view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">数量</view>
				<input class="text-right picker" type="number" v-model="moveCount" @input="changeMoveCount" />
			</view>
			<view class="cu-form-group">
				<view class="title">库位</view>
				<picker mode="multiSelector" @change="bindPickerChange" @columnchange="bindPickerColumnChange" :value="multiIndex" :range="multiArray" disabled>
					<view class="picker">{{targetWareZoneName}}，{{targetWarePositionName}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">质保日期</view>
				<picker mode="date" :value="expireDate" :start="startDate" :end="endDate" @change="bindDateChange">
					<view class="text-right uni-input">{{expireDate}}</view>
				</picker>
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-red margin-tb-sm lg" :loading="loading" @click="moveStock">确认更新质保日期</button>
			</view>
		</form>
	</view>
</template>

<script>
	import {uniNumberBox} from '@dcloudio/uni-ui'
	function getDate(type) {
		const date = new Date();
	
		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let day = date.getDate();
	
		if (type === 'start') {
			year = year - 100;
		} else if (type === 'end') {
			year = year + 100;
		}
		month = month > 9 ? month : '0' + month;;
		day = day > 9 ? day : '0' + day;
	
		return `${year}-${month}-${day}`;
	}
	export default {
		components: {uniNumberBox},
		data() {
			return {
				stockId: '',
				originWarePosition: '',
				loading: false,
				tree: [],
				moveCount: 1,
				description: '',
				minCount: 1,
				maxCount: 1,
				multiIndex: [0, 0],	
				selectedWareZoneIndex: 0,
				startDate:getDate('start'),
				endDate:getDate('end'),
				expireDate: '',
			}
		},
		computed: {
			multiArray() {
				return [
					this.tree.length > 0 ? this.tree.map(item => item.name) : [],
					this.tree.length > 0 && this.tree[this.selectedWareZoneIndex].warePositions.length > 0 ? 
						this.tree[this.selectedWareZoneIndex].warePositions.map(item => item.name) : [],
				];
			},
			targetWareZoneName() {
				return this.tree.length > 0 ? this.tree[this.multiIndex[0]].name : '';
			},
			targetWarePositionName() {
				return this.tree.length > 0 && this.tree[this.multiIndex[0]].warePositions.length > 0 ? 
					this.tree[this.multiIndex[0]].warePositions[this.multiIndex[1]].name : '';
			},
			targetWareZoneId() {
				return this.tree.length > 0 ? this.tree[this.multiIndex[0]].id : '';
			},
			targetWarePositionId() {
				return this.tree.length > 0 && this.tree[this.multiIndex[0]].warePositions.length > 0 ? 
					this.tree[this.multiIndex[0]].warePositions[this.multiIndex[1]].id : '';
			}
		},
		methods: {
			changeMoveCount(e) {
				const value = e.target.value;
				setTimeout(() => { 
					if (value < this.minCount) {
						this.moveCount = this.minCount;
					}
					if (value > this.maxCount) {
						this.moveCount = this.maxCount;
					}
				}, 0);
			},
			bindDateChange(e) {
				this.expireDate = e.target.value
			},
			loadTree() {
				this.api.get("/api/ware_zones/tree").then(res => {
					this.tree = res.data;
					let selectedWareZoneIndex = 0;
					for (let i=0; i < this.tree.length; i++) {
						if (this.tree[i].id == this.originWareZoneId) {
							selectedWareZoneIndex = i;
							break;
						}
					}
					let selectedWarePositionIndex = 0;
					for (let i=0; i < this.tree[selectedWareZoneIndex].warePositions.length; i++) {
						if (this.tree[selectedWareZoneIndex].warePositions[i].id == this.originWarePositionId) {
							selectedWarePositionIndex = i;
							break;
						}
					}
					this.multiIndex = [selectedWareZoneIndex, selectedWarePositionIndex];
					this.selectedWareZoneIndex = selectedWareZoneIndex;
				});
			},
			bindPickerChange(e) {
				this.multiIndex = e.detail.value;
			},
			bindPickerColumnChange(e) {
				if (e.detail.column == 0) {
					this.selectedWareZoneIndex = e.detail.value;
				}
			},
			moveStock() {
				this.loading = true;
				this.api.post("/api/stocks/single_operate", {
					id: this.stockId,
					operate: "expireDate",
					expireDate: this.expireDate, 
					quantity: this.moveCount,
					warePosition: [this.targetWareZoneId, this.targetWarePositionId],
				}).then(res => {
					if (res.statusCode == 201) {
						uni.$emit('operateStockSuccess', true);
						uni.showToast({
							title: '操作成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.navigateBack({
										delta: 2,
									});
								}, 1000);
							}
						});
					}
				});
			}
		},
		onLoad(params) {
			this.stockId = params.id;
			this.moveCount = parseInt(params.count);
			this.maxCount = parseInt(params.count);
			this.originWareZoneId = params.ozid;
			this.originWarePositionId = params.opid;
			this.expireDate = this.moment(Number(params.expireDate)).format("YYYY-MM-DD");
			this.loadTree();		
		}
	}
</script>

<style>	
	.cu-form-group .title {
		min-width: calc(4em + 15px);
	}
</style>
