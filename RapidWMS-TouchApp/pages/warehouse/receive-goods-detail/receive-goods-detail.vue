<template>
	<view>
		<view class="title">基本信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="'客户名称：' + receiveGoods.customer.name" />
			<uni-list-item :show-arrow="false" :title="'流水号：' + receiveGoods.flowSn" />
			<uni-list-item :show-arrow="false" :title="'入库类型：' + receiveGoodsTypeText" />
			<uni-list-item :show-arrow="false" :title="'说明：' + (receiveGoods.description ? receiveGoods.description : '')" />
			<uni-list-item :show-arrow="false" :title="'操作人：' + receiveGoods.creator" />
			<uni-list-item :show-arrow="false" :title="'入库时间：' + formatTime(receiveGoods.createTime)" />
			<uni-list-item :show-arrow="false" :title="'审核人：' + (receiveGoods.auditor ? receiveGoods.auditor : '未审核')" />
			<uni-list-item :show-arrow="false" :title="'审核时间：' + (receiveGoods.auditTime ? formatTime(receiveGoods.auditTime) : '未审核')" />
		</uni-list>
		<view class="title">入库明细</view>
		<view class="price_total">
			单品数量：<uni-tag class="price_tag" :circle="true" :text="itemTypes()" type="error" size="small" />
			商品总数：<uni-tag class="price_tag" :circle="true" :text="itemAmounts()" type="error" size="small" />
		</view>
		<uni-list>
			<uni-list-item v-for="item in receiveGoods.receiveGoodsItems" :key="item.id" :show-arrow="false" 
				:title="formatTitle(item.goods.name, item.quantityInitial)" 
				:note="formatNote(item.goods.sn, item.warePosition.name, item.price)"
				:show-badge="true" :badge-text="formatAuditNumber(item.quantity)" />
		</uni-list>
		<view class="padding flex flex-direction" v-if="canAudit">
			<button class="cu-btn bg-blue lg" :loading="loading"  @click="auditReceiveGoods">审核入库</button>
			<button class="cu-btn bg-green margin-tb-sm lg" :loading="loading" @click="editReceiveGoods">修改该入库单</button>
			<button class="cu-btn bg-red lg" :loading="loading" @click="deleteReceiveGoods">删除该入库单</button>
		</view>
		<view class="padding flex flex-direction" v-else>
			<button class="cu-btn bg-red lg" :loading="loading" @click="cancelAudit">取消审核</button>
		</view>
	</view>
</template>

<script>
	import {uniList, uniListItem, uniSteps, uniTag} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniSteps, uniTag},
		data() {
			return {
				customerName: '',
				receiveGoodsType: '',
				description: '',
				creator: '',
				createTime: '',
				auditor: '',
				auditTime: '',
				receiveGoods: { customer: {}, receiveGoodsItems: [] },
				loading: false,
				receiveGoodsId: '',
			}
		},
		computed: {
			formatTitle() {
				return (name, quantity) => {
					return `${this.accounting.formatNumber(quantity ? quantity : 0)} × ${name}`;
				}
			},
			formatNote() {
				return (sn, name, price) => {
					return `${sn} | ${name} | ${this.accounting.formatMoney(price)}`;
				}
			},
			formatPrice() {
				return (price, quantity) => {
					return this.accounting.formatMoney(price * quantity);
				}
			},
			formatTime() {
				return (time)  => {
					return this.moment(time).format("YYYY-MM-DD HH:mm");
				}
			},
			formatAuditNumber() {
				return (quantity) => {
					return quantity ? this.accounting.formatNumber(quantity) : '未审核';
				}
			},
			canAudit() {
				return this.receiveGoods.auditTime == null;
			},
			receiveGoodsTypeText() {
				switch (this.receiveGoods.receiveGoodsType){
					case 'NEW':
						return '新增入库';
						break;
					case 'REJECTED':
						return '退货入库';
						break;
					default:
						return '未知类型'
						break;
				}
			}
		},
		methods: {
			itemTypes() {
				const res = [];
				const resultMap = this.receiveGoods.receiveGoodsItems.filter((a) => res.filter(r => r == a.goods.sn).length == 0 && res.push(a.goods.sn));
				//console.log(res);
				return resultMap.length.toString();
			},
			itemAmounts() {
				const result = this.receiveGoods.receiveGoodsItems.reduce((num, item) => num + parseInt(item.quantityInitial), 0);
				//console.log(result);
				return result.toString();
			},
			loadReceiveGoodsDetail(id) {
				this.api.get(`/api/receive_goods/${id}`).then(res => {
					this.receiveGoods = res.data;
				});
			},
			hideModal() {
				this.showModal = false;
			},
			getTypeNumber(receiveGoodsType) {
				switch (receiveGoodsType){
					case 'NEW':
						return 0;
						break;
					case 'REJECTED':
						return 1;
						break;
					default:
						return 0;
						break;
				}
			},
			auditReceiveGoods() {
				uni.showModal({
					title: '确认对话框',
					content: '确认审核通过该入库单？',
					confirmText: '通过',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.receiveGoods.receiveGoodsItems = this.receiveGoods.receiveGoodsItems.map(item => {
								item.quantity = item.quantityInitial;
								delete item.id;
								return item;
							});
							this.receiveGoods.receiveGoodsType = this.getTypeNumber(this.receiveGoods.receiveGoodsType);
							this.api.put("/api/receive_goods/audit", this.receiveGoods).then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '审核成功',
										icon: 'success',
										success: () => {
											setTimeout(() => {
												uni.$emit('updateReceiveGoodsList', {
													method: 'audit',
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
				});
			},
			editReceiveGoods() {
				uni.navigateTo({
					url: `../receive-goods-add/receive-goods-add?isEdit=true&id=${this.receiveGoods.id}`,
					animationType: 'slide-in-right',
				});
			},
			deleteReceiveGoods() {
				uni.showModal({
					title: '确认对话框',
					content: '确认删除该入库单？',
					confirmText: '删除',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.api._delete(`/api/receive_goods/${this.receiveGoodsId}`).then(res => {
								uni.showToast({
									title: '删除成功',
									icon: 'success',
									success: () => {
										setTimeout(() => {
											uni.$emit('updateReceiveGoodsList', {
												method: 'delete',
												item: { id: this.receiveGoodsId },
											});
											uni.navigateBack();
										}, 1000);
									}
								});
							});
						}
					}
				});
			},
			cancelAudit() {
				uni.showModal({
					title: '确认对话框',
					content: '确认取消入库审核？',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.api.put('/api/receive_goods/cancel_audit', {
								id: this.receiveGoodsId,
								receiveGoodsId: this.receiveGoodsId,
							}).then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '取消成功',
										icon: 'success',
										success: () => {
											setTimeout(() => {
												uni.$emit('updateReceiveGoodsList', {
													method: 'cancel_audit',
													item: res.data,
												});
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
		},
		onLoad(params) {
			this.receiveGoodsId = params.id;
			this.loadReceiveGoodsDetail(this.receiveGoodsId);
			uni.$on('updateReceiveGoodsDetail',(newItem)=>{
				this.receiveGoods = newItem;
			});
		},
		onUnload() {
			uni.$off('updateReceiveGoodsDetail');
		},
	}
</script>

<style>
	.cancel {
		font-size: 25upx;
		line-height: 25upx;
		color: white;
		background: #E54D42;
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
	.price_total {
		font-size: 25upx;
		line-height: 25upx;
		background: #FFFFFF;
		padding: 25upx;
		text-align: center;
		position: relative;
	}
	.step_area {
		background: #FFFFFF;
	}
	.price_tag {
		margin-right: 25upx;
	}
	.input_area {
		background: #EEEEEE;
	}
</style>
