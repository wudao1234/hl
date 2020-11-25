<template>
	<view>
		<view class="cu-bar search bg-white">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="流水号、客户、操作人" confirm-type="search"></input>
			</view>
			<view class="action">
				<button class="cu-btn bg-red round" @click="scanOrder">扫码</button>
			</view>
		</view>
		<uni-list>
			<uni-list-item v-for="order in orders" 
				:key="order.id" :show-extra-icon="true" 
				:extra-icon="formatIcon" 
				:show-badge="true" :badge-text="formatPrice(order.totalPrice)"  :badge-type="order.totalPrice > 0 ? 'error' : 'success'"
				:title="formatTitle(order.owner.shortNameCn, order.clientName)" 
				:note="formatNote(order.createTime, order.description)"
				@click="addOrder(order)" />
		</uni-list>
		<view class="uni-loadmore" v-if="showLoadMore">{{loadMoreText}}</view>
	</view>
</template>

<script>
	import {uniList, uniListItem, uniSegmentedControl} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniSegmentedControl},
		data() {
			return {
				customerId: '',
				orders: [],
				totalCount: 0,
				currentPage: 0,
				pageCount: 10,
				showLoadMore: false,
				loadMoreText: '',
				loading: false,
				searchValue: '',
			}
		},
		computed: {
			formatTitle() {
				return (name, sn) => {
					return name + ' ' + sn;
				}
			},
			formatPrice() {
				return (totalPrice) => {
					return this.accounting.formatMoney(totalPrice);
				}
			},
			formatNote() {
				return (createTime, description) => {
					return this.moment(createTime).format("YYYY-MM-DD HH:mm") + ' | ' + (description == null || description == undefined ? '无说明' : description);
				}
			},
			formatIcon() {
				return {
					color: 'brown',
					size: '22',
					type: 'download'
				};
			}
		},
		methods: {
			loadOrders() {
				this.loading = true;
				this.api.get("/api/customer_orders/list_for_pack?customerFilter=" + this.customerId + "&size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "")).then(res => {
					if (res.statusCode == 200) {
						this.orders = this.orders.concat(res.data.content);
						this.totalCount = res.data.totalElements;
						if (this.totalCount < this.pageCount) {
							this.showLoadMore = true;
							this.loadMoreText = '没有更多数据了！';
						}
						if (this.totalCount == 0) {
							this.showLoadMore = true;
							this.loadMoreText = '没有找到符合条件的数据！';
						}
					}
				}).finally(() => {
					this.loading = false;
					uni.stopPullDownRefresh();
				});
			},
			scanOrder() {
				uni.scanCode({
					success: (res) => {
						this.searchValue = res.result;
						this.search();
					}
				});
			},
			search() {
				this.orders = [];
				this.currentPage = 0;
				this.loadOrders();
			},
			addOrder(order) {
				uni.$emit('addOrderForPackList', order);
				uni.showToast({
					title: '添加成功',
					icon: 'success',
				});
			},
		},
		onLoad(params) {
			this.customerId = params.customer;
			this.loadOrders();
		},
		onPullDownRefresh() {
			this.orders = [];
			this.currentPage = 0;
			this.searchValue = '';
			this.loadOrders();
		},
		onReachBottom() {
			if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
				this.loadMoreText = "没有更多数据了!"
				return;
			}
			this.showLoadMore = true;
			this.loadMoreText = "加载中...";
			this.currentPage += 1;
			this.loadOrders();
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
