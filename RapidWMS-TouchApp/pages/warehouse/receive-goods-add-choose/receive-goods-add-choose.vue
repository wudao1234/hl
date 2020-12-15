<template>
	<view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">商品名称</view>
				{{goods.name}}
			</view>
			<view class="cu-form-group">
				<view class="title">商品条码</view>
				{{goods.sn}}
			</view>
			<view class="cu-form-group">
				<view class="title">库存库位</view>
				<picker mode="selector" :value="indexStocks" @change="bindPickerChangeStocks" :range="arrayStocks">
					<view class="picker">{{arrayStocks[indexStocks]}}</view>
				</picker>
			</view>
			<view class="cu-form-group margin-top">
				<view class="title">入库数量</view>
				<input class="picker text-right" type="number" v-model="count" @input="changeCount" />
			</view>
			<view class="cu-form-group">
				<view class="title">入库件数</view>
				<input class="picker text-right" type="number" v-model="packages" @input="changeCount" />
			</view>
			<view class="cu-form-group">
				<view class="title">价格</view>
				<input class="text-right" type="number" v-model="price" @input="changePrice" />
			</view>
			<view class="cu-form-group">
				<view class="title">商品质保到期</view>
				<picker mode="date" :value="expireDate" :start="startDate" :end="endDate" @change="bindDateChange">
					<view class="picker">{{expireDate}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">目标库位</view>
				<picker mode="multiSelector" @change="bindPickerChange" @columnchange="bindPickerColumnChange" :value="multiIndex" :range="multiArray">
					<view class="picker">{{targetWareZoneName}}，{{targetWarePositionName}}</view>
				</picker>
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue lg" @click="scanWarePosition">扫码确认库位</button>
				<button class="cu-btn bg-red margin-tb-sm lg" :loading="loading" @click="confirm">确认收货</button>
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
				goodsId: '',
				goods: {},
				loading: false,
				expireDate: getDate({
					format: true
				}),
				startDate: getDate('start'),
				endDate: getDate('end'),
				tree: [],
				count: '',
				packages:'',
				minCount: 1,
				maxCount: 999999999,
				minPrice: 0,
				maxPrice: 999999999.99,
				multiIndex: [0, 0],	
				selectedWareZoneIndex: 0,
				price: 0,
				customerId: '',
				arrayStocks: [],
				indexStocks: 0,
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
			},
		},
		methods: {
			changeCount(e) {
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
			changePrice(e) {
				const value = e.target.value;
				this.price = value;
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
			loadGoodsAndStocks() {
				this.api.get(`/api/goods/${this.goodsId}`).then(res => {
					this.goods = res.data;
					this.price = this.goods.price;
					this.loadStocks(this.customerId, this.goods.sn, this.goods.packCount);
				});
			},
			loadStocks(customerId, sn, packCount) {
				this.api.get(`/api/stocks/query_stocks?customerId=${customerId}&goodsSn=${sn}&packCount=${packCount}`).then(res => {
					const stocks = res.data;
					this.arrayStocks.push("选择已有库存的库位");
					stocks.map(stock => {
						this.arrayStocks.push(stock.warePosition.wareZone.name + "/" + stock.warePosition.name + "/质保:" + this.moment(stock.expireDate).format('YYYY-MM-DD') + "/库存:" + stock.quantity);
					});
				});
			},
			bindDateChange(e) {
				this.expireDate = e.target.value
			},
			bindPickerChange(e) {
				this.multiIndex = e.detail.value;
			},
			bindPickerColumnChange(e) {
				if (e.detail.column == 0) {
					this.selectedWareZoneIndex = e.detail.value;
				}
			},
			bindPickerChangeStocks(e) {
				this.indexStocks = e.target.value;
				if (this.indexStocks != 0) {
					const stockInfo = this.arrayStocks[this.indexStocks].split("/");
					const wareZoneName = stockInfo[0];
					const warePositionName = stockInfo[1];
					let index1 = 0;
					let index2 = 0;
					for (var i = 0; i < this.tree.length; i++) {
						if (this.tree[i].name == wareZoneName) {
							// console.log(this.tree[i].name + " -> " + wareZoneName);
							index1 = i;
						}
					}
					for (var i = 0; i < this.tree[index1].warePositions.length; i++) {
						if (this.tree[index1].warePositions[i].name == warePositionName) {
							// console.log(this.tree[index1].warePositions[i].name + " -> " + warePositionName);
							index2 = i;
						}
					}
					this.multiIndex = [index1, index2];
				}
			},
			scanWarePosition() {
				uni.scanCode({
					success: (res) => {
						outer:
						for (let i = 0; i < this.tree.length; i++) {
							for (let j = 0; j < this.tree[i].warePositions.length; j++) {
								if (this.tree[i].warePositions[j].name == res.result) {
									this.multiIndex = [i, j];
									this.selectedWareZoneIndex = i;
									break outer;
								}
							}
						}
					}
				});				
			},
			confirm() {
				if (this.count < this.minCount || this.count > this.maxCount) {
					uni.showToast({
						title: '数量有误',
						icon: 'none',
					});
					return;
				}
				if (this.packages < this.minCount || this.count > this.packages) {
					uni.showToast({
						title: '件数有误',
						icon: 'none',
					});
					return;
				}
				if (this.price < this.minPrice || this.price > this.maxPrice) {
					uni.showToast({
						title: '数量有误',
						icon: 'none',
					});
					return;
				}
				this.loading = true;
				uni.showToast({
					title: '添加成功',
					icon: 'success',
					success: () => {
						setTimeout(() => {
							uni.$emit('add-receive-goods-items', {
								key: this.goodsId + (new Date()).valueOf(),
								goods: { id: this.goodsId, name: this.goods.name, sn: this.goods.sn },
								price: this.price,
								quantityInitial: this.count,
								packagesInitial: this.packages,
								expireDate: this.expireDate,
								warePosition: { id: this.targetWarePositionId, name: this.targetWarePositionName }
							});
							uni.navigateBack();
						}, 1000);
					}
				});
			}
		},
		onLoad(params) {
			this.goodsId = params.goodsId;
			this.customerId = params.customerId;
			this.loadTree();
			this.loadGoodsAndStocks();
		}
	}
</script>

<style>	
	.cu-form-group .title {
		min-width: calc(4em + 15px);
	}
</style>
