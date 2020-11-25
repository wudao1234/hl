<template>
	<view>
		<view class="cu-bar search bg-white">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="商品名、条码" confirm-type="search"></input>
			</view>
			<view class="action">
				<button class="cu-btn bg-red round" @click="scanGoods">扫码</button>
			</view>
		</view>
		<uni-list>
			<uni-list-item v-for="goods in goodsList" :key="goods.id"
				:show-badge="true" :badge-text="formatQuantity(goods.stockCount)" 
				:title="goods.name"
				:note="formatNote(goods.sn, goods.price, goods.monthsOfWarranty)"
				@click="chooseGoods(goods)" />
		</uni-list>
		<view class="cu-modal" :class="showModal?'show':''">
			<view class="cu-dialog">
				<view class="cu-bar bg-white justify-end">
					<view class="content">确认数量和价格</view>
					<view class="action" @tap="hideModal">
						<text class="cuIcon-close text-grey"></text>
					</view>
				</view>
				<view>
					<view class="cu-form-group">
						<view class="title">数量</view>
						<uni-number-box :min="1" :max="9999" :value="goodsQuantityInitial" @change="changeQuantity" />
					</view>
					<view class="cu-form-group">
						<view class="title">价格</view>
						<uni-number-box :step="0.01" :min="0.01" :max="999" :value="goodsPrice" @change="changePrice" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideModal">取消</button>
						<button class="cu-btn bg-green margin-left" @tap="addGoods">确定</button>
					</view>
				</view>
			</view>
		</view>
		<view class="uni-loadmore" v-if="showLoadMore">{{loadMoreText}}</view>
	</view>
</template>

<script>
	import {uniList, uniListItem, uniNumberBox} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniNumberBox},
		data() {
			return {
				goodsList: [],
				totalCount: 0,
				currentPage: 0,
				pageCount: 10,
				showLoadMore: false,
				loadMoreText: '',
				loading: false,
				searchValue: '',
				showModal: false,
				goods: null,
				goodsQuantityInitial: 1,
				goodsPrice: 0,
				selectedGoods: [],
			}
		},
		computed: {
			formatQuantity() {
				return (quantity) => {
					return this.accounting.formatNumber(quantity);
				}
			},
			formatNote() {
				return (sn, price, monthsOfWarranty) => {
					let warranty;
					if (monthsOfWarranty % 12 == 0) {
						warranty = `${monthsOfWarranty / 12}年`;
					}
					else if (monthsOfWarranty > 12) {
						warranty = `${Math.floor(monthsOfWarranty / 12)}年${monthsOfWarranty % 12}月`;
					}
					return sn + ' | ' + this.accounting.formatMoney(price) + ' | ' + warranty;
				}
			},
		},
		methods: {
			loadGoods() {
				this.loading = true;
				this.api.get("/api/goods?size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "")).then(res => {
					this.goodsList = this.goodsList.concat(res.data.content);
					this.totalCount = res.data.totalElements;
					if (this.totalCount < this.pageCount) {
						this.showLoadMore = true;
						this.loadMoreText = '没有更多数据了！';
					}
					if (this.totalCount == 0) {
						this.showLoadMore = true;
						this.loadMoreText = '没有找到符合条件的数据！';
					}
				}).finally(() => {
					this.loading = false;
					uni.stopPullDownRefresh();
				});
			},
			search() {
				this.goodsList = [];
				this.currentPage = 0;
				this.loadGoods();
			},
			chooseGoods(goods) {
				this.goods = goods;
				this.goodsPrice = goods.price;
				this.goodsQuantityInitial = 1;
				this.showModal = true;
			},
			changeQuantity(value) {
				this.goodsQuantityInitial = parseInt(value);
			},
			changePrice(value) {
				this.goodsPrice = parseFloat(value);
			},
			scanGoods() {
				uni.scanCode({
					success: (res) => {
						this.searchValue = res.result;
						this.search();
					}
				});
			},
			addGoods() {
				if (this.goodsPrice > 0) {
					this.goodsPrice = this.goodsPrice.toFixed(2);
				}
				if (this.goodsQuantityInitial < 1) {
					this.goodsQuantityInitial = 1;
				}
				this.selectedGoods.push({
					id: null, // 不需要goods的ID
					sn: this.goods.sn,
					name: this.goods.name,
					packCount: this.goods.packCount,
					quantityInitial: this.goodsQuantityInitial,
					quantity: 0,
					price: this.goodsPrice,
					key: this.goods.id + (new Date()).valueOf(),
				});
				uni.$emit('orderItemsForOrder', this.selectedGoods);
				this.showModal = false;
				uni.hideKeyboard();
				uni.showToast({
					title: '添加成功',
					icon: 'success'
				});
			},
			hideModal() {
				this.showModal = false;
			}
		},
		onLoad() {
			this.loadGoods();
		},
		onPullDownRefresh() {
			this.goodsList = [];
			this.currentPage = 0;
			this.searchValue = '';
			this.loadGoods();
		},
		onReachBottom() {
			if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
				this.loadMoreText = "没有更多数据了!"
				return;
			}
			this.showLoadMore = true;
			this.loadMoreText = "加载中...";
			this.currentPage += 1;
			this.loadGoods();
		},
	}
</script>

<style>
	.uni-loadmore{
		height:80upx;
		line-height:80upx;
		text-align:center;
		padding-bottom:30upx;
	}
</style>
