<template>
	<view>
		<view class="cu-bar search bg-white">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="商品名、条码、库位" confirm-type="search"></input>
			</view>
			<view class="action">
				<button class="cu-btn bg-red round" @click="scanGoodsOrWarePosition">扫码</button>
			</view>
		</view>
		<uni-list>
			<uni-list-item v-for="stock in stockList" :key="stock.id" clickable
				:show-badge="true" :badge-text="formatQuantity(stock.quantity)" 
				:title="stock.goods.name"
				:note="formatNote(stock.goods.sn, stock.goods.price, stock.goods.monthsOfWarranty) + ' | ' + formatStockInfo(stock)"
				@click="chooseStocks(stock)" />
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
						<uni-number-box :min="1" :max="9999" :value="stockQuantityInitial" @change="changeQuantity" />
					</view>
					<view class="cu-form-group">
						<view class="title">价格</view>
						<uni-number-box :step="0.01" :min="0.01" :max="999" :value="stockPrice" @change="changePrice" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideModal">取消</button>
						<button class="cu-btn bg-green margin-left" @tap="addStocks">确定</button>
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
				stockList: [],
				totalCount: 0,
				currentPage: 0,
				pageCount: 10,
				showLoadMore: false,
				loadMoreText: '',
				loading: false,
				searchValue: '',
				showModal: false,
				stock: null,
				stockQuantityInitial: 1,
				stockPrice: 0,
				selectedStocks: [],
			}
		},
		computed: {
			formatStockInfo() {
				return (stock) => {
					if (stock) {
						return stock.warePosition.name + ' | ' + stock.warePosition.wareZone.name;
					}
					return '';
				}
			},
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
			loadStocks() {
				this.loading = true;
				this.api.get("/api/stocks?size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "")).then(res => {
					this.stockList = this.stockList.concat(res.data.content);
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
				this.stockList = [];
				this.currentPage = 0;
				this.loadStocks();
			},
			scanGoodsOrWarePosition() {
				uni.scanCode({
					success: (res) => {
						this.searchValue = res.result;
						this.search();
					}
				});
			},
			chooseStocks(stock) {
				this.stock = stock;
				this.stockPrice = stock.goods.price;
				this.stockQuantityInitial = 1;
				this.showModal = true;
			},
			changeQuantity(value) {
				this.stockQuantityInitial = parseInt(value);
			},
			changePrice(value) {
				this.stockPrice = parseFloat(value);
			},
			addStocks() {
				if (this.stockPrice > 0) {
					this.stockPrice = this.stockPrice.toFixed(2);
				}
				if (this.stockQuantityInitial < 1) {
					this.stockQuantityInitial = 1;
				}
				this.selectedStocks.push({
					id: null, //不需要id
					sn: this.stock.goods.sn,
					name: this.stock.goods.name,
					packCount: this.stock.goods.packCount,
					expireDate: this.stock.expireDate,
					quantityInitial: this.stockQuantityInitial,
					quantity: 0,
					price: this.stockPrice,
					warePosition: {
						id: this.stock.warePosition.id,
						wareZone: { id: this.stock.warePosition.wareZone.id }
					},
					goods: { id: this.stock.goods.id },
					key: this.stock.goods.id + (new Date()).valueOf(),
				});
				uni.$emit('orderStocksForOrder', this.selectedStocks);
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
			this.loadStocks();
		},
		onPullDownRefresh() {
			this.stocksList = [];
			this.currentPage = 0;
			this.searchValue = '';
			this.loadStocks();
		},
		onReachBottom() {
			if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
				this.loadMoreText = "没有更多数据了!"
				return;
			}
			this.showLoadMore = true;
			this.loadMoreText = "加载中...";
			this.currentPage += 1;
			this.loadStocks();
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
