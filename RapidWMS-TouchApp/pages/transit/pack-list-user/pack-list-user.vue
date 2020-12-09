<template>
	<view class="content">
		<uni-list>
			<uni-list-item v-for="pack in packs" clickable
				:key="pack.id" :show-extra-icon="true" 
				:extra-icon="formatIcon(pack.packStatus)" 
				:show-badge="true" :badge-text="formatPrice(pack.totalPrice)"  :badge-type="pack.totalPrice > 0 ? 'error' : 'success'"
				:title="formatTitle(pack)" 
				:note="formatNote(pack.user, pack.packages, pack.packType, pack.description)"
				@click="viewPackDetail(pack.id)" />
		</uni-list>
		<view class="uni-loadmore" v-if="showLoadMore">{{loadMoreText}}</view>
	</view>
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				packs: [],
				showLoadMore: false,
				loadMoreText: '',
			}
		},
		computed:{
			formatTitle() {
				return (pack) => {
					if (pack.address == null) {
						return pack.customer.shortNameCn + ' 自提';
					} else {
						return pack.customer.shortNameCn + ' ' + pack.address.name;
					}
				}
			},
			formatIcon() {
				return () => {
					return {
						color: 'brown',
						size: '22',
						type: 'paperplane'
					};
				}
			},
			formatPrice() {
				return (totalPrice) => {
					return this.accounting.formatMoney(totalPrice);
				}
			},
			formatNote() {
				return (user, packages, packType, description) => {
					const userName = user ? user.username : '未指定';
					let packTypeName;
					switch(packType) {
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
				}
			},
		},
		methods: {
			loadPacks(userId) {
				this.api.get("/api/packs/list_sending_packs_by_user_id/" + userId).then(res => {
					if (res.statusCode == 200) {
						this.packs = this.packs.concat(res.data);
						if (this.packs.length == 0) {
							this.loadMoreText = "该用户没有派送的打包";
							this.showLoadMore = true;
						}
					}
				});
			},
			viewPackDetail(id) {
				uni.navigateTo({
					url: `../pack-detail/pack-detail?id=${id}`,
					animationType: 'slide-in-right'
				});
			},
		},
		onLoad(params) {
			this.userId = params.userid;
			this.loadPacks(this.userId);
			uni.$on('updatePackList', () => {
				this.packs = [];
				this.loadPacks(this.userId);
			});
		},
		onUnload() {
			uni.$off('updatePackList');
		}
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
