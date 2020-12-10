<template>
	<view>
		<view class="cu-bar search bg-white">
			<view class="action">
				<uni-icons type="plus-filled" color="#007aff" size="30" @click="add"></uni-icons>
				<!-- <button type="primary" class="cu-btn round bg-blue" @click="add">新增</button> -->
			</view>
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="流水号、客户、操作人" confirm-type="search"></input>
			</view>
			<view class="action">
				<uni-icons type="scan" size="30" @click="scanOrder"></uni-icons>
			</view>
		</view>
		<uni-segmented-control class='segment' :current="currentStatus" :values="statusItems" @clickItem="onClickStatusItem" style-type="text" active-color="#1296db"></uni-segmented-control>
		<uni-list>
			<uni-list-item  v-for="order in orders" clickable
				:key="order.id" 
				:show-extra-icon="true" 
				:extra-icon="formatIcon(order.orderStatus)" 
				:show-badge="true" 
				:badge-text="formatPrice(order.totalPrice)"  
				:badge-type="order.totalPrice > 0 ? 'primary' : 'default'"
				@click="viewOrderDetail(order.id)" >
				<view slot="body" style="flex: 1;">
					<view class="flex-item">{{formatTitle(order.owner.shortNameCn, order.clientStore)}}</view>
					<view class="flex-item note">{{formatNoteDescription(order.description)}}</view>
					<view class="flex-item note">{{formatNoteTime(order.createTime)}}</view>
				</view >
			</uni-list-item>
		</uni-list>
		<view class="uni-loadmore" v-if="showLoadMore">{{loadMoreText}}</view>
	</view>
</template>

<script>
	import {uniListChat,uniList, uniListItem, uniSegmentedControl} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniListChat,uniList, uniListItem, uniSegmentedControl},
		data() {
			return {
				orders: [],
				totalCount: 0,
				currentPage: 0,
				pageCount: 10,
				showLoadMore: false,
				loadMoreText: '',
				loading: false,
				searchValue: '',
				statusItems: ['准备中', '物流中', '已完成', '已作废'],
				currentStatus: 0,
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
			formatNoteTime() {
				return (createTime) => {
					return this.moment(createTime).format("YYYY-MM-DD HH:mm");
				}
			},
			formatNoteDescription() {
				return (description) => {
					return (description == null || description == undefined ? '未说明' : description);
				}
			},
			formatIcon() {
				return (status) => {
					switch (status) {
						case 'INIT':
							return {
								color: 'grey',
								size: '22',
								type: 'circle'
							};
							break;
						case 'FETCH_STOCK':
							return {
								color: 'gray',
								size: '22',
								type: 'minus'
							};
							break;
						case 'GATHERING_GOODS':
							return {
								color: 'olive',
								size: '22',
								type: 'plus'
							};
							break;
						case 'GATHER_GOODS':
							return {
								color: 'mauve',
								size: '22',
								type: 'download'
							};
							break;	
						case 'CONFIRM':
							return {
								color: 'brown',
								size: '22',
								type: 'compose'
							};
							break;	
						case 'PACKAGE':
							return {
								color: 'purple',
								size: '22',
								type: 'locked'
							};
							break;	
						case 'SENDING':
							return {
								color: 'brown',
								size: '22',
								type: 'paperplane'
							};
							break;	
						case 'CLIENT_SIGNED':
							return {
								color: 'blue',
								size: '22',
								type: 'camera'
							};
							break;		
						case 'COMPLETE':
							return {
								color: 'green',
								size: '22',
								type: 'checkbox-filled'
							};
							break;
						case 'CANCEL':
							return {
								color: 'red',
								size: '22',
								type: 'clear'
							};
							break;
					}
				}
			}
		},
		methods: {
			loadOrders() {
				this.loading = true;
				this.api.get("/api/customer_orders?size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "") + this.getFilterQueryString()).then(res => {
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
			add() {
				uni.navigateTo({
					url: '../add/add',
					animationType: 'slide-in-bottom'
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
			viewOrderDetail(id) {
				uni.navigateTo({
					url: `../detail/detail?id=${id}`,
					animationType: 'slide-in-right'
				});
			},
			onClickStatusItem(index) {
				index = index.currentIndex
				if (this.currentStatus !== index) {
					this.currentStatus = index;
				}
				this.orders = [];
				this.currentPage = 0;
				this.loadOrders();
			},
			getFilterQueryString() {
				switch (this.currentStatus) {
					case 0:
						return '&orderStatusFilter=0,1,2,3,4,5';
					case 1:
						return '&orderStatusFilter=6,7'
					case 2:
						return '&orderStatusFilter=8'
					case 3:
						return '&orderStatusFilter=9'
				}
			}
		},
		onLoad() {
			this.loadOrders();
			uni.$on('addOrderList', (order) => {
				if (this.currentStatus == 0 || this.currentStatus == 3) {
					this.orders.unshift(order);
				}
			});
			uni.$on('cancelOrderList', () => {
				this.orders = [];
				this.currentPage = 0;
				this.searchValue = '';
				this.loadOrders();
			});
			uni.$on('updateOrderList', (id) => {
				this.orders = this.orders.filter(order => order.id != id);
			});
		},
		onUnload() {
			uni.$off('addOrderList');
			uni.$off('cancelOrderList');
			uni.$off('updateOrderList');
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
	.note{
		font-size: 12px;
		color: #999;
	}
</style>
