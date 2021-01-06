<template>
	<view>
		<view class="cu-bar search bg-white segment_area">
			<view class="search-form round">
				<text class="cuIcon-search"></text>
				<input v-model="searchValue" @confirm="search" :adjust-position="false" type="text" placeholder="工号" confirm-type="search" />
			</view>
		</view>
		<view class="content">
			<uni-list>
				<uni-list-item
					v-for="item in datalist"
					clickable
					:key="item.id"
					:show-extra-icon="true"
					:show-badge="true"
					:badge-text="item.num"
					badge-type="success"
					:title="item.username"
					@click="updateUserInfo(item)"
				/>
			</uni-list>
			<view class="uni-loadmore" v-if="showLoadMore">{{ loadMoreText }}</view>
		</view>
	</view>
</template>

<script>
import { uniList, uniListItem } from '@dcloudio/uni-ui';

export default {
	components: {
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
			datalist: [],
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
	methods: {
		loadDataList() {
			this.loading = true;
			this.api
				.get('/api/users?size=' + this.pageCount + '&page=' + this.currentPage + (this.searchValue ? '&num=' + this.searchValue : ''))
				.then(res => {
					if (res.statusCode == 200) {
						this.datalist = this.datalist.concat(res.data.content);
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
			this.datalist = [];
			this.currentPage = 0;
			this.loadDataList();
		},
		updateUserInfo(user) {
			uni.$emit('updateUserInfo', user);
			uni.navigateBack();
		}
	},
	onLoad() {
		this.loadDataList();
	},
	onPullDownRefresh() {
		this.datalist = [];
		this.currentPage = 0;
		this.searchValue = '';
		this.loadDataList();
	},
	onReachBottom() {
		if (this.totalCount <= this.pageCount || this.pageCount * (this.currentPage + 1) >= this.totalCount) {
			this.loadMoreText = '没有更多数据了!';
			return;
		}
		this.showLoadMore = true;
		this.loadMoreText = '加载中...';
		this.currentPage += 1;
		this.loadDataList();
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
