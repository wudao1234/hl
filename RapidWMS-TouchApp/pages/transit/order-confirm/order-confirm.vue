<template>
	<view>
		<view class="cancel" v-if="orderStatus == 'CANCEL'">订单已作废，原因：{{ cancelDescription }}</view>
		<view class="title">基本信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="customerName" />
			<uni-list-item :show-arrow="false" :title="createTime" />
			<uni-list-item :show-arrow="false" :title="flowSn" />
			<uni-list-item :show-arrow="false" :title="autoIncreaseSn" />
			<uni-list-item :show-arrow="false" title="说明：" />
			<view class="content">{{ description }}</view>
		</uni-list>
		<view class="title">订单客户</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="clientName" />
			<uni-list-item :show-arrow="false" :title="clientAddress" />
			<uni-list-item :show-arrow="false" :title="clientStore" />
			<uni-list-item :show-arrow="false" :title="clientOrderSn" />
			<uni-list-item :show-arrow="false" :title="clientOperator" />
		</uni-list>
		<view class="title">商品出库明细</view>
		<uni-list>
			<uni-list-item
				v-for="item in stockFlowItems"
				:key="item.id"
				:show-arrow="false"
				:title="formatTitle(item.name, item.quantity)"
				:note="formatNote(item.sn, item.warePositionOut, item.expireDate)"
				:show-badge="item.confirm == true"
				:badge-type="formatBadgeType(item)"
				:badge-text="formatBadgeText(item)"
			/>
		</uni-list>
		<view class="title">页信息</view>
		<uni-list>
			<uni-list-item
				v-for="item in spageItems"
				:key="item.id"
				:show-arrow="false"
				:title="formatTitle(item.name, item.quantity)"
				:note="formatNote(item.sn, item.warePositionOut, item.expireDate)"
				:show-badge="item.confirm == true"
				:badge-type="formatBadgeType(item)"
				:badge-text="formatBadgeText(item)"
			/>
		</uni-list>
		<view class="price_total">
			总金额：
			<uni-tag class="price_tag" :circle="true" :text="totalPrice" type="error" size="small" />
		</view>
		<view class="padding flex flex-direction" v-if="orderStatus == 'FETCH_STOCK'">
			<button class="cu-btn bg-red margin-tb-sm lg" type="primary" :loading="loading" @click="gatheringGoods">开始分拣</button>
		</view>
		<view class="padding flex flex-direction" v-if="orderStatus == 'GATHERING_GOODS'">
			<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="scanGoods">扫描商品</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="primary" :loading="loading" :disabled="notConfirm()" @click="confirmWithSacn">
				{{ this.confirmButtonText() }}
			</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="cancelGathering">取消分拣</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="confirmWithNoSacn">不扫码一键分拣</button>
		</view>
		<view class="padding flex flex-direction" v-if="orderStatus == 'GATHER_GOODS'">
			<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="scanGoods">扫描商品</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="primary" :loading="loading" :disabled="notConfirm()" @click="confirmWithSacn">
				{{ this.confirmButtonText() }}
			</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="cancelConfirm">取消复核</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="confirmWithNoSacn">不扫码一键复核</button>
		</view>
	</view>
</template>

<script>
import { uniList, uniListItem, uniSteps, uniTag } from '@dcloudio/uni-ui';
const PAGE_SIZE = 1;
export default {
	components: { uniList, uniListItem, uniSteps, uniTag },
	data() {
		return {
			loading: false,
			customerName: '',
			createTime: '',
			totalPrice: '',
			description: '',
			flowSn: '',
			autoIncreaseSn: '',
			clientName: '',
			clientAddress: '',
			clientStore: '',
			clientOrderSn: '',
			clientOperator: '',
			orderStatus: '',
			orderId: '',
			stockFlowItems: [],
			searchValue: '',
			spageItems: []
		};
	},
	computed: {
		formatTitle() {
			return (name, quantity) => {
				return `${this.accounting.formatNumber(quantity)} × ${name}`;
			};
		},
		formatNote() {
			return (sn, warePosition, expireDate) => {
				return `${warePosition.name} / ${warePosition.wareZone.name} | ${this.moment(expireDate).format('YYYY-MM-DD')} | ${sn}`;
			};
		},
		formatPrice() {
			return (price, quantity) => {
				return this.accounting.formatMoney(price * quantity);
			};
		}
	},
	methods: {
		loadOrderDetail(id, searchValue) {
			this.api.get(`/api/customer_orders/${id}`).then(res => {
				const order = res.data;
				this.customerName = '客户：' + order.owner.name;
				this.totalPrice = this.accounting.formatMoney(order.totalPrice);
				this.createTime = '创建时间：' + this.moment(order.createTime).format('YYYY-MM-DD HH:mm');
				this.description = '' + (order.description ? order.description : '');
				this.flowSn = '流水号：' + order.flowSn;
				this.autoIncreaseSn = '自定义编号：' + order.autoIncreaseSn;

				this.clientName = '名称：' + order.clientName;
				this.clientAddress = '地址：' + (order.clientAddress ? order.clientAddress : '');
				this.clientStore = '门店：' + order.clientStore;
				this.clientOrderSn = '订单号：' + (order.clientOrderSn ? order.clientOrderSn : '');
				this.clientOperator = '操作员：' + (order.clientOperator ? order.clientOperator : '');

				this.orderStatus = order.orderStatus;

				this.api.get(`/api/stock_flows/findByOrderId/${id}`).then(res => {
					this.stockFlowItems = res.data;
					if ('PAGE' === this.searchValue.substr(0, 4)) {
						const num = order.customerOrderPages.find(e => e.flowSn === this.searchValue).num;
						console.log(num)
						this.spageItems = this.stockFlowItems.slice(num * PAGE_SIZE, num * PAGE_SIZE + PAGE_SIZE);
					}
				});
			});
		},
		formatBadgeType(item) {
			return item.confirm == true ? 'error' : 'success';
		},
		formatBadgeText(item) {
			return item.confirm == true ? '已确认' : '未扫描';
		},
		notConfirm() {
			return this.stockFlowItems.some(item => item.confirm == undefined);
		},
		confirmButtonText() {
			if (this.stockFlowItems.every(item => item.confirm == true)) {
				if (this.orderStatus == 'GATHERING_GOODS') {
					return '确认分拣';
				}
				if (this.orderStatus == 'GATHER_GOODS') {
					return '确认复核';
				}
			}
			return '请扫描完毕后确认';
		},
		gatheringGoods() {
			let queryString = '/api/customer_orders/gather_goods';
			this.loading = true;
			this.api
				.post('/api/customer_orders/gather_goods/' + this.orderId)
				.then(res => {
					if (res.statusCode == 201) {
						uni.showToast({
							title: '操作成功',
							icon: 'success',
							success: () => {
								this.orderStatus = 'GATHERING_GOODS';
								setTimeout(() => {
									uni.$emit('updateConfirmOrderList', this.orderId);
								}, 1000);
							}
						});
					}
				})
				.finally(() => {
					this.loading = false;
				});
		},
		confirmWithSacn() {
			this.confirmOrder();
		},
		confirmWithNoSacn() {
			uni.showModal({
				title: '确认对话框',
				content: '以不扫描的方式一键确认？',
				success: res => {
					if (res.confirm) {
						this.confirmOrder();
					}
				}
			});
		},
		confirmOrder() {
			let queryString;
			if (this.orderStatus == 'GATHERING_GOODS') {
				queryString = '/api/customer_orders/' + this.orderId + '/completeGatherGoods';
				this.loading = true;
				this.api.post(queryString).then(res => {
					if (res.statusCode == 201) {
						uni.showToast({
							title: '操作成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.$emit('updateConfirmOrderList', this.orderId);
									uni.navigateBack();
								}, 1000);
							}
						});
					} else {
						this.loading = false;
					}
				});
			}
			if (this.orderStatus == 'GATHER_GOODS') {
				this.loading = true;
				this.api.post('/api/customer_orders/confirm/' + this.orderId).then(res => {
					if (res.statusCode == 201) {
						uni.showToast({
							title: '操作成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.$emit('updateConfirmOrderList', this.orderId);
									uni.navigateBack();
								}, 1000);
							}
						});
					} else {
						this.loading = false;
					}
				});
			}
		},
		cancelGathering() {
			uni.showModal({
				title: '确认对话框',
				content: '确认取消分拣？',
				success: res => {
					if (res.confirm) {
						this.loading = true;
						this.api.post('/api/customer_orders/un_gather_goods/' + this.orderId).then(res => {
							if (res.statusCode == 201) {
								uni.showToast({
									title: '取消成功',
									icon: 'success',
									success: () => {
										setTimeout(() => {
											uni.$emit('updateConfirmOrderList', this.orderId);
											uni.navigateBack();
										}, 1000);
									}
								});
							} else {
								this.loading = false;
							}
						});
					}
				}
			});
		},
		cancelConfirm() {
			uni.showModal({
				title: '确认对话框',
				content: '确认取消分拣？',
				success: res => {
					if (res.confirm) {
						this.loading = true;
						this.api.post('/api/customer_orders/un_complete_gather_goods/' + this.orderId).then(res => {
							if (res.statusCode == 201) {
								uni.showToast({
									title: '取消成功',
									icon: 'success',
									success: () => {
										setTimeout(() => {
											uni.$emit('updateConfirmOrderList', this.orderId);
											uni.navigateBack();
										}, 1000);
									}
								});
							} else {
								this.loading = false;
							}
						});
					}
				}
			});
		},
		scanGoods() {
			uni.scanCode({
				success: res => {
					if (this.includeGoodsSn(res.result)) {
						var scanResult = false;
						for (var i = 0; i < this.stockFlowItems.length; i++) {
							if (this.stockFlowItems[i].sn == res.result) {
								if (this.stockFlowItems[i].confirm != true) {
									this.stockFlowItems[i].confirm = true;
									scanResult = true;
								}
							}
						}
						if (scanResult) {
							this.$forceUpdate();
							uni.showToast({
								title: '扫描成功',
								icon: 'none'
							});
						} else {
							uni.showToast({
								title: '该商品已被扫描过了',
								icon: 'none'
							});
						}
					} else {
						uni.showToast({
							title: '条码不符',
							icon: 'none'
						});
					}
				}
			});
		},
		includeGoodsSn(sn) {
			console.log(sn);
			for (var i = 0; i < this.stockFlowItems.length; i++) {
				if (this.stockFlowItems[i].goods.sn == sn) {
					return true;
				}
			}
			return false;
		}
	},
	onLoad(params) {
		this.orderId = params.id;
		this.searchValue = params.searchValue;
		this.loadOrderDetail(this.orderId, this.searchValue);
	}
};
</script>

<style>
.cancel {
	font-size: 25upx;
	line-height: 25upx;
	color: white;
	background: #e54d42;
	padding: 35upx;
	position: relative;
	text-align: center;
}
.title {
	font-size: 25upx;
	line-height: 25upx;
	color: #777;
	margin: 25upx;
	position: relative;
}
.content {
	font-size: 35upx;
	line-height: 35upx;
	margin: 30upx;
	position: relative;
}
.price_total {
	font-size: 25upx;
	line-height: 25upx;
	background: #ffffff;
	padding: 25upx;
	text-align: center;
	position: relative;
}
.step_area {
	background: #ffffff;
}
.price_tag {
	margin-right: 25upx;
}
.input_area {
	background: #eeeeee;
}
.button_area {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 30upx;
}
</style>
