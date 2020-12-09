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
				:title="goods.name" clickable
				:note="formatNote(goods.sn, goods.price, goods.monthsOfWarranty)"
				@click="chooseGoods(goods)" />
		</uni-list>
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
				selectedGoods: [],
				customerId: '',
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
				this.api.get("/api/goods?goodsCustomerFilter=" + this.customerId + "&size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "")).then(res => {
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
				uni.navigateTo({
					url: `../receive-goods-add-choose/receive-goods-add-choose?goodsId=${goods.id}&customerId=${this.customerId}`,
				});
			},
			scanGoods() {
				uni.scanCode({
					success: (res) => {
						this.searchValue = res.result;
						this.search();
					}
				});
			},
		},
		onLoad(option) {
			this.customerId = option.customerId;
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
