<template>
	<view>
		<view class="cu-bar search bg-white">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="地址、联系人" confirm-type="search"></input>
			</view>
			<view class="action">
				<button class="cu-btn bg-green round" @click="search">搜索</button>
			</view>
		</view>
		<uni-list>
			<uni-list-item v-for="address in addressList" :key="address.id" 
				:show-extra-icon="true" :extra-icon="{color: 'grey', size: '22', type: 'contact-filled'}"
				:title="address.name" 
				:note="address.addressType.name + ' | ' + address.contact + ' | ' + address.phone"
				@click="addAddress(address)" />
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
				addressList: [],
				totalCount: 0,
				currentPage: 0,
				pageCount: 10,
				showLoadMore: false,
				loadMoreText: '',
				loading: false,
				searchValue: '',
			}
		},
		methods: {
			loadAddress() {
				this.loading = true;
				this.api.get("/api/address?size=" + this.pageCount + "&page=" + this.currentPage + (this.searchValue ? "&search=" + this.searchValue : "")).then(res => {
					if (res.statusCode == 200) {
						this.addressList = this.addressList.concat(res.data.content);
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
			search() {
				this.addressList = [];
				this.currentPage = 0;
				this.loadAddress();
			},
			addAddress(address) {
				uni.showToast({
					title: '选择成功',
					icon: 'success',
					success: () => {
						setTimeout(() => {
							uni.$emit('addAddressForPackList', address);
							uni.navigateBack();
						}, 1000);
					}
				});
			},
		},
		onLoad() {
			this.loadAddress();
		},
		onPullDownRefresh() {
			this.addressList = [];
			this.currentPage = 0;
			this.searchValue = '';
			this.loadAddress();
		},
		onReachBottom() {
			if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
				this.loadMoreText = "没有更多数据了!"
				return;
			}
			this.showLoadMore = true;
			this.loadMoreText = "加载中...";
			this.currentPage += 1;
			this.loadAddress();
		},
	}
</script>

<style>
	.uni-loadmore {
		height:80upx;
		line-height:80upx;
		text-align:center;
		padding-bottom:30upx;
	}
</style>
