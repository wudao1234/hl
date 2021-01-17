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
		<view class="title">页信息</view>
		<uni-list v-for="(item, i) in customerOrderPages" :key="item.id">
			<uni-list-item :show-arrow="false" :title="'第' + (i + 1) + '页'" />
			<uni-list-item :show-arrow="false" :title="'流水:' + item.flowSn" />
			<uni-list-item :show-arrow="false" :title="'拣配人:' + listJoin(item.userGatherings)" />
			<uni-list-item :show-arrow="false" :title="'复核人:' + listJoin(item.userReviewers)" />
			<uni-list-item :show-arrow="false" :title="'状态:' + ORDER_STATUS[item.orderStatus]" />
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
		<view class="title" v-if="num > -1">页码:{{ num + 1 }}</view>
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
		<view v-if="userId">
			<view class="padding flex flex-direction" v-if="orderStatus == 'FETCH_STOCK'">
				<button class="cu-btn bg-red margin-tb-sm lg" v-if="showFetchStockCancelGathering" type="danger" :loading="loading" @click="cancelGathering">取消分拣</button>
				<button class="cu-btn bg-red margin-tb-sm lg" v-if="showGatheringGoods" type="primary" :loading="loading" @click="gatheringGoods">开始分拣</button>
			</view>
			<view class="padding flex flex-direction" v-if="orderStatus == 'GATHERING_GOODS'">
				<button class="cu-btn bg-red margin-tb-sm lg" v-if="showGatheringGoods" type="primary" :loading="loading" @click="gatheringGoods">开始分拣</button>
				<button class="cu-btn bg-blue margin-tb-sm lg" v-if="showFetchStockCancelGathering && showConfirmOrder" type="primary" :loading="loading" @click="scanGoods">
					扫描商品
				</button>
				<button
					class="cu-btn bg-red margin-tb-sm lg"
					v-if="showFetchStockCancelGathering && showConfirmOrder"
					type="primary"
					:loading="loading"
					:disabled="notConfirm()"
					@click="confirmWithSacn"
				>
					{{ this.confirmButtonText() }}
				</button>
				<button class="cu-btn bg-red margin-tb-sm lg" v-if="showFetchStockCancelGathering" type="danger" :loading="loading" @click="cancelGathering">取消分拣</button>
				<button class="cu-btn bg-red margin-tb-sm lg" v-if="showFetchStockCancelGathering && showConfirmOrder" type="danger" :loading="loading" @click="confirmWithNoSacn">
					不扫码一键分拣
				</button>
			</view>
			<view class="padding flex flex-direction" v-if="orderStatus == 'GATHER_GOODS' && showConfirm">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="scanGoods">扫描商品</button>
				<button class="cu-btn bg-red margin-tb-sm lg" type="primary" :loading="loading" :disabled="notConfirm()" @click="confirmWithSacn">
					{{ this.confirmButtonText() }}
				</button>
				<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="cancelConfirm">取消复核</button>
				<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" @click="confirmWithNoSacn">不扫码一键复核</button>
			</view>
		</view>
	</view>
</template>

<script>
import { uniList, uniListItem, uniSteps, uniTag } from '@dcloudio/uni-ui';
const PAGE_SIZE = 1;
const ORDER_STATUS = {
	FETCH_STOCK: '匹配出库',
	GATHERING_GOODS: '正在分拣',
	GATHER_GOODS: '分拣完成',
	CONFIRM: '复核确认',
	PACKAGE: '整理打包',
	SENDING: '物流派送'
};

const ORDER_STATUS_JSON = {
	FETCH_STOCK: 'FETCH_STOCK',
	GATHERING_GOODS: 'GATHERING_GOODS',
	GATHER_GOODS: 'GATHER_GOODS',
	CONFIRM: 'CONFIRM',
	PACKAGE: 'PACKAGE',
	SENDING: 'SENDING'
};

export default {
	components: { uniList, uniListItem, uniSteps, uniTag },
	data() {
		return {
			ORDER_STATUS_JSON,
			ORDER_STATUS,
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
			pageFlowSn: '',
			spageItems: [],
			num: undefined,
			userId: undefined,
			customerOrderPages: [],
			showFetchStockCancelGathering: false,
			showGatheringGoods: false,
			showConfirmOrder: false,
			showConfirm: false
		};
	},
	computed: {
		listJoin() {
			return list => {
				if (list.length === 0) return '';
				return list.reduce((acc, cur) => (acc = acc + cur.username + '/' + cur.num + ','), '');
			};
		},
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
		loadOrderDetail(id, pageFlowSn) {
			const _this = this
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
				this.customerOrderPages = order.customerOrderPages;

				const showFetchStockCancelGathering1 = this.customerOrderPages.find(p => p.userGatherings.length > 0);
				const showFetchStockCancelGathering2 = this.customerOrderPages.find(p => {
					if (this.pageFlowSn) {
						return p.userGatherings.find(u => u.id == this.userId) && p.flowSn === this.pageFlowSn;
					} else {
						return p.userGatherings.find(u => u.id == this.userId);
					}
				});
				this.showFetchStockCancelGathering = showFetchStockCancelGathering1 && showFetchStockCancelGathering2;

				const showGatheringGoods1 = this.customerOrderPages.find(p => p.userGatherings.length > 0);
				const showGatheringGoods2 = this.customerOrderPages.find(p => {
					if (this.pageFlowSn) {
						return p.userGatherings.find(u => u.id == this.userId) && p.flowSn === this.pageFlowSn;
					} else {
						return p.userGatherings.find(u => u.id == this.userId);
					}
				});
				this.showGatheringGoods = !showGatheringGoods1 || !showGatheringGoods2;

				const showConfirmOrder1 = this.customerOrderPages.filter(p => p.userGatherings.find(u => u.id == this.userId)).length === this.customerOrderPages.length;
				const showConfirmOrder2 = this.customerOrderPages.find(
					p => p.userGatherings.find(u => u.id == this.userId) && p.flowSn === this.pageFlowSn && p.orderStatus === this.ORDER_STATUS_JSON.GATHERING_GOODS
				);
				this.showConfirmOrder = showConfirmOrder1 || showConfirmOrder2;

				this.showConfirm = this.customerOrderPages.filter(p => p.flowSn === this.pageFlowSn && p.orderStatus === this.ORDER_STATUS_JSON.CONFIRM).length===0;
console.log(this.showConfirm)
				this.api.get(`/api/stock_flows/findByOrderId/${id}`).then(res => {
					this.stockFlowItems = [...res.data].reverse();
					if (this.pageFlowSn && 'PAGE' === this.pageFlowSn.substr(0, 4)) {
						_this.num = order.customerOrderPages.find(e => e.flowSn === this.pageFlowSn).num;
						console.log(_this.num);
						this.spageItems = this.stockFlowItems.slice(this.num * PAGE_SIZE, this.num * PAGE_SIZE + PAGE_SIZE);
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
			if (!this.userId) {
				uni.showToast({
					title: '请先选择工作人员',
					icon: 'none'
				});
				return;
			}
			this.loading = true;
			this.api
				.get(`/api/customer_orders/gather_goods/${this.orderId}/${this.userId}?pageFlowSn=${this.pageFlowSn ? this.pageFlowSn : ''}`)
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
								this.loadOrderDetail(this.orderId, this.pageFlowSn);
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
				// TODO 确认分拣
				queryString = `/api/customer_orders/${this.orderId}/completeGatherGoods?pageFlowSn=${this.pageFlowSn ? this.pageFlowSn : ''}`;
				this.loading = true;
				this.api.get(queryString).then(res => {
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
				// TODO 确认复核
				this.loading = true;
				this.api.get(`/api/customer_orders/confirm/${this.orderId}/${this.userId}?pageFlowSn=${this.pageFlowSn ? this.pageFlowSn : ''}`).then(res => {
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
						if (!this.userId) {
							uni.showToast({
								title: '请先选择工作人员',
								icon: 'none'
							});
							return;
						}
						this.loading = true;
						this.api.get(`/api/customer_orders/un_gather_goods/${this.orderId}/${this.userId}?pageFlowSn=${this.pageFlowSn ? this.pageFlowSn : ''}`).then(res => {
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
			// TODO 取消复核
			uni.showModal({
				title: '确认对话框',
				content: '确认取消分拣？',
				success: res => {
					if (res.confirm) {
						this.loading = true;
						this.api
							.get(`/api/customer_orders/un_complete_gather_goods/${this.orderId}?pageFlowSn=${this.pageFlowSn ? this.pageFlowSn : ''}`)
							.then(res => {
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
		this.userId = params.userId === 'undefined' ? undefined : params.userId;
		this.pageFlowSn = params.searchValue === '' ? undefined : params.searchValue;
		this.loadOrderDetail(this.orderId, this.pageFlowSn);
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
