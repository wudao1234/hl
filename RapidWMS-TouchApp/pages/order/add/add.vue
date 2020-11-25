<template>
	<view>
		<form>
			<view class="title_area">基本信息</view>
			<view class="cu-form-group">
				<view class="title">客户</view>
				<picker @change="bindCustomerChange" :value="customerIndex" :range="myCustomers" range-key="name">
					<view class="picker" v-if="myCustomers.length > 0">{{myCustomers[customerIndex].name}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">订单说明</view>
				<input placeholder="选填" v-model="description"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">自定义编号</view>
				<input placeholder="不填写则自动递增" v-model="autoIncreaseSn"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">立即出库</view>
				<switch @change="switchFetchStocks" :class="fetchStocks ? 'chekced' : ''" :checked="fetchStocks ? true : false" />
			</view>
			<view class="cu-form-group">
				<view class="title">订单全匹配</view>
				<switch @change="switchAllFit" :class="allFit ? 'chekced' : ''" :checked="allFit ? true : false" />
			</view>
			<view class="cu-form-group">
				<view class="title">重置自定义编号</view>
				<switch @change="switchResetSn" :class="resetSn ? 'chekced' : ''" :checked="resetSn ? true : false" />
			</view>
			<view class="cu-form-group">
				<view class="title">最低质保期</view>
				<picker mode="date" :value="expireDate" :start="startDate" :end="endDate" @change="bindDateChange">
					<view class="uni-input">{{expireDate}}</view>
				</picker>
				<switch @change="switchUseExpireDate" :class="useExpireDate ? 'chekced' : ''" :checked="useExpireDate ? true : false" />
			</view>
			<view class="cu-form-group">
				<view class="title">指定库区</view>
				<input disabled="true" :placeholder="selectedWareZonesText" />
				<button class='cu-btn bg-green' @click="selectWarezone">点击选择</button>
			</view>
			<view class="title_area">订单客户信息</view>
			<view class="cu-form-group">
				<view class="title">订单客户名称</view>
				<input placeholder="必填" v-model="clientName" />
			</view>
			<view class="cu-form-group">
				<view class="title">订单客户门店</view>
				<input placeholder="必填" v-model="clientStore" />
			</view>
			<view class="cu-form-group">
				<view class="title">订单客户地址</view>
				<input placeholder="选填" v-model="clientAddress" />
			</view>
			<view class="cu-form-group">
				<view class="title">客户订单号</view>
				<input placeholder="选填" v-model="clientOrderSn" />
			</view>
			<view class="cu-form-group">
				<view class="title">客户订单操作人</view>
				<input placeholder="选填" v-model="clientOperator" />
			</view>
			<view class="button_area">
				<button class='cu-btn bg-blue add_item' @click="chooseFromGoods">从商品选择</button>
				<button class='cu-btn bg-blue add_item' @click="chooseFromStocks">从库存选择</button>
			</view>
			<view class="title_area">商品出货明细</view>
			<uni-list>
				<uni-swipe-action :options="options" v-for="item in orderItems" :key="item.key" @click="bindClickOrderItem(item.key)">
					<uni-list-item :show-arrow="false" 
						:title="formatTitle(item.name, item.quantityInitial)" 
						:note="formatNote(item.sn, item.price, item.quantityInitial)"
						:show-badge="true" :badge-text="formatPrice(item.price, item.quantityInitial)" />
				</uni-swipe-action>
				<uni-swipe-action :options="options" v-for="stock in orderStocks" :key="stock.key" @click="bindClickOrderStock(stock.key)">
				<uni-list-item :show-arrow="false"
					:title="formatTitle(stock.name, stock.quantityInitial)"
					:note="formatNote(stock.sn, stock.price, stock.quantityInitial)"
					:show-badge="true" :badge-text="formatPrice(stock.price, stock.quantityInitial)" />
				</uni-swipe-action>
			</uni-list>
			<view class="price_total">
				订单总金额：<uni-tag class="price_tag" :circle="true" :text="totalPriceInitial" type="primary" size="small" />
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="saveOrder">保存订单</button>
			</view>
		</form>
	</view>
</template>

<script>
	import {uniList, uniListItem, uniTag, uniSwipeAction} from '@dcloudio/uni-ui'

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
		components: {uniList, uniListItem, uniTag, uniSwipeAction},
		data() {
			return {
				options: [
					{
						text: '删除',
						style: { backgroundColor: 'red' }
					}
				],
				expireDate: getDate({
					format: true
				}),
				startDate:getDate('start'),
				endDate:getDate('end'),
				customerIndex: 0,
				customerArray: [],
				orderItems: [],
				orderStocks: [],
				selectedWareZones: [],
				fetchStocks: true,
				allFit: false,
				resetSn: false,
				useExpireDate: false,
				description: '',
				autoIncreaseSn: '',
				clientName: '',
				clientStore: '',
				clientAddress: '',
				clientOrderSn: '',
				clientOperator: '',
				loading: false,
			}
		},
		computed: {
			myCustomers() {
				return this.customerArray;
			},
			totalPriceInitial() {
				const orderItemsPrice = this.orderItems.map(item => {
					return item.price * item.quantityInitial;
				}).reduce((sum, totalPrice) => sum + totalPrice, 0);
				const orderStocksPrice = this.orderStocks.map(item => {
					return item.price * item.quantityInitial;
				}).reduce((sum, totalPrice) => sum + totalPrice, 0);
				return this.accounting.formatMoney(orderItemsPrice + orderStocksPrice);
			},
			selectedWareZonesText() {
				return `已选择 ${this.selectedWareZones.length} 个库区`;
			},
			formatTitle() {
				return (name, quantity) => {
					return `${this.accounting.formatNumber(quantity)} × ${name}`;
				}
			},
			formatNote() {
				return (sn, price, quantity) => {
					return `${sn} | ${this.accounting.formatMoney(price, '¥')} | 数量:${this.accounting.formatNumber(quantity)}`;
				}
			},
			formatPrice() {
				return (price, quantity) => {
					return this.accounting.formatMoney(price * quantity);
				}
			},
		},
		methods: {
			getNewOption(id) {
				const newOption = this.options;
				newOption.id = id;
				return newOption;
			},
			bindDateChange(e) {
				this.expireDate = e.target.value
			},
			bindCustomerChange(e) {
				this.customerIndex = e.target.value;
			},
			bindClickOrderItem(value) {
				uni.showActionSheet({
					itemList: ['删除'],
					success: (res) => {
						this.orderItems = this.orderItems.filter(item => item.key != value);
					}
				});
			},
			bindClickOrderStock(value) {
				uni.showActionSheet({
					itemList: ['删除'],
					success: (res) => {
						this.orderStocks = this.orderStocks.filter(stock => stock.key != value);
					}
				});
			},
			initData() {
				this.api.get("/api/customers/my_list").then(res => {
					this.customerArray = res.data;
				});
			},
			switchFetchStocks(e) {
				this.fetchStocks = e.detail.value;
			},
			switchAllFit(e) {
				this.allFit = e.detail.value;
			},
			switchResetSn(e) {
				this.resetSn = e.detail.value;
			},
			switchUseExpireDate(e) {
				this.useExpireDate = e.detail.value;
			},
			selectWarezone() {
				uni.navigateTo({
					url: '../warezone-select/warezone-select?selectedWareZones=' + this.selectedWareZones.join(','),
					animationType: 'slide-in-right'
				});
			},
			chooseFromGoods() {
				if (this.customerArray.length > 0) {
					uni.navigateTo({
						url: '../goods-select/goods-select?customer=' + this.customerArray[this.customerIndex],
						animationType: 'slide-in-bottom'
					});
				}
			},
			chooseFromStocks() {
				if (this.customerArray.length > 0) {
					uni.navigateTo({
						url: '../stock-select/stock-select?customer=' + this.customerArray[this.customerIndex],
						animationType: 'slide-in-bottom'
					});
				}
			},
			saveOrder() {
				if (this.clientName == '') {
					uni.showToast({
						title: '订单客户名称必须填写',
						icon: 'none',
					});
					return;
				}
				if (this.clientStore == '') {
					uni.showToast({
						title: '订单客户门店必须填写',
						icon: 'none',
					});
					return;
				}
				if (this.orderItems.length == 0 && this.orderStocks.length == 0) {
					uni.showToast({
						title: '至少选择一项商品',
						icon: 'none',
					});
					return;
				}
				this.loading = true;
				this.api.post("/api/customer_orders?useNewAutoIncreaseSn=" + this.resetSn + "&fetchStocks=" + this.fetchStocks, {
					customer: this.customerArray[this.customerIndex].id,
					description: this.description,
					autoIncreaseSn: this.autoIncreaseSn,
					fetchAll: this.allFit,
					expireDate: this.useExpireDate ? this.expireDate : '',
					clientName: this.clientName,
					clientStore: this.clientStore,
					clientAddress: this.clientAddress,
					clientOrderSn: this.clientOrderSn,
					clientOperator: this.clientOperator,
					targetWareZones: this.selectedWareZones.join(','),
					owner: { id: this.customerArray[this.customerIndex].id },
					customerOrderItems: this.orderItems,
					customerOrderStocks: this.orderStocks,
					useNewAutoIncreaseSn: this.resetSn,
					fetchStocks: this.fetchStocks,
				}).then(res => {
					if (res.statusCode == 201) {
						const data = res.data;
						data.owner = this.customerArray[this.customerIndex];
						uni.$emit('addOrderList', data);
						uni.showToast({
							title: '创建成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.navigateBack();
								}, 1000);
							}
						});
					}
				}).catch(err => {
					console.log(err);
					uni.showToast({
						title: '创建失败',
						icon: 'none'
					});
				}).finally(() => {
					this.loading = false;
				});
			}
		},
		onLoad() {
			this.initData();
			uni.$on('selectedWareZones', (valueWareZone) => {
				this.selectedWareZones = valueWareZone;
			});
			uni.$on('orderItemsForOrder', (valueOrderItems) => {
				this.orderItems = this.orderItems.concat(valueOrderItems);
			});
			uni.$on('orderStocksForOrder', (valueOrderStocks) => {
				this.orderStocks = this.orderStocks.concat(valueOrderStocks);
			});
		},
		onUnload() {
			uni.$off('selectedWareZones');
			uni.$off('orderItemsForOrder');
			uni.$off('orderStocksForOrder');
		},
	}
</script>

<style>
	.title_area {
		font-size: 25upx;
		line-height: 25upx;
		color: #777;
		margin: 25upx;
		position: relative;
	}
	.button_area {
		display: flex;
		justify-content: center;
		height: 120upx;
	}
	.add_item {
		margin: 25upx;
	}
	.right-checkbox {
		margin-left: 10upx;
	}
	.price_total {
		font-size: 25upx;
		line-height: 25upx;
		background: #FFFFFF;
		padding: 25upx;
		text-align: center;
		position: relative;
	}
</style>
