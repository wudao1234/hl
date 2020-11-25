<template>
	<view>
		<form>
			<view class="title_area">基本信息</view>
			<view class="cu-form-group">
				<view class="title">客户</view>
				<picker :disabled="isEdit" @change="bindCustomerChange" :value="customerIndex" :range="myCustomers" range-key="name">
					<view class="picker" v-if="myCustomers.length > 0">{{myCustomers[customerIndex].name}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">入库类型</view>
				<picker @change="bindTypeChange" :value="receiveGoodsTypeIndex" :range="receiveGoodsTypes">
					<view class="picker" v-if="receiveGoodsTypes.length > 0">{{receiveGoodsTypes[receiveGoodsTypeIndex]}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">说明</view>
				<input class="text-right" placeholder="选填" v-model="description"></input>
			</view>
			<view class="button_area">
				<button class='cu-btn bg-green add_item' @click="chooseFromGoods">从商品选择</button>
			</view>
			<view class="title_area">入库明细</view>
			<view class="price_total">
				单品数量：<uni-tag class="price_tag" :circle="true" :text="itemTypes()" type="error" size="small" />
				商品总数：<uni-tag class="price_tag" :circle="true" :text="itemAmounts()" type="error" size="small" />
			</view>
			<uni-list>
				<uni-swipe-action :options="options" v-for="item in items" :key="item.key" @click="bindClickItem(item.key)">
					<uni-list-item :show-arrow="false" 
						:title="formatTitle(item.goods.name, item.quantityInitial)" 
						:note="formatNote(item.goods.sn, item.warePosition.name, item.price)" />
				</uni-swipe-action>
				<view class="empty" v-if="items.length == 0">未选择</view>
			</uni-list>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="saveReceiveGoods">保存入库单</button>
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
			year = year - 60;
		} else if (type === 'end') {
			year = year + 2;
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
				isEdit: false,
				editId: '',
				startDate:getDate('start'),
				endDate:getDate('end'),
				customerIndex: 0,
				customerArray: [],
				receiveGoodsTypeIndex: 0,
				receiveGoodsTypes: ['新增入库', '退货入库'],
				description: '',
				items: [],
				loading: false,
			}
		},
		computed: {
			myCustomers() {
				return this.customerArray;
			},
			formatTitle() {
				return (name, quantity) => {
					return `${this.accounting.formatNumber(quantity)} × ${name}`;
				}
			},
			formatNote() {
				return (sn, warePosition, price) => {
					return `${sn} | ${warePosition} | ${this.accounting.formatMoney(price)}`;
				}
			},
		},
		methods: {
			itemTypes() {			
				const res = [];
				const resultMap = this.items.filter((a) => res.filter(r => r == a.goods.sn).length == 0 && res.push(a.goods.sn));
				//console.log(res);
				return resultMap.length.toString();
			},
			itemAmounts() {
				const result = this.items.reduce((num, item) => num + parseInt(item.quantityInitial), 0);
				//console.log(result);
				return result.toString();
			},
			bindDateChange(e) {
				this.expireDate = e.target.value
			},
			bindCustomerChange(e) {
				if (this.customerIndex != e.target.value) {
					this.customerIndex = e.target.value;
					this.items = [];
				}
			},
			bindTypeChange(e) {
				this.receiveGoodsTypeIndex = e.target.value;
			},
			bindClickItem(value) {
				uni.showActionSheet({
					itemList: ['删除'],
					success: (res) => {
						this.items = this.items.filter(item => item.key != value);
					}
				});
			},
			initData() {
				this.api.get("/api/customers/my_list").then(res => {
					this.customerArray = res.data;
				});
			},
			chooseFromGoods() {
				if (this.customerArray.length > 0) {
					uni.navigateTo({
						url: '../receive-goods-add-from-goods/receive-goods-add-from-goods?customerId=' + this.customerArray[this.customerIndex].id,
						animationType: 'slide-in-bottom'
					});
				}
			},
			saveReceiveGoods() {
				this.loading = true;
				if (this.isEdit) {
					this.api.put("/api/receive_goods", {
						customer: {id: this.customerArray[this.customerIndex].id},
						description: this.description,
						isEdit: true,
						id: this.editId,
						receiveGoodsId: this.editId,
						receiveGoodsType: this.receiveGoodsTypeIndex,
						receiveGoodsItems: this.items,
					}).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '修改成功',
								icon: 'success',
								success: () => {
									setTimeout(() => {
										uni.$emit('updateReceiveGoodsList', {
											method: 'update',
											item: res.data,
										});
										uni.$emit('updateReceiveGoodsDetail', res.data);
										uni.navigateBack();
									}, 1000);
								}
							});
						}
					}).finally(() => {
						this.loading = false;
					});
				} else {
					this.api.post("/api/receive_goods", {
						customer: {id: this.customerArray[this.customerIndex].id},
						description: this.description,
						isEdit: false,
						receiveGoodsType: this.receiveGoodsTypeIndex,
						receiveGoodsItems: this.items,
					}).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '添加成功',
								icon: 'success',
								success: () => {
									setTimeout(() => {
										uni.$emit('updateReceiveGoodsList', {
											method: 'add',
											item: res.data,
										});
										uni.navigateBack();
									}, 1000);
								}
							});
						}
					}).finally(() => {
						this.loading = false;
					});
				}
			}
		},
		onLoad(params) {
			if (params.isEdit) {
				this.isEdit = true;
				this.editId = params.id;
			}
			if (this.isEdit) {
				uni.setNavigationBarTitle({
					title: '修改入库单'
				});
				this.api.get("/api/customers/my_list").then(res => {
					this.customerArray = res.data;
					this.api.get(`/api/receive_goods/${this.editId}`).then(res => {
						for (var i = 0; i < this.customerArray.length; i++) {
							if (this.customerArray[i].id == res.data.customer.id) {
								this.customerIndex = i;
								break;
							}
						}
						const receiveGoodsTypes = ['NEW', 'REJECTED'];
						for (var i = 0; i < receiveGoodsTypes.length; i++) {
							if (receiveGoodsTypes[i] == res.data.receiveGoodsType) {
								this.receiveGoodsTypeIndex = i;
								break;
							}
						}
						this.description = res.data.description;
						this.items = res.data.receiveGoodsItems.map(item => {
							item.key = item.id;
							delete item.id;
							return item;
						});
					});
				});
			} else {
				this.initData();
			}
			uni.$on('add-receive-goods-items', (item) => {  
				this.items.push(item);
			});
		},
		onUnload() {
			uni.$off('add-receive-goods-items');
		}
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
		height: 100upx;
	}
	.add_item {
		margin: 25upx;
	}
	.empty {
		font-size: 25upx;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 50upx;
		color: #777777;
	}
	.price_total {
		font-size: 25upx;
		line-height: 25upx;
		background: #FFFFFF;
		padding: 25upx;
		text-align: center;
		position: relative;
	}
	.price_tag {
		margin-right: 25upx;
	}
</style>
