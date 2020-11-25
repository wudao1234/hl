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
		<view class="title">库存信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="stockQuantity" />
			<uni-list-item :show-arrow="false" :title="warePositionName" />
			<uni-list-item :show-arrow="false" :title="wareZoneName" />
			<uni-list-item :show-arrow="false" :title="isActiveText" />
		</uni-list>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-brown lg" @click="updateExpireDate">修改质保日期</button>
			<button class="cu-btn bg-blue margin-tb-sm lg" @click="moveStock">移库 ~</button>
			<button class="cu-btn bg-green lg" @click="plusStock">盘盈 +</button>
			<button class="cu-btn bg-red margin-tb-sm lg" @click="subjectStock">盘亏 -</button>
			<button class="cu-btn lg" :class="stock.isActive ? 'bg-black' : 'bg-grey'" @click="switchActive">{{stock.isActive ? '冻结 ×' : '解冻 √'}}</button>
		</view>
		<view class="cu-modal" :class="showModal?'show':''">
			<view class="cu-dialog">
				<view class="cu-bar bg-white justify-end">
					<view class="content">{{modalTitle}}</view>
					<view class="action" @tap="hideModal">
						<text class="cuIcon-close text-grey"></text>
					</view>
				</view>
				<view>
					<view class="cu-form-group">
						<view class="title">数量</view>
						<uni-number-box :step="1" :min="1" :max="changeMaxCount" :value="changeCount" @change="changeChangeCount" />
					</view>
					<view class="cu-form-group">
						<view class="title">备注</view>
						<input v-model="description" placeholder="选填" class="input_area" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideModal">取消</button>
						<button class="cu-btn bg-green margin-left" @tap="changeStock">确定</button>
					</view>
				</view>
			</view>
		</view>
	</view>	
</template>

<script>
	import {uniList, uniListItem, uniNumberBox} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniNumberBox},
		data() {
			return {
				stockId: '',
				stock: {
					goods: { customer: {}, goodsType: {}},
					warePosition: { wareZone: {}},
					isActive: true,
				},
				changeCount: 0,
				changeMaxCount: 0,
				modalTitle: '',
				showModal: false,
				description: '',
			}
		},
		computed: {
			formatPrice() {
				return (price) => {
					return this.accounting.formatMoney(price);
				}
			},
			formatDate() {
				return (longTypeDate) => {
					return this.moment(longTypeDate).format('YYYY-MM-DD');
				}
			},
			goodsName() {
				return '名称：' + this.stock.goods.name;
			},
			goodsSn() {
				return '条码：' + this.stock.goods.sn;
			},
			goodsPriceAndUnit() {
				return '价格：' + this.formatPrice(this.stock.goods.price) + ' / 单位：' + this.stock.goods.unit;
			},
			goodsExpireDateAndPackCount() {
				return '质保：' + this.formatDate(this.stock.expireDate) + ' / 规格：' + this.stock.goods.packCount;
			},
			goodsTypeName() {
				return '类别：' + this.stock.goods.goodsType.name;
			},
			customerName() {
				return '所属客户：' + this.stock.goods.customer.name;
			},
			stockQuantity() {
				return '库存数量：' + this.accounting.formatNumber(this.stock.quantity);
			},
			warePositionName() {
				return '所在库位：' + this.stock.warePosition.name;
			},
			wareZoneName() {
				return '所属库区：' + this.stock.warePosition.wareZone.name;
			},
			isActiveText() {
				return '是否冻结：' + (this.stock.isActive ? '否' : '是');
			}
		},
		methods: {
			loadStockDetail(id) {
				this.api.get(`/api/stocks/${id}`).then(res => {
					this.stock = res.data;
				});
			},
			plusStock() {
				this.modalTitle = '盘盈';
				this.changeCount = 1;
				this.changeMaxCount = 999999999;
				this.showModal = true;
			},
			subjectStock() {
				this.modalTitle = '盘亏';
				this.changeCount = 1;
				this.changeMaxCount = this.stock.quantity;
				this.showModal = true;
			},
			changeChangeCount(value) {
				this.changeCount = parseInt(value);
			},
			changeStock() {
				this.showModal = false;
				this.api.post("/api/stocks/single_operate", {
					id: this.stock.id,
					name: this.stock.name,
					operate: this.modalTitle == '盘盈' ? 'increase' : 'decrease',
					description: this.description,
					originWarePosition: this.stock.warePosition.id,
					quantity: this.changeCount,
					warePosition: [this.stock.warePosition.wareZone.id, this.stock.warePosition.id],
				}).then(res => {
					if (res.statusCode == 201) {
						uni.$emit('operateStockSuccess');
						uni.showToast({
							title: '操作成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.navigateBack();
								}, 1000);
							}
						});	
					}
				});
			},
			switchActive() {
				const operate = this.stock.isActive ? '冻结' : '解冻';
				uni.showModal({
					title: operate,
					content: `确认${operate}操作？`,
					success: (res) => {
						if (res.confirm) {
							this.api.post("/api/stocks/activate", {
								selectedRowKeys: [this.stock.id],
								isActive: !this.stock.isActive,
							}).then(res => {
								if (res.statusCode == 201) {
									uni.$emit('operateStockSuccess');
									uni.showToast({
										title: '操作成功',
										icon: 'success',
										success: () => {
											setTimeout(() => {
												uni.navigateBack();
											}, 1000);
										}
									});
									
								}
							});
						}
					}
				});
			},
			updateExpireDate() {
				uni.navigateTo({
					url: `../update-stock-expire-date/update-stock-expire-date?id=${this.stockId}&expireDate=${this.stock.expireDate}&count=${this.stock.quantity}&ozid=${this.stock.warePosition.wareZone.id}&opid=${this.stock.warePosition.id}`,
					animationType: 'slide-in-right'
				});
			},
			moveStock() {
				uni.navigateTo({
					url: `../move-stock/move-stock?id=${this.stockId}&count=${this.stock.quantity}&ozid=${this.stock.warePosition.wareZone.id}&opid=${this.stock.warePosition.id}`,
					animationType: 'slide-in-right'
				});
			},
			hideModal() {
				this.showModal = false;
			},
		},
		onLoad(params) {
			this.stockId = params.id;
			this.loadStockDetail(this.stockId);
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
