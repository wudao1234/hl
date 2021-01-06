<template>
	<view>
		<view class="segment_area">
			<uni-segmented-control class="segment" :current="current" :values="items" @clickItem="onClickItem" style-type="button" active-color="#409eff"></uni-segmented-control>
		</view>
		<uni-list-item clickable :show-arrow="true" :title="userInfo.username" @click="changeUser" />
		<view class="content">
			<view v-show="current === 0">
				<view class="cu-bar search bg-white segment_area">
					<view class="search-form round">
						<text class="cuIcon-search"></text>
						<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="流水号、客户、操作人" confirm-type="search" />
					</view>
					<view class="action">
						<uni-icons type="scan" size="30" @click="scanOrder"></uni-icons>
						<!-- <button class="cu-btn bg-red round" @click="scanOrder">扫码</button> -->
					</view>
				</view>
				<uni-segmented-control
					class="segment"
					:current="currentStatus"
					:values="statusItems"
					@clickItem="onClickStatusItem"
					style-type="text"
					active-color="#1296db"
				></uni-segmented-control>
				<uni-list>
					<uni-list-item
						v-for="order in orders"
						clickable
						:key="order.id"
						:show-extra-icon="true"
						:extra-icon="formatIcon(order.orderStatus)"
						:show-badge="true"
						:badge-text="formatPriceOrGatheringUserName(order)"
						:badge-type="order.totalPrice > 0 ? 'error' : 'success'"
						:title="formatTitle(order.owner.shortNameCn, order.clientStore)"
						:note="formatNote(order.createTime, order.description)"
						@click="viewOrderDetail(order.id)"
					>
						<view slot="body" style="flex: 1;">
							<view class="flex-item">{{ formatTitle(order.owner.shortNameCn, order.clientStore) }}</view>
							<view class="flex-item note">{{ order.description == null || order.description == undefined ? '未说明' : order.description }}</view>
							<view class="flex-item note">{{ formatNoteCreateTime(order.createTime) }}</view>
						</view>
					</uni-list-item>
				</uni-list>
				<view class="uni-loadmore" v-if="showLoadMore">{{ loadMoreText }}</view>
			</view>
			<view v-show="current === 1">
				<view class="cu-bar search bg-white segment_area">
					<view class="action">
						<uni-icons type="plus-filled" color="#007aff" size="30" @click="addPack" />
						<!-- <button class="cu-btn round bg-blue" @click="addPack">新增</button> -->
					</view>
					<view class="search-form round">
						<text class="cuIcon-search"></text>
						<input v-model="searchValue2" @confirm="search2" :adjust-position="false" type="text" placeholder="流水号、说明" confirm-type="search2" />
					</view>
					<view class="action">
						<uni-icons type="scan" size="30" @click="scanPack"></uni-icons>
						<!-- <button class="cu-btn bg-red round" @click="scanPack">扫码</button> -->
					</view>
				</view>
				<uni-segmented-control
					class="segment"
					:current="currentStatus2"
					:values="statusItems2"
					@clickItem="onClickStatusItem2"
					style-type="text"
					active-color="#1296db"
				></uni-segmented-control>
				<uni-list>
					<uni-list-item
						v-for="pack in packs"
						clickable
						:key="pack.id"
						:show-extra-icon="true"
						:extra-icon="formatIcon(pack.packStatus)"
						:show-badge="true"
						:badge-text="formatPrice(pack.totalPrice)"
						:badge-type="pack.totalPrice > 0 ? 'error' : 'success'"
						:title="formatTitle2(pack)"
						@click="viewPackDetail(pack.id)"
					>
						<view slot="body" style="flex: 1;">
							<view class="flex-item">{{ formatTitle2(pack) }}</view>
							<view class="flex-item note">
								{{
									formatNote2(pack.user, pack.packages, pack.packType, pack.description)[0] +
										'|' +
										formatNote2(pack.user, pack.packages, pack.packType, pack.description)[1]
								}}
							</view>
							<view class="flex-item note">{{ formatNote2(pack.user, pack.packages, pack.packType, pack.description)[2] }}</view>
							<view class="flex-item note">{{ formatNote2(pack.user, pack.packages, pack.packType, pack.description)[3] }}</view>
						</view>
					</uni-list-item>
				</uni-list>
				<view class="uni-loadmore" v-if="showLoadMore2">{{ loadMoreText2 }}</view>
			</view>
			<view v-show="current === 2">
				<view class="cu-bar search bg-white  segment_area">
					<view class="action">
						<uni-icons type="plus-filled" color="#007aff" size="30" @click="addAddress"></uni-icons>
						<!-- <button class="cu-btn round bg-blue" @click="addAddress">新增</button> -->
					</view>
					<view class="search-form round">
						<text class="cuIcon-search"></text>
						<input v-model="searchValue3" @confirm="search3" :adjust-position="false" type="text" placeholder="地址、联系人" confirm-type="search3" />
					</view>
					<view class="action">
						<uni-icons type="search" color="#007aff" size="30" @click="search3"></uni-icons>
						<!-- <button class="cu-btn bg-green round" @click="search3">搜索</button> -->
					</view>
				</view>
				<uni-list>
					<uni-list-item
						v-for="address in addressList"
						:key="address.id"
						:show-extra-icon="true"
						:extra-icon="{ color: 'grey', size: '22', type: 'contact-filled' }"
						:title="address.name"
						clickable
						:note="address.addressType.name + ' | ' + address.contact + ' | ' + address.phone"
						@click="viewAddressDetail(address.id)"
					/>
				</uni-list>
				<view class="uni-loadmore" v-if="showLoadMore3">{{ loadMoreText3 }}</view>
			</view>
			<view v-show="current === 3">
				<view class="segment_area">
					<uni-list>
						<uni-list-item
							v-for="user in userList"
							:key="user.id"
							clickable
							:show-extra-icon="true"
							:extra-icon="{ color: 'grey', size: '22', type: 'contact-filled' }"
							:show-badge="true"
							:badge-text="formatCount(user.packCounts, user.packageCounts)"
							:badge-type="'error'"
							:title="user.name"
							:note="user.address"
							@click="viewUserPackList(user.id)"
						/>
					</uni-list>
					<view class="uni-loadmore" v-if="showLoadMore4">{{ loadMoreText4 }}</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
import { uniList, uniListItem, uniSegmentedControl } from '@dcloudio/uni-ui';

export default {
	components: { uniSegmentedControl, uniList, uniListItem },
	data() {
		return {
			userInfo: { username: '请选择工作人员', num: undefined },
			current: 0,
			items: ['分拣订单', '打包管理', '地址管理', '派送统计'],
			current2: 0,
			items2: ['未完成', '已完成', '全部'],
			// orders
			orders: [],
			totalCount: 0,
			currentPage: 0,
			pageCount: 10,
			showLoadMore: false,
			loadMoreText: '',
			loading: false,
			searchValue: '',
			statusItems: ['待分拣', '分拣中', '待复核'],
			currentStatus: 0,
			// packs
			packs: [],
			totalCount2: 0,
			currentPage2: 0,
			pageCount2: 10,
			showLoadMore2: false,
			loadMoreText2: '',
			loading2: false,
			searchValue2: '',
			statusItems2: ['打包', '派送', '签收', '回执', '作废', '全部'],
			currentStatus2: 0,
			// address
			addressList: [],
			totalCount3: 0,
			currentPage3: 0,
			pageCount3: 10,
			showLoadMore3: false,
			loadMoreText3: '',
			loading3: false,
			searchValue3: '',
			// sendingPacks
			sendingPacks: [],
			totalCount4: 0,
			showLoadMore4: false,
			loadMoreText4: '',
			userList: [],
			totalCountUsers: 0
		};
	},
	computed: {
		formatTitle() {
			return (name, sn) => {
				return name + ' ' + sn;
			};
		},
		formatTitle2() {
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
				return this.accounting.formatMoney(order.totalPrice);
			};
		},
		formatCount() {
			return (packCounts, packageCounts) => {
				return `${this.accounting.format(packCounts)}票 / ${this.accounting.format(packageCounts)}件`;
			};
		},
		formatNote() {
			return (createTime, description) => {
				return this.moment(createTime).format('YYYY-MM-DD') + ' | ' + (description == null || description == undefined ? '未说明' : description);
			};
		},
		formatNoteCreateTime() {
			return (createTime, description) => {
				return this.moment(createTime).format('YYYY-MM-DD');
			};
		},
		formatNote2() {
			return (user, packages, packType, description) => {
				console.log(user);
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
				const str = userName + ' | ' + packages + '件 | ' + packTypeName + ' | ' + descriptionResult;
				return str.split('|');
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
		changeUser() {
			console.log(1)
			uni.navigateTo({
				animationType: 'slide-in-right',
				url: '../select-user'
			});
		},
		onClickItem(index) {
			index = index.currentIndex;
			if (this.current !== index) {
				this.current = index;
			}
			if (index == 1 && this.packs.length == 0) {
				this.loadPacks();
			}
			if (index == 2 && this.addressList.length == 0) {
				this.loadAddress();
			}
			if (index == 3 && this.sendingPacks.length == 0) {
				this.loadSendingPacksGroupByUsers();
			}
		},
		onClickItem2(index) {
			if (this.current2 !== index) {
				this.current2 = index;
			}
		},
		onClickItem4(index) {
			if (this.current4 !== index) {
				this.current4 = index;
			}
		},
		loadOrders() {
			this.loading = true;
			this.api
				.get(
					'/api/customer_orders/list_for_gather_confirm?size=' +
						this.pageCount +
						'&page=' +
						this.currentPage +
						(this.searchValue ? '&search=' + this.searchValue : '') +
						this.getFilterQueryString()
				)
				.then(res => {
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
				})
				.finally(() => {
					this.loading = false;
					uni.stopPullDownRefresh();
				});
		},
		loadPacks() {
			this.loading2 = true;
			this.api
				.get('/api/packs?size=' + this.pageCount2 + '&page=' + this.currentPage2 + (this.searchValue2 ? '&search=' + this.searchValue2 : '') + this.getFilterQueryString2())
				.then(res => {
					if (res.statusCode == 200) {
						this.packs = this.packs.concat(res.data.content);
						this.totalCount2 = res.data.totalElements;
						if (this.totalCount2 < this.pageCount2) {
							this.showLoadMore2 = true;
							this.loadMoreText2 = '没有更多数据了！';
						}
						if (this.totalCount2 == 0) {
							this.showLoadMore2 = true;
							this.loadMoreText2 = '没有找到符合条件的数据！';
						}
					}
				})
				.finally(() => {
					this.loading2 = false;
					uni.stopPullDownRefresh();
				});
		},
		loadAddress() {
			this.loading3 = true;
			this.api
				.get('/api/address?size=' + this.pageCount3 + '&page=' + this.currentPage3 + (this.searchValue3 ? '&search=' + this.searchValue3 : ''))
				.then(res => {
					if (res.statusCode == 200) {
						this.addressList = this.addressList.concat(res.data.content);
						this.totalCount3 = res.data.totalElements;
						if (this.totalCount3 < this.pageCount3) {
							this.showLoadMore3 = true;
							this.loadMoreText3 = '没有更多数据了！';
						}
						if (this.totalCount3 == 0) {
							this.showLoadMore3 = true;
							this.loadMoreText3 = '没有找到符合条件的数据！';
						}
					}
				})
				.finally(() => {
					this.loading3 = false;
					uni.stopPullDownRefresh();
				});
		},
		loadSendingPacksGroupByUsers() {
			this.loading4 = true;
			this.api
				.get('/api/packs/list_sending_packs_group_by_users')
				.then(res => {
					if (res.statusCode == 200) {
						this.sendingPacks = this.sendingPacks.concat(res.data);
						this.totalCount4 = res.data.totalElements;
						if (this.totalCount4 == 0) {
							this.showLoadMore4 = true;
							this.loadMoreText4 = '没有找到符合条件的数据！';
						}
						let userList = [];
						let sendingPacks = this.sendingPacks;
						for (var i = 0; i < sendingPacks.length; i++) {
							let findUser = false;
							let userIndex = -1;
							for (var j = 0; j < userList.length; j++) {
								if (userList[j].id == sendingPacks[i].user.id) {
									findUser = true;
									userIndex = j;
									break;
								}
							}
							if (findUser) {
								userList[userIndex].packCounts++;
								userList[userIndex].packageCounts += sendingPacks[i].packages;
							} else {
								userList.push({
									id: sendingPacks[i].user.id,
									name: sendingPacks[i].user.username,
									packCounts: 1,
									packageCounts: sendingPacks[i].packages,
									address: sendingPacks[i].address == null ? '自提 等' : sendingPacks[i].address.name + ' 等'
								});
							}
							userList.sort((a, b) => b.packCounts - a.packCounts);
							this.userList = userList;
						}
					}
				})
				.finally(() => {
					this.loading4 = false;
					uni.stopPullDownRefresh();
				});
		},
		search() {
			this.orders = [];
			this.currentPage = 0;
			this.loadOrders();
		},
		search2() {
			this.packs = [];
			this.currentPage2 = 0;
			this.loadPacks();
		},
		search3() {
			this.addressList = [];
			this.currentPage3 = 0;
			this.loadAddress();
		},
		search4() {
			this.sendingPacks = [];
			this.currentPage4 = 0;
			this.loadSendingPacksGroupByUsers();
		},
		scanOrder() {
			uni.scanCode({
				success: res => {
					this.searchValue = res.result;
					this.search();
				}
			});
		},
		scanPack() {
			uni.scanCode({
				success: res => {
					this.searchValue2 = res.result;
					this.search2();
				}
			});
		},
		scanPack2() {
			uni.scanCode({
				success: res => {
					this.searchValue3 = res.result;
					this.search3();
				}
			});
		},
		viewOrderDetail(id) {
			uni.navigateTo({
				url: `../order-confirm/order-confirm?id=${id}&searchValue=${this.searchValue}`,
				animationType: 'slide-in-right'
			});
		},
		viewPackDetail(id) {
			uni.navigateTo({
				url: `../pack-detail/pack-detail?id=${id}`,
				animationType: 'slide-in-right'
			});
		},
		viewAddressDetail(id) {
			uni.navigateTo({
				url: `../address-detail/address-detail?id=${id}`,
				animationType: 'slide-in-right'
			});
		},
		viewUserPackList(id) {
			uni.navigateTo({
				url: `../pack-list-user/pack-list-user?userid=${id}`,
				animationType: 'slide-in-right'
			});
		},
		onClickStatusItem(index) {
			index = index.currentIndex;
			if (this.currentStatus !== index) {
				this.currentStatus = index;
			}
			this.orders = [];
			this.currentPage = 0;
			this.loadOrders();
		},
		onClickStatusItem2(index) {
			index = index.currentIndex;
			if (this.currentStatus2 !== index) {
				this.currentStatus2 = index;
			}
			this.packs = [];
			this.currentPage2 = 0;
			this.loadPacks();
		},
		onClickStatusItem4(index) {
			if (this.currentStatus4 !== index) {
				this.currentStatus4 = index;
			}
			this.sendingPacks = [];
			this.currentPage4 = 0;
			this.loadSendingPacksGroupByUsers();
		},
		getFilterQueryString() {
			switch (this.currentStatus) {
				case 0:
					return '&orderStatusFilter=1';
				case 1:
					return '&orderStatusFilter=2';
				case 2:
					return '&orderStatusFilter=3';
				default:
					return '';
			}
		},
		getFilterQueryString2() {
			switch (this.currentStatus2) {
				case 0:
					return '&packStatusFilter=5';
				case 1:
					return '&packStatusFilter=6';
				case 2:
					return '&packStatusFilter=7';
				case 3:
					return '&packStatusFilter=8';
				case 4:
					return '&packStatusFilter=9';
				case 4:
					return '&packStatusFilter=5,6,7,8,9';
				default:
					return '';
			}
		},
		getFilterQueryString4() {
			switch (this.currentStatus4) {
				case 0:
					return '&packStatusFilter=5';
				case 1:
					return '&packStatusFilter=6,7';
				default:
					return '';
			}
		},
		addPack() {
			uni.navigateTo({
				url: '../pack-add/pack-add',
				animationType: 'slide-in-bottom'
			});
		},
		addAddress() {
			uni.navigateTo({
				url: '../address-add/address-add',
				animationType: 'slide-in-bottom'
			});
		}
	},
	onLoad() {
		this.loadOrders();
		uni.$on('updateUserInfo', user => {
			console.log(user)
			this.userInfo = user;
		});
		uni.$on('updateConfirmOrderList', id => {
			this.orders = this.orders.filter(order => order.id != id);
		});
		uni.$on('updatePackList', id => {
			this.packs = [];
			this.currentPage2 = 0;
			this.loadPacks();
			this.sendingPacks = [];
			this.currentPage4 = 0;
			this.loadSendingPacksGroupByUsers();
		});
		uni.$on('addPackForPackList', () => {
			this.currentStatus2 = 0;
			this.packs = [];
			this.currentPage2 = 0;
			this.loadPacks();
		});
		uni.$on('updateAddressList', updateItem => {
			let index = null;
			let newItem = null;
			const updateAddressItem = item => {
				for (var i = 0; i < this.addressList.length; i++) {
					if (this.addressList[i].id == item.id) {
						index = i;
						newItem = item;
						break;
					}
				}
				if (index != null && newItem != null) {
					this.addressList.splice(index, 1, newItem);
				}
			};
			if (updateItem.method == 'add') {
				this.addressList.unshift(updateItem.item);
			}
			if (updateItem.method == 'update') {
				updateAddressItem(item);
			}
			if (updateItem.method == 'delete') {
				this.addressList = this.addressList.filter(address => address.id != updateItem.item.id);
			}
		});
	},
	onUnload() {
		uni.$off('updateUserInfo');
		uni.$off('updateConfirmOrderList');
		uni.$off('updatePackList');
		uni.$off('addPackForPackList');
		uni.$off('updateAddressList');
	},
	onPullDownRefresh() {
		switch (this.current) {
			case 0:
				this.orders = [];
				this.currentPage = 0;
				this.searchValue = '';
				this.loadOrders();
				break;
			case 1:
				this.packs = [];
				this.currentPage2 = 0;
				this.searchValue2 = '';
				this.loadPacks();
				break;
			case 2:
				this.addressList = [];
				this.currentPage3 = 0;
				this.searchValue3 = '';
				this.loadAddress();
				break;
			case 3:
				this.sendingPacks = [];
				this.currentPage4 = 0;
				this.searchValue4 = '';
				this.loadSendingPacksGroupByUsers();
				break;
		}
	},
	onReachBottom() {
		switch (this.current) {
			case 0:
				if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
					this.loadMoreText = '没有更多数据了!';
					return;
				}
				this.showLoadMore = true;
				this.loadMoreText = '加载中...';
				this.currentPage += 1;
				this.loadOrders();
				break;
			case 1:
				if (this.totalCount2 <= this.pageCount2 || this.pageCount2 * (this.currentPage2 + 1) >= this.totalCount2) {
					this.loadMoreText2 = '没有更多数据了!';
					return;
				}
				this.showLoadMore2 = true;
				this.loadMoreText2 = '加载中...';
				this.currentPage2 += 1;
				this.loadPacks();
				break;
			case 2:
				if (this.totalCount3 <= this.pageCount3 || this.pageCount3 * (this.currentPage3 + 1) >= this.totalCount3) {
					this.loadMoreText3 = '没有更多数据了!';
					return;
				}
				this.showLoadMore3 = true;
				this.loadMoreText3 = '加载中...';
				this.currentPage3 += 1;
				this.loadAddress();
				break;
			case 3:
				if (this.totalCount3 <= this.pageCount4 || this.pageCount4 * (this.currentPage4 + 1) >= this.totalCount4) {
					this.loadMoreText4 = '没有更多数据了!';
					return;
				}
				this.showLoadMore4 = true;
				this.loadMoreText4 = '加载中...';
				this.currentPage4 += 1;
				this.loadMyOrders();
				break;
		}
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
.note {
	font-size: 12px;
	color: #999;
}
</style>
