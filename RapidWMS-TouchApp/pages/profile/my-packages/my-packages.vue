<template>
	<view>
		<view class="operate_area">
			<uni-list>
				<view class="action"><uni-list-item clickable :show-arrow="true" title="收车" @click="view_back_car" /></view>
			</uni-list>
		</view>
		<view class="cu-bar bg-white segment_area">
			<view class="action"><button class="cu-btn bg-blue round" @click="scanToSending">扫码派送</button></view>
			<view class="action"><button class="cu-btn bg-green round" @click="startCar">发车</button></view>
		</view>
		<view class="segment_area">
			<uni-segmented-control class="segment" :current="current" :values="items" @clickItem="onClickItem" style-type="text" active-color="#1296db"></uni-segmented-control>
		</view>
		<view class="cu-bar search bg-white segment_area">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="流水号、说明" confirm-type="search" />
			</view>
			<view class="action"><button class="cu-btn bg-red round" @click="scanPack">扫码</button></view>
		</view>
		<view class="content">
			<uni-list>
				<uni-list-item
					v-for="pack in myPacks"
					clickable
					:key="pack.id"
					:show-extra-icon="true"
					:extra-icon="formatIcon(pack.packStatus)"
					:show-badge="true"
					:badge-text="formatPrice(pack.totalPrice)"
					:badge-type="pack.totalPrice > 0 ? 'error' : 'success'"					:title="formatTitle(pack)"
					:note="formatNote(pack.user, pack.packages, pack.packType, pack.description)"
					@click="viewMyPackDetail(pack.id)"
				/>
			</uni-list>
			<view class="uni-loadmore" v-if="showLoadMore">{{ loadMoreText }}</view>
		</view>
	</view>
</template>

<script>
import { uniList, uniListItem, uniSegmentedControl } from '@dcloudio/uni-ui';

export default {
	components: {
		uniSegmentedControl,
		uniList,
		uniListItem
	},
	data() {
		const date = new Date();
		const dispatchSys = [];
		for (let i = 1990; i <= date.getFullYear(); i++) {
			dispatchSys.push(i);
		}
		return {
			items: ['派送中', '已签收', '已回执'],
			myPacks: [],
			totalCount: 0,
			currentPage: 0,
			pageCount: 10,
			showLoadMore: false,
			loadMoreText: '',
			loading: false,
			searchValue: '',
			current: 0,
			dispatchSys,
			dispatchSysValue: undefined
		};
	},
	created() {
		this.loadDispatchSys();
	},
	computed: {
		formatTitle() {
			return pack => {
				if (pack.address == null) {
					return pack.customer.shortNameCn + ' 自提';
				} else {
					return pack.customer.shortNameCn + ' ' + pack.address.name;
				}
			};
		},
		formatPrice() {
			return totalPrice => {
				return this.accounting.formatMoney(totalPrice);
			};
		},
		formatPriceOrGatheringUserName() {
			return order => {
				if (this.currentStatus == 1 || this.currentStatus == 2) {
					return order.userGathering.username;
				} else {
					return this.accounting.formatMoney(order.totalPrice);
				}
			};
		},
		formatNote() {
			return (user, packages, packType, description) => {
				const userName = user ? user.username : '未指定';
				let packTypeName;
				switch (packType) {
					case 'SENDING':
						packTypeName = '市区派送';
						break;
					case 'TRANSFER':
						packTypeName = '外发物流';
						break;
					case 'SELF_PICKUP':
						packTypeName = '自行提取';
						break;
					default:
						packTypeName = '未知';
						break;
				}
				const descriptionResult = description == null || description == undefined || description == '' ? '无说明' : description;
				return userName + ' | ' + packages + '件 | ' + packTypeName + ' | ' + descriptionResult;
			};
		},
		formatIcon() {
			return status => {
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
			};
		}
	},
	methods: {
		view_back_car() {
			uni.navigateTo({
				animationType: 'slide-in-right',
				url: './back-car'
			});
		},
		loadDispatchSys() {
			this.api.get('/api/dispatch_sys').then(res => {
				// this.dispatchSys = res.data.content
			});
		},
		startCar() {
			uni.showModal({
				title: '发车',
				content: '已确认全部货物装车完毕，开始派送？',
				success: res => {
					if (res.confirm) {
						this.loading = true;
						this.api
							.post('/api/dispatch')
							.then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '发车成功',
										icon: 'success'
									});
								} else {
									this.loading = false;
								}
							})
							.finally(() => {
								this.loading = false;
							});
					}
				}
			});
		},
		comeBackCar() {
			uni.showModal({
				title: '收车',
				content: '已确认全部货物签收完毕，完成派送？',
				success: res => {
					if (res.confirm) {
						this.loading = true;
						this.api
							.get('/api/dispatch/finish')
							.then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '收车成功',
										icon: 'success'
									});
								} else {
									this.loading = false;
								}
							})
							.finally(() => {
								this.loading = false;
							});
					}
				}
			});
		},
		onClickItem(index) {
			index = index.currentIndex;
			if (this.current !== index) {
				this.current = index;
			}
			this.myPacks = [];
			this.currentPage = 0;
			this.loadMyPacks();
		},
		loadMyPacks() {
			this.loading = true;
			this.api
				.get(
					'/api/packs/list_my_packs?size=' +
						this.pageCount +
						'&page=' +
						this.currentPage +
						(this.searchValue ? '&search=' + this.searchValue : '') +
						this.getFilterQueryString()
				)
				.then(res => {
					if (res.statusCode == 200) {
						this.myPacks = this.myPacks.concat(res.data.content);
						this.myPacks.sort((a, b) => b.updateTime - a.updateTime);
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
				})
				.finally(() => {
					this.loading = false;
					uni.stopPullDownRefresh();
				});
		},
		search() {
			this.myPacks = [];
			this.currentPage = 0;
			this.loadMyPacks();
		},
		scanToSending() {
			uni.scanCode({
				success: res => {
					this.api.post('/api/packs/sending_by_me_and_flow_sn', res.result).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '受领成功',
								icon: 'success',
								success: () => {
									uni.$emit('addPack');
								}
							});
						} else {
							this.loading = false;
						}
					});
				}
			});
		},
		scanPack() {
			uni.scanCode({
				success: res => {
					this.searchValue = res.result;
					this.search();
				}
			});
		},
		viewMyPackDetail(id) {
			uni.navigateTo({
				url: `../../transit/pack-detail/pack-detail?id=${id}&isEdit=true`,
				animationType: 'slide-in-right'
			});
		},
		getFilterQueryString() {
			switch (this.current) {
				case 0:
					return '&packStatusFilter=6';
				case 1:
					return '&packStatusFilter=7';
				case 2:
					return '&packStatusFilter=8';
				default:
					return '';
			}
		}
	},
	onLoad() {
		this.loadMyPacks();
		uni.$on('updatePackList', id => {
			this.myPacks = this.myPacks.filter(pack => pack.id != id);
		});
		uni.$on('addPack', () => {
			this.myPacks = [];
			this.currentPage = 0;
			this.loadMyPacks();
		});
	},
	onUnload() {
		uni.$off('updatePackList');
		uni.$off('addPack');
	},
	onPullDownRefresh() {
		this.myPacks = [];
		this.currentPage = 0;
		this.searchValue = '';
		this.loadMyPacks();
	},
	onReachBottom() {
		if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
			this.loadMoreText = '没有更多数据了!';
			return;
		}
		this.showLoadMore = true;
		this.loadMoreText = '加载中...';
		this.currentPage += 1;
		this.loadMyPacks();
	}
};
</script>

<style>
.segment_area {
	margin-top: 25upx;
}

.segment_area2 {
	margin-top: 15upx;
}

.uni-loadmore {
	height: 80upx;
	line-height: 80upx;
	text-align: center;
	padding-bottom: 30upx;
}
</style>
