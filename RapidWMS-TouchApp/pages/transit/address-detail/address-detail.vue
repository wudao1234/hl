<template>
	<view>
		<view class="title">地址基本信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="'地址：' + address.name" />
			<uni-list-item :show-arrow="false" :title="'地址类别：' + (address.addressType == undefined ? '' : address.addressType.name)" />
			<uni-list-item :show-arrow="false" :title="'联系人：' + address.contact" />
			<uni-list-item :show-arrow="false" :title="'联系电话：' + address.phone" @click="callPhone"/>
			<uni-list-item :show-arrow="false" :title="'备注：' + (address.description ? address.description : '')" />
		</uni-list>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-green lg" :loading="loading" @click="editAddress">修改地址</button>
			<button class="cu-btn bg-red margin-tb-sm lg" :loading="loading" @click="deleteAddress">删除地址</button>
		</view>
	</view>
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				addressId: '',
				address: {},
				loading: false,
			}
		},
		methods: {
			loadAddressDetail(id) {
				this.api.get(`/api/address/${id}`).then(res => {
					this.address = res.data;
				});
			},
			editAddress() {
				uni.navigateTo({
					url: `../address-add/address-add?isEdit=true&id=${this.addressId}`,
					animationType: 'slide-in-right',
				});
			},
			deleteAddress() {
				uni.showModal({
					title: '确认对话框',
					content: '确认删除该地址？',
					confirmText: '删除',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.api._delete(`/api/address/${this.addressId}`).then(res => {
								uni.showToast({
									title: '删除成功',
									icon: 'success',
									success: () => {
										setTimeout(() => {
											uni.$emit('updateAddressList', {
												method: 'delete',
												item: { id: this.addressId },
											});
											uni.navigateBack();
										}, 1000);
									}
								});
							});
						}
					}
				});
			},
			callPhone() {
				uni.makePhoneCall({
					phoneNumber: this.address.phone,
				});
			}
		},
		onLoad(params) {
			this.addressId = params.id;
			this.loadAddressDetail(this.addressId);
			uni.$on('updateAddressDetail',(newItem) => {
				this.address = newItem;
			});
		},
		onUnload() {
			uni.$off('updateAddressDetail');
		},
	}
</script>

<style>
	.cancel {
		font-size: 25upx;
		line-height: 25upx;
		color: white;
		background: #E54D42;
		padding: 35upx;
		position: relative;
		text-align: center;
	}
	.title {
		font-size: 25upx;
		line-height: 25upx;
		color: #777;
		margin: 25upx;
		position: relative;
	}
	.price_total {
		font-size: 25upx;
		line-height: 25upx;
		background: #FFFFFF;
		padding: 25upx;
		text-align: center;
		position: relative;
	}
	.step_area {
		background: #FFFFFF;
	}
	.price_tag {
		margin-right: 25upx;
	}
	.input_area {
		background: #EEEEEE;
	}
</style>
