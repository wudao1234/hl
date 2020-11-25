<template>
	<view>
		<view class="title">商品信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="goodsName" />
			<uni-list-item :show-arrow="false" :title="goodsSn" />
			<uni-list-item :show-arrow="false" :title="goodsPriceAndUnit" />
			<uni-list-item :show-arrow="false" :title="goodsExpireDateAndPackCount" />
			<uni-list-item :show-arrow="false" :title="goodsTypeName" />
			<uni-list-item :show-arrow="false" :title="customerName" />
		</uni-list>
		<view class="title">库存流水信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="operateTime" />
			<uni-list-item :show-arrow="false" :title="operator" />
			<uni-list-item :show-arrow="false" :title="stockFlowType" />
			<uni-list-item :show-arrow="false" :title="stockQuantity" />
			<uni-list-item :show-arrow="false" :title="warePositionOut" />
			<uni-list-item :show-arrow="false" :title="warePositionIn" />
		</uni-list>
	</view>	
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				stockFlowId: '',
				stockFlow: {
					goods: { customer: {}, goodsType: {}},
					warePosition: { wareZone: {}},
				},
			}
		},
		computed: {
			formatDate() {
				return (longTypeDate) => {
					return this.moment(longTypeDate).format('YYYY-MM-DD');
				}
			},
			goodsName() {
				return '名称：' + this.stockFlow.goods.name;
			},
			goodsSn() {
				return '条码：' + this.stockFlow.goods.sn;
			},
			goodsPriceAndUnit() {
				return '价格：' + this.accounting.formatMoney(this.stockFlow.goods.price) + ' / 单位：' + this.stockFlow.goods.unit;
			},
			goodsExpireDateAndPackCount() {
				return '质保：' + this.formatDate(this.stockFlow.expireDate) + ' / 规格：' + this.stockFlow.goods.packCount;
			},
			goodsTypeName() {
				return '类别：' + this.stockFlow.goods.goodsType.name;
			},
			customerName() {
				return '所属客户：' + this.stockFlow.goods.customer.name;
			},
			stockQuantity() {
				return '流水数量：' + this.accounting.formatNumber(this.stockFlow.quantity);
			},
			operateTime() {
				return '操作时间：' + this.moment(this.stockFlow.createTime).format("lll");
			},
			operator() {
				return '操作人：' + this.stockFlow.operator;
			},
			stockFlowType() {
				let type = "";
					switch(this.stockFlow.flowOperateType) {
						case 'IN_ADD':
							type = '新入';
							break;
						case 'IN_CUSTOMER_REJECTED':
							type = '退入';
							break;
						case 'IN_PROFIT':
							type = '盘盈';
							break;
						case 'OUT_LOSSES':
							type = '盘亏';
							break;
						case 'OUT_ORDER_FIT':
							type = '出货';
							break;
						case 'MOVE':
							type = '移库';
							break;
						default:
							type = '未知';
							break;
					}
				return "流水类型：" + type;
			},
			warePositionIn() {
				return '入库库位：' + (this.stockFlow.warePositionIn ? this.stockFlow.warePositionIn.name + ' / ' + this.stockFlow.warePositionIn.wareZone.name : '空');
			},
			warePositionOut() {
				return '出库库位：' + (this.stockFlow.warePositionOut ? this.stockFlow.warePositionOut.name + ' / ' + this.stockFlow.warePositionOut.wareZone.name : '空');
			},
		},
		methods: {
			loadStockFlowDetail(id) {
				this.api.get(`/api/stock_flows/${id}`).then(res => {
					this.stockFlow = res.data;
				});
			},
		},
		onLoad(params) {
			this.stockFlowId = params.id;
			this.loadStockFlowDetail(this.stockFlowId);
		}
	}
</script>

<style>
	.title {
		font-size: 25upx;
		line-height: 25upx;
		color: #777;
		margin: 25upx;
		position: relative;
	}
</style>
